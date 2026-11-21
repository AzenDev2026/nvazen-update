#!/bin/sh
# NVazen Update installer.
#
#   sudo ./install.sh              -> /usr/local/bin/nvazen_update (system-wide)
#   ./install.sh                   -> ~/.local/bin/nvazen_update (current user)
#   sudo ./install.sh --uninstall  -> removes both copies
set -e

SRC="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)/nvazen_update"
DEST_BIN="/usr/local/bin"

if [ "${1:-}" = "--uninstall" ]; then
    rm -f "$DEST_BIN/nvazen_update" "${HOME:-/tmp}/.local/bin/nvazen_update" 2>/dev/null || true
    echo "nvazen_update removed."
    exit 0
fi

[ -f "$SRC" ] || {
    echo "error: nvazen_update was not found next to this script" >&2
    exit 1
}

if [ "$(id -u)" != "0" ]; then
    DEST_BIN="${HOME:-/tmp}/.local/bin"
    echo "Not running as root — installing for the current user into $DEST_BIN"
fi

mkdir -p "$DEST_BIN"
if ! install -m 755 "$SRC" "$DEST_BIN/nvazen_update" 2>/dev/null; then
    cp "$SRC" "$DEST_BIN/nvazen_update"
    chmod 755 "$DEST_BIN/nvazen_update"
fi

VERSION="$("$DEST_BIN/nvazen_update" --version | awk '{print $2}')"
echo "nvazen_update $VERSION installed to $DEST_BIN/nvazen_update"
echo
echo "Usage:"
echo "  sudo nvazen_update            check for and apply the latest update"
echo "  nvazen_update --check         check only (exit 100 = update available)"
echo
echo "Optional: create /etc/nvazen-update.conf to change defaults, e.g.:"
echo "  INSTALL_BASE=/opt/nvazen"
