# 🐳 NVazen Update · The Azen Newsroom

> This is **NVazen's automatic update repository** — and the news source behind the
> **News** page of the NVazen Update app. Everything below is shown live inside the
> updater of every NVazen user... including you, right now! 👋

---

## 📰 NVazen News · The ecosystem is growing fast!

### 🩹 Bug-fix round: DeepTerminal 2.6.1 + nvazen_update 1.1.0 (2026-11-21)

A small polish day with two nice improvements:

- **DeepTerminal 2.6.1** — the welcome banner no longer renders as garbled
  characters on first open, and every new tab now runs `clear` automatically
  so it always starts fresh.
- **nvazen_update 1.1.0** — the updater now watches the NVazen components: if
  something is missing (for example DeepTerminal), it says
  *"DeepTerminal not found, update = install latest version"* and reinstalls
  it automatically. The updater is also downloadable and installable on its
  own now (see [Install nvazen_update](#-install-nvazen_update) below).

### 🚀 NVazen Update is here (2026-11-20)

NVazen no longer needs a full reinstall to stay fresh:

- **Automatic updates** — the updater reads the latest Release of this repo and brings NAAP, DeepTerminal and other components up to date
- **Brand-new interface** — a sidebar with "Software update / System update" and a News page for the latest happenings
- **The Newsroom** — this very page! Open the updater anytime to see what's new in NVazen

### 🧠 NAAP · Smart app nap (App Nap)

NAAP's App Nap technology lets background apps take a nap automatically — saving power and keeping things smooth, and getting smarter with every update.

### 💻 DeepTerminal 2.5.5 · Powerline, your way

The prompt is fully customizable: colors, sharp or rounded arrow ends, showing the user or the path — you decide everything.

### 🎛️ SystemSettings v1.0 · Your system at a glance

A Windows-11-style settings center: dark / light / follow-system themes, quick settings, device info — everything in one place.

### 🧩 The ecosystem family

- **NVazenMenu**: a custom start menu + system info panel
- **ArchiveManager**: a Windows-style archive manager
- **sysfetch**: a minimal system info tool
- **azen.dev**: the official website, constantly updated (update 29+)
- **Azenium browser**: in development 👀

### 📅 Coming soon

| Project | What it is | Status |
| --- | --- | --- |
| System update | One-click upgrade of the whole NVazen system | 🚧 Coming soon |
| Azenium | NVazen's own browser | 🚧 In development |

### 📊 Ecosystem at a glance

| Project | What it is | Status |
| --- | --- | --- |
| NAAP | Smart app nap (App Nap) | ✅ Constantly updated |
| DeepTerminal | Multi-purpose terminal | ✅ Constantly updated |
| SystemSettings | Settings center | ✅ v1.0 |
| NVazen Update | Automatic updater | ✅ Just launched |

---

### Missing components heal themselves

The updater knows the NVazen components (DeepTerminal today, more as they
ship in packages). Before each update it checks whether they are installed —
and when one is missing, the update simply doubles as a fresh install of its
latest version:

```
[nvazen_update] DeepTerminal not found, update = install latest version
```

That also means deleting a component by accident is not a problem: the next
update (or `--check`, which reports it with exit code 100) brings it right
back.

## 🛠 Install nvazen_update

### Option 1 — from this repository (recommended)

```bash
git clone https://github.com/AzenDev2026/nvazen-update.git
cd nvazen-update
sudo ./install.sh          # installs to /usr/local/bin
```

Running `./install.sh` without `sudo` installs it for the current user into
`~/.local/bin` instead. Remove it anytime with `sudo ./install.sh --uninstall`.

### Option 2 — one line, no clone

```bash
curl -fsSL https://raw.githubusercontent.com/AzenDev2026/nvazen-update/main/install.sh -o /tmp/nvazen-install.sh && sudo sh /tmp/nvazen-install.sh
```

### Option 3 — from the latest Release

Every [Release](https://github.com/AzenDev2026/nvazen-update/releases)
attaches an update package (tar.gz) that contains `nvazen_update`, `lead.txt`
and the latest components. Download it, extract the updater from it, and let
it install the package:

```bash
tar -xzf nvazen-update-v0.2.0.tar.gz
chmod +x nvazen_update
sudo ./nvazen_update --package nvazen-update-v0.2.0.tar.gz
```

After the first install, updates come from the updater itself:
`sudo nvazen_update` (or `nvazen_update --check` to only look).

## 🛠 How this repository works

### How updates flow

```
nvazen_update (on the system)
   │  1. Queries the latest Release (the tag is the version)
   ▼
GitHub Release (this repo)
   │  2. Downloads the update package (zip / tar.gz) and extracts it
   ▼
lead.txt (inside the package)
   │  3. Runs the install instructions line by line
   ▼
Target location (default /opt/nvazen/<target>)
```

### lead.txt syntax

| Syntax | Effect |
| --- | --- |
| `# ...` | Comment, ignored |
| `/remove old-target [path]` | Removes the installed old "target" (defaults to `INSTALL_BASE/target`) |
| `/install new-target [path]` | Installs the "target" from the package (defaults to `INSTALL_BASE/target`) |
| `/run script [args...]` | Runs an install script inside the package directory |

Example (this is what updating NAAP looks like):

```text
#this is the nvazen update lead file
#do not change the content unless error happened
/remove old-naap
/install new-naap
```

### Update package structure

An update package is just a zip / tar.gz that **must** contain `lead.txt`:

```
nvazen-update-v0.1.0.zip
├── lead.txt
├── naap/            ← all files of the new NAAP (this is what `install new-naap` installs)
│   └── ...
└── post.sh          ← optional: `/run post.sh` executes it
```

### nvazen_update usage

```
nvazen_update                     # check and apply the latest update
nvazen_update --check             # check only (exit 100 = update available
                                  #   or a component is missing)
nvazen_update --dry-run           # dry run: show what would happen, change nothing
nvazen_update --force             # reapply even when the version is the same
nvazen_update --package pkg.zip   # install a local test package, skipping the network
```

### Publishing a new version (from the web)

1. Open this repo → **Releases** → **Draft a new release**
2. Click **Choose a tag**, enter the new version, e.g. `v0.1.0` → **Create new tag**
3. Give it any title (e.g. `v0.1.0 updates NAAP`) and drag the packaged update into the attachments
4. Click **Publish release**

> **The tag is the version** — every release must use a new, higher tag, otherwise the updater will think there is nothing new.

## License

GPL-3.0, see [LICENSE](LICENSE).
