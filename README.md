# fzmenu

fzmenu is a Bash-based interactive menu system for Linux, powered by [fzf](https://github.com/junegunn/fzf). It lets you browse categorized command lists, preview their output, and run them—all from your terminal.

## Features

- Browse commands by category
- Preview command output before running
- Easily add, remove, or edit commands via a config file
- "Back" and "Exit" options for easy navigation

## Requirements

- Bash
- [fzf](https://github.com/junegunn/fzf)
- Linux system utilities (most commands are standard)

## Installation

### Automatic Installation (Recommended)

1. Clone this repository:
   ```sh
   git clone https://github.com/cmerrill00/fzmenu.git
   cd fzmenu
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

## Usage

Run the menu:
```sh
fzmenu
```
Or specify a custom config file:
```sh
fzmenu /path/to/your/commands.conf
```

## Configuration: `commands.conf`

The menu is driven by a simple config file (default: `~/.config/fzf-menu/commands.conf`).  
Each line defines a command in the format:

```
Category|Description|Command
```

**Example:**
```
System|Show disk usage|df -h
Network|Show interfaces|ip a
Files|List files in current directory|ls -lh
```

### Adding/Editing Commands

- **Add a new command:**  
  Append a new line with the desired category, description, and command.
- **Edit a command:**  
  Change the description or command part of an existing line.
- **Remove a command:**  
  Delete the corresponding line.

**Tip:**  
You can create new categories by using a new name in the first field.

### Special Navigation

- **Back:** Returns to the category selection.
- **Exit:** Quits the menu.

## Example Categories

See the provided `commands.conf` for a comprehensive set of basic Linux commands, grouped by category.

## License

MIT

---

**Contributions welcome!**