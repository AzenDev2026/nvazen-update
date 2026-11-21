#!/bin/sh
# DeepTerminal post-install:
#   system-wide icon + launcher + desktop entry (root only; skipped otherwise)
set -e
PKG="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

if [ "$(id -u)" != "0" ]; then
    echo "post.sh: not running as root — skipping the system icon and desktop entry (the DeepTerminal and nvazen_update files themselves are already installed)"
    exit 0
fi

if [ -f "$PKG/deepterminal/deepterm.png" ]; then
    mkdir -p /usr/share/pixmaps
    cp -f "$PKG/deepterminal/deepterm.png" /usr/share/pixmaps/deepterminal.png
fi

cat > /usr/local/bin/deepterminal <<'LAUNCHER'
#!/bin/sh
exec python3 /opt/nvazen/deepterminal/deepter.py "$@"
LAUNCHER
chmod +x /usr/local/bin/deepterminal

cat > /usr/share/applications/deepterminal.desktop <<'DESKTOP'
[Desktop Entry]
Version=1.1
Type=Application
Name=DeepTerminal
GenericName=Terminal
Comment=Native terminal for PowerShell 7, Bash and any shell
Exec=/usr/local/bin/deepterminal
Icon=deepterminal
Terminal=false
Categories=System;TerminalEmulator;
Keywords=terminal;shell;console;pwsh;bash;pty;
StartupNotify=true
StartupWMClass=DeepTerminal
DESKTOP
update-desktop-database /usr/share/applications 2>/dev/null || true
echo "post.sh: created the system launcher and desktop entry"
