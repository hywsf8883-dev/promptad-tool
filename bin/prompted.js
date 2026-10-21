#!/usr/bin/env node

/**
 * Prompted CLI — Smart Prompt Manager & Autonomous Optimizer
 * Supports Smart Keyword Matching, Search, and Multi-Agent Synthesis
 */

const fs = require('fs');
const path = require('path');
const os = require('os');

const command = process.argv[2] || 'list';
const query = process.argv.slice(3).join(' ');

const userHome = os.homedir();
const promptDirs = [
  path.join(process.cwd(), 'prompts'),
  path.join(__dirname, '..', 'prompts'),
  path.join(userHome, '.gemini', 'antigravity', 'scratch', 'prompted', 'prompts'),
  path.join(userHome, '.prompted', 'prompts')
];

const KNOWN_METADATA = {
  // New 7 Specialized Prompts
  'token-optimizer-ultra-lean.md': {
    title: 'Token Optimizer & Ultra-Lean Directive (80-240 lines)',
    desc: 'Max token efficiency (50-75% reduction), zero-fluff, dense reasoning, and optimal context preservation.'
  },
  'design-innovation-davinci-ui.md': {
    title: 'Da Vinci UI/UX Innovation Engine (70-140 lines)',
    desc: 'Visual innovation directory: Da Vinci color harmonies, 3D web assets, and elite free UI inspiration links.'
  },
  'discord-bot-modern-architecture.md': {
    title: 'Modern Discord Bot Architecture (2025/2026 Core)',
    desc: 'Latest discord.js v14.19+ updates, Autocomplete, modern Interaction handlers, Subcommands, and Sweepers.'
  },
  'discord-bot-nextgen-components.md': {
    title: 'Next-Gen Components V2 & Advanced Interactions',
    desc: 'Modern layout primitives: ContainerBuilder, SectionBuilder, MediaGalleries, and interactive Modals.'
  },
  'discord-bot-visual-aesthetics.md': {
    title: 'Discord Bot Visual Aesthetics & Micro-UI Design',
    desc: 'Visual hierarchy, dark-theme color accents (Blurple, Emerald, Dark Slate), status badges, and dividers.'
  },
  'discord-bot-interactive-ui-cards.md': {
    title: 'Interactive Discord UI Cards & Widget Systems',
    desc: 'Pagination engines, live music controllers, ticket widgets, shop grids, and collector timeouts.'
  },
  'master-project-auditor-synthesizer.md': {
    title: 'Master Project Auditor & Holistic Synthesizer',
    desc: 'Comprehensive QA auditor verifying tokens, Da Vinci visuals, Discord architecture, security, and tests.'
  },
  // Core Master Prompts
  'components-v2-full-guide.md': {
    title: 'Discord.js Components V2 - Complete Migration Guide',
    desc: 'Transform standard Embeds into modern interactive Components V2 with full layout control.'
  },
  'discord-bot-expert-prompt.md': {
    title: 'Discord & Telegram Bot Expert (Node.js & discord.js v14+)',
    desc: 'Complete production bot architecture, handlers, slash commands, Canvas, and databases.'
  },
  'discord-dashboard-complete-guide2.md': {
    title: 'Discord Bot Web Dashboard - Complete Architecture Guide',
    desc: 'Responsive HTML/CSS/JavaScript dashboard, live stats, WebSocket telemetry, and OAuth2.'
  },
  'discord-dashboard-prompt.md': {
    title: 'Discord Bot Web Dashboard & OAuth2 Specialist',
    desc: 'Discord OAuth2 authentication, guild management, permissions, and backend integration.'
  },
  'discord-image-drawing-prompt.md': {
    title: 'Discord Image & Canvas Drawing Expert',
    desc: 'Server-side graphic rendering using @napi-rs/canvas, Skia-Canvas, Sharp, and Jimp.'
  },
  'discord-image-expert-v2.md': {
    title: 'Discord Image & Graphics Generator (V2 Advanced)',
    desc: 'Welcome banners, rank cards, level cards, and automated graphic generation systems.'
  },
  'discord-image-ultimate.md': {
    title: 'Discord Image & Graphics Suite - Ultimate Edition',
    desc: 'Comprehensive visual engine for cards, leaderboards, statistics, and canvas animations.'
  },
  'discord-mega-expert-prompt.md': {
    title: 'Discord Mega Expert (Unified Bot & Full Systems)',
    desc: 'End-to-end bot systems: moderation, economy, leveling, mini-games, and voice.'
  },
  'discord-mega-expert-ultimate-prompt.md': {
    title: 'Discord & Telegram Mega Expert - Ultimate Master Suite (510 KB)',
    desc: '14,000+ line master reference: every event, permission, handler, database, and library.'
  },
  'minecraft-modding-expert-prompt.md': {
    title: 'Minecraft Modding Master (Fabric, NeoForge, Forge, Java 21)',
    desc: 'Complete Java Edition modding: blocks, entities, biomes, recipes, and Blockbench models.'
  },
  'prompt.md': {
    title: 'Universal Code Diagnostician (Direct Code & Root-Cause Mode)',
    desc: 'Direct root-cause diagnosis and immediate production-ready bug fixes in any programming language.'
  }
};

