---
name: prompted
description: >-
  Loads, optimizes, translates to English, and immediately executes prompts from the prompt library.
  Features a Smart Context & Keyword Matching Engine that automatically detects project requirements,
  fuses relevant prompt templates, and executes the highest-quality code.
  Triggered when the user types /prompted, mentions برومتد, or asks to load/run a prompt.
---

# Prompted (برومتد) — Smart Prompt Engine & Autonomous Runner

`prompted` connects your saved prompt library with the AI agent. It supports both direct file execution and an **Intelligent Keyword & Context Matching Engine (الوضع الذكي)** that analyzes user specifications, retrieves and fuses relevant master templates, and autonomously writes the best possible production code.

---

## 🧠 Workflow & Execution Logic

When the user runs `/prompted` or triggers this skill:

### Phase 1: Determine Execution Mode

#### Mode 1: Direct File / Index Selection
- Triggered when the user provides an exact index number or filename (e.g., `/prompted 1`, `/prompted components-v2`).
- Immediately loads that specific file and proceeds to **Phase 3**.

#### Mode 2: Smart Semantic & Keyword Fusion Mode (الوضع الذكي)
- Triggered when:
  1. The user types `/prompted` followed by natural language requirements or project specifications (e.g., `/prompted صمملي بوت ديسكورد مع لوحة تحكم وتوفير توكنز`).
  2. The user types `/prompted` with no arguments, BUT the conversation context already contains an active request (e.g. user previously asked to build or debug something).
- **Execution Steps for Smart Mode**:
  1. **Keyword & Requirement Extraction**: Extract technical domains, entities, constraints, visual requests, and performance goals:
     - `discord` / `bot` / `slash` / `v14` → matches Discord Bot suites (`discord-bot-modern-architecture.md`, `discord-mega-expert-ultimate-prompt.md`).
     - `components v2` / `container` / `section` → matches `discord-bot-nextgen-components.md` & `components-v2-full-guide.md`.
     - `ui` / `design` / `ألوان` / `دافنشي` / `3d` / `web` → matches `design-innovation-davinci-ui.md`.
     - `token` / `توكنز` / `أقل` / `سريع` / `lean` → fuses `token-optimizer-ultra-lean.md`.
     - `visual` / `جماليات` / `شكل` / `embed` → matches `discord-bot-visual-aesthetics.md`.
     - `cards` / `pagination` / `صفحات` / `interactive` → matches `discord-bot-interactive-ui-cards.md`.
     - `audit` / `تدقيق` / `فحص` / `qa` → matches `master-project-auditor-synthesizer.md`.
     - `minecraft` / `fabric` / `forge` / `مود` → matches `minecraft-modding-expert-prompt.md`.
     - `bug` / `عطل` / `مشكلة` / `diagnose` → matches `prompt.md` (Code Diagnostician).
  2. **Template Synthesis**: Read and combine rules from the matching templates. For instance, if the user asks for a Discord bot with custom aesthetics and minimal token usage, fuse:
     `discord-bot-modern-architecture.md` + `discord-bot-visual-aesthetics.md` + `token-optimizer-ultra-lean.md`.
  3. Proceed immediately to **Phase 3 & 4**.

#### Mode 3: Interactive Catalog Mode
- Triggered ONLY when the user types `/prompted` with zero arguments AND there is no previous request context in the current chat.
- Displays the formatted library table with index numbers, titles, and descriptions.
- Invites the user to choose by number or simply describe what they want to build.

---

### Phase 2: Locate Prompt Files
Scan for `.md` files in:
1. Workspace directory: `./prompts/`
2. Customization / repo directory: `C:/Users/PC/.gemini/antigravity/scratch/prompted/prompts/`
3. Global library: `~/.prompted/prompts/` (or `$USERPROFILE/.prompted/prompts` on Windows)

---

### Phase 3: Synthesize, Enhance & Translate into English
1. **Summary**: State in 1-2 bullet points the matched templates and core objectives.
2. **Enhanced English Directive**:
   - Formulate a tailored, production-grade English engineering directive combining the user's exact feature specifications with the strict rules from the matched templates (e.g. zero placeholders, modern API standards, Da Vinci color contrast, lean token density).
3. **Display**: Present the summary and enhanced directive concisely to the user.

---

### Phase 4: Autonomous Execution ("يبدأ يشتغل بيه ويعمل كود الأفضل")
> [!IMPORTANT]
> **Do NOT pause or wait for user confirmation.**
> The AI must immediately transition from synthesizing the prompt to executing it in the workspace:
> 1. Announce: `🚀 Prompted Smart Engine: Commencing implementation now...`
> 2. Create/edit project files, write 100% complete working code, run commands, and deliver the final solution.
