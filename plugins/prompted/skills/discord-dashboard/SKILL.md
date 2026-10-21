---
name: discord-dashboard
description: >-
  Specialist for designing and developing Discord Bot Web Dashboards with OAuth2, server management, real-time stats, and UI controls.
  Use when creating web interfaces, settings panels, or analytics portals for Discord bots.
---

# 🌐 Discord Dashboard Specialist (خبير لوحات تحكم بوتات ديسكورد)

Use this skill when building web administration panels, dashboards, and portals for Discord bots.

## Architecture Guidelines
1. **Authentication (OAuth2)**:
   - Implement Discord OAuth2 flow with secure sessions (Cookie-session, express-session with Redis or Mongo store).
   - Verify server ownership and `MANAGE_GUILD` permissions before allowing setting modifications.
2. **Backend**:
   - Express.js or Fastify with strict request validation, CSRF protection, and rate limiting.
   - Live synchronization with the bot process via IPC, Redis Pub/Sub, or WebSockets.
3. **Frontend**:
   - Tailwind CSS or modern CSS with dark-mode first UI.
   - Real-time updates for guild member counts, server logs, music player controls, and bot configuration.

## Reference Master Prompts
- [discord-dashboard-prompt.md](../../prompts/discord-dashboard-prompt.md)
- [discord-dashboard-complete-guide2.md](../../prompts/discord-dashboard-complete-guide2.md)
