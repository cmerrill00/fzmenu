#!/usr/bin/env bash
set -euo pipefail

# Paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FZMENU_SRC="$SCRIPT_DIR/fzmenu.sh"
CONF_SRC="$SCRIPT_DIR/commands.conf"
BIN_DST="/usr/local/bin/fzmenu"
CONF_DST="$HOME/.config/fzf-menu/commands.conf"

# Install fzmenu.sh to /usr/local/bin
echo "Installing fzmenu to $BIN_DST (requires sudo)..."
sudo install -m 755 "$FZMENU_SRC" "$BIN_DST"
echo "fzmenu installed."

# Create config directory and copy commands.conf if missing
mkdir -p "$(dirname "$CONF_DST")"
if [ ! -f "$CONF_DST" ]; then
  cp "$CONF_SRC" "$CONF_DST"
  echo "Copied default commands.conf to $CONF_DST"
else
  echo "commands.conf already exists at $CONF_DST"
fi

# Check for fzf
if ! command -v fzf >/dev/null 2>&1; then
  echo "WARNING: fzf is not installed. Please install fzf to use fzmenu."
else
  echo "fzf is installed."
fi

echo "Installation complete! Run 'fzmenu' from your terminal."

## Installation

### Automatic Installation (Recommended)

1. Clone this repository:
   ```sh
   git clone https://github.com/cmerrill00/fzmenu.git
   cd fzmenu/scripts/fzmenu
   ```
2. Run the install script:
   ```sh
   bash install.sh
   ```
   This will:
   - Install `fzmenu.sh` as `fzmenu` in `/usr/local/bin` (requires sudo)
   - Copy `commands.conf` to `~/.config/fzf-menu/commands.conf` if it doesn't exist
   - Warn you if `fzf` is not installed

3. Run fzmenu from anywhere:
   ```sh
   fzmenu
   ```

### Manual Installation

1. Make the script executable:
   ```sh
   chmod +x fzmenu.sh
   ```
2. Copy `fzmenu.sh` to a directory in your `$PATH` (e.g., `/usr/local/bin`):
   ```sh
   sudo cp fzmenu.sh /usr/local/bin/fzmenu
   ```
3. Create the config directory and copy `commands.conf`:
   ```sh
   mkdir -p ~/.config/fzf-menu
   cp commands.conf ~/.config/fzf-menu/commands.conf
   ```
4. Ensure [fzf](https://github.com/junegunn/fzf) is installed:
   ```sh
   fzf --version
   ```
   If not installed, follow instructions on the [fzf GitHub page](https://github.com/junegunn/fzf).

5. Run fzmenu:
   ```sh
   fzmenu
   ```