#!/usr/bin/env bash
# ==============================================================================
# Prompted - Universal Installer for Linux & macOS
# GitHub: https://github.com/hywsf8883-dev/promptad-tool.git
# ==============================================================================

set -e

GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
GRAY='\033[0;90m'
RED='\033[0;31m'
NC='\033[0m' # No Color

TARGET_PLATFORM="${1:-}"

clear 2>/dev/null || true
echo -e "${CYAN}"
echo "=============================================================="
echo "      Prompted Installer | Antigravity & Claude Code          "
echo "    Repository: https://github.com/hywsf8883-dev/promptad-tool"
echo "=============================================================="
echo -e "${NC}"

if [ -z "$TARGET_PLATFORM" ]; then
  echo -e "${YELLOW}Select the platform you want to install Prompted for:${NC}\n"
  echo -e "  [1] Google Antigravity only"
  echo -e "  [2] Claude Code only"
  echo -e "  ${GREEN}[3] Both (Antigravity & Claude Code) [Recommended]${NC}"
  echo -e "  [4] Cancel\n"

  read -r -p "Enter your choice [1-4] (Default: 3): " input_choice
  input_choice="${input_choice:-3}"

  case "$input_choice" in
    1) TARGET_PLATFORM="antigravity" ;;
    2) TARGET_PLATFORM="claude" ;;
    3) TARGET_PLATFORM="both" ;;
    4)
      echo -e "${RED}[-] Installation cancelled.${NC}"
      exit 0
      ;;
    *) TARGET_PLATFORM="both" ;;
  esac
fi

echo -e "\n${CYAN}[*] Setting up Prompted for: $TARGET_PLATFORM...${NC}"

USER_HOME="$HOME"
TEMP_DIR=""
SOURCE_DIR=""

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd || true)"
if [ -n "$SCRIPT_DIR" ] && [ -d "$SCRIPT_DIR/prompts" ]; then
  SOURCE_DIR="$SCRIPT_DIR"
elif [ -d "$(pwd)/prompts" ]; then
  SOURCE_DIR="$(pwd)"
fi

if [ -z "$SOURCE_DIR" ]; then
  echo -e "${CYAN}[*] Downloading latest files from GitHub...${NC}"
  TEMP_DIR=$(mktemp -d)
  ZIP_URL="https://github.com/hywsf8883-dev/promptad-tool/archive/refs/heads/main.zip"
  curl -fsSL "$ZIP_URL" -o "$TEMP_DIR/promptad-tool.zip"
  unzip -q "$TEMP_DIR/promptad-tool.zip" -d "$TEMP_DIR"
  SOURCE_DIR="$TEMP_DIR/promptad-tool-main"
fi

# 1. Setup Global Prompts Library
GLOBAL_PROMPTS_DIR="$USER_HOME/.prompted/prompts"
mkdir -p "$GLOBAL_PROMPTS_DIR"
if [ -d "$SOURCE_DIR/prompts" ]; then
  for file in "$SOURCE_DIR/prompts"/*.md; do
    [ -f "$file" ] || continue
    fname=$(basename "$file")
    if [ ! -f "$GLOBAL_PROMPTS_DIR/$fname" ]; then
      cp "$file" "$GLOBAL_PROMPTS_DIR/$fname"
    fi
  done
  echo -e "${GREEN}[+] Global prompts library configured at: $GLOBAL_PROMPTS_DIR${NC}"
fi

# 2. Antigravity Install
if [ "$TARGET_PLATFORM" = "antigravity" ] || [ "$TARGET_PLATFORM" = "both" ]; then
  GEMINI_CONFIG_DIR="$USER_HOME/.gemini/config"
  mkdir -p "$GEMINI_CONFIG_DIR/plugins/prompted"
  mkdir -p "$GEMINI_CONFIG_DIR/skills/prompted"

  cp -r "$SOURCE_DIR/plugins/prompted/"* "$GEMINI_CONFIG_DIR/plugins/prompted/" 2>/dev/null || true
  cp -r "$SOURCE_DIR/.agents/skills/prompted/"* "$GEMINI_CONFIG_DIR/skills/prompted/" 2>/dev/null || true

  for extra_skill in discord-bot-expert discord-dashboard minecraft-modding code-diagnostician; do
    if [ -d "$SOURCE_DIR/.agents/skills/$extra_skill" ]; then
      mkdir -p "$GEMINI_CONFIG_DIR/skills/$extra_skill"
      cp -r "$SOURCE_DIR/.agents/skills/$extra_skill/"* "$GEMINI_CONFIG_DIR/skills/$extra_skill/" 2>/dev/null || true
    fi
  done

  echo -e "${GREEN}[+] Google Antigravity: Prompted plugin & skills installed successfully!${NC}"
fi

# 3. Claude Code Install
if [ "$TARGET_PLATFORM" = "claude" ] || [ "$TARGET_PLATFORM" = "both" ]; then
  CLAUDE_COMMANDS_DIR="$USER_HOME/.claude/commands"
  mkdir -p "$CLAUDE_COMMANDS_DIR"
  if [ -d "$SOURCE_DIR/.claude/commands" ]; then
    cp "$SOURCE_DIR/.claude/commands/"*.md "$CLAUDE_COMMANDS_DIR/" 2>/dev/null || true
    echo -e "${GREEN}[+] Claude Code: Prompted slash commands installed successfully!${NC}"
  fi
fi

# Cleanup
if [ -n "$TEMP_DIR" ] && [ -d "$TEMP_DIR" ]; then
  rm -rf "$TEMP_DIR"
fi

echo -e "\n${GRAY}==============================================================${NC}"
echo -e "${GREEN}[SUCCESS] Installation Complete!${NC}"
echo -e "${GRAY}==============================================================${NC}"
echo -e "${CYAN}How to use Prompted:${NC}"
if [ "$TARGET_PLATFORM" = "antigravity" ] || [ "$TARGET_PLATFORM" = "both" ]; then
  echo -e "  * In Google Antigravity: type /prompted"
fi
if [ "$TARGET_PLATFORM" = "claude" ] || [ "$TARGET_PLATFORM" = "both" ]; then
  echo -e "  * In Claude Code: type /prompted"
fi
echo -e "  * From Terminal: node bin/prompted.js list"
echo -e "${GRAY}==============================================================\n${NC}"
