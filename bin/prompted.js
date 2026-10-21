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
  path.join(userHome, '.prompted', 'prompts')
];

function getAllPrompts() {
  const prompts = new Map();
  for (const dir of promptDirs) {
    if (fs.existsSync(dir)) {
      const files = fs.readdirSync(dir);
      for (const file of files) {
        if (file.endsWith('.md') && file !== 'README.md' && !prompts.has(file)) {
          const fullPath = path.join(dir, file);
          const stat = fs.statSync(fullPath);
          const content = fs.readFileSync(fullPath, 'utf8');
          const lines = content.split('\n').slice(0, 20);

          let title = '';
          const titleLine = lines.find(l => /^#\s+/.test(l));
          if (titleLine) {
            title = titleLine.replace(/^#\s+/, '').trim();
          } else if (file === 'prompt.md') {
            title = 'Universal Code Diagnostician (Direct Code & Root-Cause Mode)';
          } else {
            title = file;
          }

          let desc = '';
          const descLine = lines.find(l => /^(وصف|description):\s*/i.test(l));
          if (descLine) {
            desc = descLine.replace(/^(وصف|description):\s*/i, '').trim();
          } else {
            const subHeader = lines.find(l => /^##\s+[^#\s]/.test(l));
            if (subHeader) {
              desc = subHeader.replace(/^##\s+/, '').trim();
            } else if (file === 'prompt.md') {
              desc = 'Direct diagnosis and immediate production-ready complete code across all languages.';
            } else {
              desc = 'Comprehensive master prompt template.';
            }
          }

          const sizeKb = (stat.size / 1024).toFixed(1);
          prompts.set(file, { file, fullPath, title, desc, sizeKb, content });
        }
      }
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
