#!/usr/bin/env bash
# ==============================================================================
# Prompted (برومتد) - Uninstaller for Linux & macOS
# ==============================================================================

set -e

USER_HOME="$HOME"
rm -rf "$USER_HOME/.gemini/config/plugins/prompted" 2>/dev/null || true
rm -rf "$USER_HOME/.gemini/config/skills/prompted" 2>/dev/null || true
rm -f "$USER_HOME/.claude/commands/prompted.md" 2>/dev/null || true

echo "✔ Removed Prompted from Antigravity and Claude Code."
echo "ℹ Your saved prompts in $USER_HOME/.prompted/prompts were preserved."
