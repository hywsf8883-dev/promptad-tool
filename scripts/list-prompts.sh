#!/usr/bin/env bash
# Lists all available prompt files for Prompted.

PROMPT_DIRS=(
  "$(pwd)/prompts"
  "$HOME/.prompted/prompts"
  "$(dirname "$0")/../prompts"
)

declare -A SEEN_FILES

echo ""
echo -e "\033[1;36m🚀 Available Prompts in Prompted Library:\033[0m"
echo -e "\033[0;90m==========================================\033[0m"

INDEX=1
for dir in "${PROMPT_DIRS[@]}"; do
  if [ -d "$dir" ]; then
    for file in "$dir"/*.md; do
      [ -f "$file" ] || continue
      fname=$(basename "$file")
      [ "$fname" == "README.md" ] && continue
      [ -n "${SEEN_FILES[$fname]}" ] && continue
      SEEN_FILES[$fname]=1

      title=$(grep -E '^# ' "$file" | head -n 1 | sed 's/^# //')
      [ -z "$title" ] && title="$fname"

      desc=$(grep -E '^(وصف|description):' "$file" | head -n 1 | sed -E 's/^(وصف|description):\s*//')
      [ -z "$desc" ] && desc="Prompt template"

      echo -e "\033[1;32m[$INDEX] $fname\033[0m - \033[1;37m$title\033[0m"
      echo -e "    \033[0;90m$desc\033[0m\n"
      ((INDEX++))
    done
  fi
done

if [ "$INDEX" -eq 1 ]; then
  echo -e "\033[1;33m⚠️ No prompt files found. Add .md files into ./prompts or ~/.prompted/prompts\033[0m"
fi
