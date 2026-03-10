#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGES=(shell git tmux ssh claude jupyter tools)

if ! command -v stow &>/dev/null; then
    echo "Error: GNU Stow is not installed. Install it first, then re-run."
    echo "  apt: sudo apt-get install stow"
    echo "  brew: brew install stow"
    exit 1
fi

cd "$DOTFILES_DIR"

for pkg in "${PACKAGES[@]}"; do
    if [ -d "$pkg" ]; then
        echo "Stowing $pkg..."
        stow --target="$HOME" --adopt "$pkg"
    fi
done

echo ""
echo "Done! All packages stowed."
echo ""
echo "Template files (copy and fill in secrets on this machine):"
find "$DOTFILES_DIR" -name '*.template' | while read -r tmpl; do
    target="${tmpl%.template}"
    echo "  cp $tmpl $target"
done