function getAllPrompts() {
  const prompts = new Map();
  for (const dir of promptDirs) {
    if (fs.existsSync(dir)) {
      try {
        const files = fs.readdirSync(dir);
        for (const file of files) {
          if (!file.endsWith('.md') || file === 'README.md' || /^0\d-.*\.md$/i.test(file)) {
            continue;
          }
          if (!prompts.has(file)) {
            const fullPath = path.join(dir, file);
            const stat = fs.statSync(fullPath);
            const content = fs.readFileSync(fullPath, 'utf8');

            let title = '';
            let desc = '';

            if (KNOWN_METADATA[file]) {
              title = KNOWN_METADATA[file].title;
              desc = KNOWN_METADATA[file].desc;
            } else {
              const lines = content.split('\n').slice(0, 20);
              const titleLine = lines.find(l => /^#\s+/.test(l));
              if (titleLine) {
                const raw = titleLine.replace(/^#\s+/, '').trim();
                const paren = raw.match(/\(([^)]*[a-zA-Z]{3,}[^)]*)\)/);
                title = paren ? paren[1].trim() : raw.replace(/[\u0600-\u06FF]/g, '').trim() || file;
              } else {
                title = file;
              }

              const descLine = lines.find(l => /^(وصف|description):\s*/i.test(l));
              if (descLine) {
                desc = descLine.replace(/^(وصف|description):\s*/i, '').trim();
              } else {
                desc = 'Comprehensive master prompt template.';
              }
            }

            const sizeKb = (stat.size / 1024).toFixed(1);
            prompts.set(file, { file, fullPath, title, desc, sizeKb, content });
          }
        }
      } catch (e) {}
    }
  }
  return Array.from(prompts.values()).sort((a, b) => a.file.localeCompare(b.file));
}

switch (command) {
  case 'list':
  case 'ls': {
    const list = getAllPrompts();
    console.log('\n\x1b[1;36m==============================================================\x1b[0m');
    console.log('\x1b[1;36m  🚀 Prompted Library - 18 Master Prompts Ready:\x1b[0m');
    console.log('\x1b[1;36m==============================================================\x1b[0m');
    list.forEach((item, index) => {
      console.log(`\x1b[1;32m[${index + 1}] ${item.file}\x1b[0m \x1b[90m(${item.sizeKb} KB)\x1b[0m`);
      console.log(`    \x1b[1;37mTitle: ${item.title}\x1b[0m`);
      console.log(`    \x1b[90mDesc:  ${item.desc}\x1b[0m\n`);
    });
    console.log(`\x1b[33m💡 In Antigravity or Claude Code chat, type: /prompted <query or number>\x1b[0m\n`);
    break;
  }

  case 'search':
  case 'find':
  case 'match': {
    if (!query) {
      console.error('\x1b[31mError: Please specify keyword (e.g. prompted search token or prompted search discord)\x1b[0m');
      process.exit(1);
    }
    const list = getAllPrompts();
    const terms = query.toLowerCase().split(/\s+/);
    const matches = list.filter(item => {
      const haystack = (item.file + ' ' + item.title + ' ' + item.desc + ' ' + item.content).toLowerCase();
      return terms.some(term => haystack.includes(term));
    });

    console.log(`\n\x1b[1;36m🔍 Smart Keyword Search Results for: "${query}"\x1b[0m`);
    console.log('\x1b[90m==============================================================\x1b[0m');
    if (matches.length === 0) {
      console.log('\x1b[33mNo matching prompt found for this query.\x1b[0m\n');
    } else {
      matches.forEach((item, index) => {
        console.log(`\x1b[1;32m[${index + 1}] ${item.file}\x1b[0m \x1b[90m(${item.sizeKb} KB)\x1b[0m`);
        console.log(`    \x1b[1;37mTitle: ${item.title}\x1b[0m`);
        console.log(`    \x1b[90mDesc:  ${item.desc}\x1b[0m\n`);
      });
    }
    break;
  }

  case 'show':
  case 'get': {
    if (!query) {
      console.error('\x1b[31mError: Please specify prompt name or index (e.g. prompted show 1 or prompted show token)\x1b[0m');
      process.exit(1);
    }
    const list = getAllPrompts();
    let found = null;
    if (/^\d+$/.test(query.trim())) {
      const idx = parseInt(query.trim(), 10) - 1;
      if (idx >= 0 && idx < list.length) {
        found = list[idx];
      }
    } else {
      found = list.find(item => item.file.toLowerCase().includes(query.toLowerCase()));
    }
    if (found) {
      console.log(found.content);
    } else {
      console.error(`\x1b[31mError: Prompt '${query}' not found.\x1b[0m`);
      process.exit(1);
    }
    break;
  }

  case 'help':
  default: {
    console.log(`
Prompted CLI — Smart Prompt Manager & Autonomous Optimizer

Commands:
  prompted list                 List all 18 master prompts
  prompted search <keyword>     Smart keyword search across prompts
  prompted show <name|idx>      Display full contents of a prompt
  prompted help                 Show this help screen
`);
    break;
  }
}
