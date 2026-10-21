---
name: discord-bot-expert
description: >-
  Expert architect for modern Discord bots (discord.js v14+, Components V2) and Telegram bots in Node.js.
  Use when building or debugging Discord bots, slash commands, Canvas image generators, voice, moderation, or economy systems.
---

# 🤖 Discord Bot Expert (خبير بوتات ديسكورد المتكامل)

Use this skill when developing or debugging Discord bots with Node.js and discord.js v14+ or Telegram bots.

## Core Rules & Principles
1. **Never write incomplete code**: Provide fully working files from start to finish with all imports, error handlers, and exports. Never output placeholders (`// TODO: add logic here`).
2. **Components V2 Support**:
   - For discord.js >= 14.18.0+, utilize Components V2 (`MessageFlags.IsComponentsV2`, `TextDisplayBuilder`, `ContainerBuilder`, `ThumbnailBuilder`, `MediaGalleryBuilder`).
3. **Graphics & Canvas**:
   - Default to `@napi-rs/canvas` for blazing fast server-side image rendering (welcome cards, rank cards, leaderboards). Always call `interaction.deferReply()` before generating images.
4. **Data Persistence**:
   - Use MongoDB (Mongoose), SQLite (`better-sqlite3`), or PostgreSQL (`sequelize` / `prisma`) with structured schemas.

## Reference Master Prompt
When in-depth architecture, event handlers, or complex modules are needed, consult the comprehensive master reference at:
[discord-mega-expert-ultimate-prompt.md](../../prompts/discord-mega-expert-ultimate-prompt.md)
