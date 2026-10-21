#!/usr/bin/env node

/**
 * Prompted CLI
 * Interactive prompt manager & optimizer for Antigravity & Claude Code
 */

const fs = require('fs');
const path = require('path');
const os = require('os');

const command = process.argv[2] || 'list';
const target = process.argv[3];

const userHome = os.homedir();
const promptDirs = [
  path.join(process.cwd(), 'prompts'),
  path.join(__dirname, '..', 'prompts'),
  path.join(userHome, '.gemini', 'antigravity', 'scratch', 'prompted', 'prompts'),
  path.join(userHome, '.prompted', 'prompts')
];

const KNOWN_METADATA = {
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
          // Ignore non-markdown and ignore old starter templates 01-xx
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
    console.log('\x1b[1;36m  Prompted Library - Available Master Prompts:\x1b[0m');
    console.log('\x1b[1;36m==============================================================\x1b[0m');
    list.forEach((item, index) => {
      console.log(`\x1b[1;32m[${index + 1}] ${item.file}\x1b[0m \x1b[90m(${item.sizeKb} KB)\x1b[0m`);
      console.log(`    \x1b[1;37mTitle: ${item.title}\x1b[0m`);
      console.log(`    \x1b[90mDesc:  ${item.desc}\x1b[0m\n`);
    });
    console.log(`\x1b[33m💡 In Antigravity or Claude Code chat, type: /prompted <filename-or-number>\x1b[0m\n`);
    break;
  }

  case 'show':
  case 'get': {
    if (!target) {
      console.error('\x1b[31mError: Please specify prompt name or index (e.g. prompted show 1 or prompted show discord)\x1b[0m');
      process.exit(1);
    }
    const list = getAllPrompts();
    let found = null;
    if (/^\d+$/.test(target)) {
      const idx = parseInt(target, 10) - 1;
      if (idx >= 0 && idx < list.length) {
        found = list[idx];
      }
    } else {
      found = list.find(item => item.file.toLowerCase().includes(target.toLowerCase()));
    }
    if (found) {
      console.log(found.content);
    } else {
      console.error(`\x1b[31mError: Prompt '${target}' not found.\x1b[0m`);
      process.exit(1);
    }
    break;
  }

  case 'add':
  case 'new': {
    if (!target) {
      console.error('\x1b[31mError: Please provide a filename (e.g. prompted add my-prompt)\x1b[0m');
      process.exit(1);
    }
    const filename = target.endsWith('.md') ? target : `${target}.md`;
    const targetDir = path.join(process.cwd(), 'prompts');
    if (!fs.existsSync(targetDir)) {
      fs.mkdirSync(targetDir, { recursive: true });
    }
    const filePath = path.join(targetDir, filename);
    if (fs.existsSync(filePath)) {
      console.error(`\x1b[31mError: File ${filename} already exists in ./prompts\x1b[0m`);
      process.exit(1);
    }
    const template = `# ${target}

وصف: وصف مختصر للبرومبت هنا

## الأهداف والتعليمات
1. الخطوة الأولى...
2. الخطوة الثانية...
`;
    fs.writeFileSync(filePath, template, 'utf8');
    console.log(`\x1b[32m✔ Created new prompt template at:\x1b[0m ${filePath}`);
    break;
  }

  case 'help':
  default: {
    console.log(`
Prompted CLI - Smart Prompt Manager for Antigravity & Claude Code

Commands:
  prompted list             List all available prompt files
  prompted show <name|idx>  Display the contents of a prompt
  prompted add <name>       Create a new prompt template
  prompted help             Show this help screen
`);
    break;
  }
}
