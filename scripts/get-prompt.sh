#!/usr/bin/env bash
# Retrieves a prompt by filename, partial name, or index number.

TARGET="$1"
if [ -z "$TARGET" ]; then
  echo "Usage: $0 <prompt-name-or-number>"
  exit 1
fi

PROMPT_DIRS=(
  "$(pwd)/prompts"
  "$HOME/.prompted/prompts"
  "$(dirname "$0")/../prompts"
)

declare -A FOUND_FILES
FILES_LIST=()

for dir in "${PROMPT_DIRS[@]}"; do
  if [ -d "$dir" ]; then
    for file in "$dir"/*.md; do
      [ -f "$file" ] || continue
      fname=$(basename "$file")
      [ "$fname" == "README.md" ] && continue
      if [ -z "${FOUND_FILES[$fname]}" ]; then
        FOUND_FILES[$fname]="$file"
        FILES_LIST+=("$fname")
      fi
    done
  fi
done

# Sort keys
IFS=$'\n' SORTED_KEYS=($(sort <<<"${FILES_LIST[*]}"))
unset IFS

# Check if number
if [[ "$TARGET" =~ ^[0-9]+$ ]]; then
  IDX=$((TARGET - 1))
  if [ "$IDX" -ge 0 ] && [ "$IDX" -lt "${#SORTED_KEYS[@]}" ]; then
    SELECTED_KEY="${SORTED_KEYS[$IDX]}"
    cat "${FOUND_FILES[$SELECTED_KEY]}"
    exit 0
  fi
fi

# Check partial match
for key in "${SORTED_KEYS[@]}"; do
  if [[ "$key" == *"$TARGET"* ]] || [[ "${key%.md}" == *"$TARGET"* ]]; then
    cat "${FOUND_FILES[$key]}"
    exit 0
  fi
done

echo "Error: Prompt matching '$TARGET' was not found." >&2
exit 1
