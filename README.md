# 🐳 NVazen Update · The Azen Newsroom

> This is **NVazen's automatic update repository** — and the news source behind the
> **News** page of the NVazen Update app. Everything below is shown live inside the
> updater of every NVazen user... including you, right now! 👋

---

## 📰 NVazen News · The ecosystem is growing fast!

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
nvazen_update --check             # only check for a new version (exit code 100 = update available)
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
