#!/usr/bin/env bash
# ==============================================================================
# Prompted (برومتد) - Installer for Linux & macOS
# Configures Prompted for Google Antigravity & Claude Code
# ==============================================================================

set -e

GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
GRAY='\033[0;90m'
NC='\033[0m' # No Color

echo -e "${CYAN}"
cat << 'EOF'
   ___                         __           __ 
  / _ \_______  __ _  ___  / /____ ___  / / 
 / ___/ __/ _ \/  ' \/ _ \/ __/ -_) _ \/ _ \
/_/  /_/  \___/_/_/_/ .__/\__/\__/\___/_.__/
                   /_/                       
🚀 Installing Prompted (برومتد) for Antigravity & Claude Code...
EOF
echo -e "${NC}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
USER_HOME="$HOME"

# 1. Global Prompts Directory
GLOBAL_PROMPTS_DIR="$USER_HOME/.prompted/prompts"
mkdir -p "$GLOBAL_PROMPTS_DIR"
echo -e "${GREEN}✔ Created global prompts library at: $GLOBAL_PROMPTS_DIR${NC}"

# Copy starter prompts
SOURCE_PROMPTS="$SCRIPT_DIR/prompts"
if [ -d "$SOURCE_PROMPTS" ]; then
  for file in "$SOURCE_PROMPTS"/*.md; do
    [ -f "$file" ] || continue
    fname=$(basename "$file")
    if [ ! -f "$GLOBAL_PROMPTS_DIR/$fname" ]; then
      cp "$file" "$GLOBAL_PROMPTS_DIR/$fname"
    fi
  done
  echo -e "${GREEN}✔ Starter prompt templates synced to global library.${NC}"
fi

# 2. Antigravity Integration
GEMINI_CONFIG_DIR="$USER_HOME/.gemini/config"
GEMINI_PLUGINS_DIR="$GEMINI_CONFIG_DIR/plugins/prompted"
GEMINI_SKILLS_DIR="$GEMINI_CONFIG_DIR/skills/prompted"

mkdir -p "$GEMINI_PLUGINS_DIR"
cp -r "$SCRIPT_DIR/plugins/prompted/"* "$GEMINI_PLUGINS_DIR/" 2>/dev/null || true

mkdir -p "$GEMINI_SKILLS_DIR"
cp -r "$SCRIPT_DIR/.agents/skills/prompted/"* "$GEMINI_SKILLS_DIR/" 2>/dev/null || true
echo -e "${GREEN}✔ Installed Prompted into Google Antigravity ($GEMINI_SKILLS_DIR)${NC}"

# 3. Claude Code Integration
CLAUDE_COMMANDS_DIR="$USER_HOME/.claude/commands"
mkdir -p "$CLAUDE_COMMANDS_DIR"
if [ -f "$SCRIPT_DIR/.claude/commands/prompted.md" ]; then
  cp "$SCRIPT_DIR/.claude/commands/prompted.md" "$CLAUDE_COMMANDS_DIR/prompted.md"
  echo -e "${GREEN}✔ Installed Prompted into Claude Code ($CLAUDE_COMMANDS_DIR/prompted.md)${NC}"
fi

echo -e "\n${GREEN}🎉 Installation Complete! (تم التثبيت بنجاح)${NC}"
echo -e "${GRAY}==============================================================${NC}"
echo -e "${CYAN}💡 How to use (طريقة الاستخدام):${NC}"
echo -e "1. In Google Antigravity / Claude Code, simply type:"
echo -e "   ${YELLOW}/prompted${NC}"
echo -e "2. Or execute a specific prompt directly:"
echo -e "   ${YELLOW}/prompted 01-feature-builder${NC}"
echo -e "3. Add your own custom prompt templates anytime in:"
echo -e "   ${CYAN}$GLOBAL_PROMPTS_DIR${NC}"
echo -e "   (or create a ./prompts folder in your project)"
echo -e "${GRAY}==============================================================\n${NC}"
