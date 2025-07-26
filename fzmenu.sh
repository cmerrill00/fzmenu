#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n'

CONFIG="${1:-$HOME/.config/fzf-menu/commands.conf}"
[[ -f "$CONFIG" ]] || { echo "Config not found: $CONFIG" >&2; exit 1; }

# Read and clean config, skip empty/malformed lines
mapfile -t LINES < <(awk -F'|' 'NF>=3 {gsub(/\r$/, ""); print}' "$CONFIG")

while true; do
  # Get unique categories
  mapfile -t CATEGORIES < <(printf '%s\n' "${LINES[@]}" | awk -F'|' '{print $1}' | sort -u)
  CATEGORIES=("Exit" "${CATEGORIES[@]}")  # Add Exit option

  # Select category
  CATEGORY=$(printf '%s\n' "${CATEGORIES[@]}" | fzf --height=20% --border --prompt 'Category> ')
  [[ -z "$CATEGORY" ]] && exit 0
  [[ "$CATEGORY" == "Exit" ]] && exit 0

  # Filter commands for category and add Back option
  mapfile -t MENU < <(
    printf '%s\n' "${LINES[@]}" |
    awk -F'|' -v cat="$CATEGORY" '$1==cat {print $2 "\t" $3}'
  )
  MENU=("Back - Main menu." "${MENU[@]}")

  [[ ${#MENU[@]} -eq 1 ]] && { echo "No commands in category: $CATEGORY" >&2; continue; }

  # Select command with preview
  SELECTION=$(printf '%s\n' "${MENU[@]}" | \
    fzf \
      --height=50% --border --prompt 'Command> ' \
      --delimiter $'\t' \
      --with-nth=1 \
      --preview '
        PREVIEW_CMD=$(echo {} | awk -F"\t" "{print \$2}")
        if [ "$PREVIEW_CMD" = "Go back to category selection" ]; then
          echo "Return to category selection"
        elif bash -n <<<"$PREVIEW_CMD" 2>/dev/null; then
          bash -c "$PREVIEW_CMD" | head -n30
        else
          echo "$PREVIEW_CMD"
        fi
      ' \
      --preview-window right:60%
  )
  [[ -z "$SELECTION" ]] && exit 0

  # If Back selected, restart loop
  if [[ "$SELECTION" == Back* ]]; then
    continue
  fi

  # Extract and run command
  CMD=$(echo "$SELECTION" | awk -F'\t' '{print $2}')
  clear
  bash -ic "$CMD"
  exit 0
done