---
name: prompted
description: >-
  Loads, summarizes, enhances, translates to English, and immediately executes prompts
  from the prompt library. Triggered when the user types /prompted, mentions برومتد,
  or asks to load and run a stored prompt template.
---

# Prompted (برومتد) - Smart Prompt Loader & Optimizer

`prompted` is an automated workflow that connects your saved prompt library with the AI agent.
It scans prompt templates, refines and translates them into elite English engineering directives, and executes them autonomously.

---

## Workflow Steps

When the user runs `/prompted` or triggers this skill, follow these sequential steps:

### Step 1: Discover Available Prompts
Search for `.md` files (excluding `README.md`) in the following locations in order:
1. Workspace prompts: `./prompts/`
2. Global user prompts: `~/.prompted/prompts/` (or `$USERPROFILE/.prompted/prompts/` on Windows)
3. Plugin / repo prompts: `<customization_root>/prompts/`

### Step 2: Prompt Selection
- **If the user already specified a prompt** (e.g. `/prompted 01-feature-builder` or `/prompted refactor` or a number):
  - Match the file by exact name, index number, or partial keyword match.
  - Proceed directly to Step 3.
- **If no prompt was specified** (user just typed `/prompted` or asked for prompts):
  - Read each prompt file's first few lines to extract:
    - **Filename** (e.g., `01-feature-builder.md`)
    - **Title** (from `# ...`)
    - **Description** (from `وصف: ...` or initial paragraph)
  - Present the catalog to the user in a clean markdown table:
    ```markdown
    | # | Prompt File | Title / Domain | Description |
    |---|-------------|----------------|-------------|
    | 1 | `01-feature-builder.md` | Full-Stack Feature Builder | بناء ميزة برمجية متكاملة end-to-end |
    ...
    ```
  - Ask the user to choose which prompt to run (by number or name). If the `ask_question` tool is available, use it to provide selectable options.

---

### Step 3: Read, Summarize & Enhance the Prompt
Once the target prompt file is identified:
1. **Read the complete content** of the file.
2. **Generate a Concise Summary**:
   - Provide a 1-2 sentence summary of what this prompt aims to accomplish.
3. **Enhance & Translate into High-Performance English**:
   - Translate all instructions, requirements, and constraints into clear, professional, authoritative English.
   - Upgrade the prompt using elite Prompt Engineering principles:
     - **Role / Identity**: Assign a world-class specialized persona (e.g., Senior Full-Stack Architect, Staff Security Engineer).
     - **Clear Objective & Scope**: Explicitly define what needs to be accomplished in the current workspace.
     - **Engineering Standards**: Enforce clean architecture, type safety, modularity, zero dummy code/placeholders, comprehensive error handling, and security.
     - **Execution Plan**: Structured, phased step-by-step instructions.
     - **Verification**: How to validate and test the implementation.
4. **Display the Refined Blueprint**:
   Present both the summary and the enhanced English directive clearly to the user:
   ```markdown
   ### 📋 Prompt Summary (ملخص البرومبت)
   > [Brief summary in Arabic/English]

   ### ⚡ Enhanced English Directive
   ```text
   [The enhanced, production-grade prompt]
   ```
   ```

---

### Step 4: Autonomous Execution ("يبعته لنفسه ويشتغل")
> [!IMPORTANT]
> **Do NOT stop or ask the user for permission to proceed with the prompt.**
> The core design of `prompted` is that the AI adopts the enhanced prompt as its **active working directive** and starts executing it immediately.

1. State clearly:
   `🚀 Prompted: Adopting enhanced directive and commencing execution now...`
2. Immediately start executing Phase 1 of the prompt using appropriate workspace tools:
   - Inspecting codebase files
   - Creating or editing files
   - Running builds, tests, or diagnostic commands
   - Fulfilling all deliverables specified in the enhanced prompt.
