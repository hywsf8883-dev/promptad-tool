---
description: Discover, enhance, translate, and autonomously execute prompts from your prompts library.
---

You are executing the **Prompted (برومتد)** workflow. Follow these instructions precisely:

## 1. Locate the Prompts Library
Check the following locations for `.md` prompt files:
1. Workspace directory: `./prompts/`
2. Global library: `~/.prompted/prompts/` (or `$USERPROFILE/.prompted/prompts` on Windows)

## 2. Identify Target Prompt
User argument: `$ARGUMENTS`

- **If `$ARGUMENTS` is provided**:
  Search for the matching prompt file (by exact filename, number prefix, or keyword match).
  Example: if argument is `feature-builder` or `1`, select `01-feature-builder.md`.

- **If `$ARGUMENTS` is empty**:
  Scan and list all `.md` files in the prompts directory (ignoring `README.md`).
  Display them to the user in a clean table:
  | # | File Name | Title | Summary |
  |---|-----------|-------|---------|
  Ask the user: "Which prompt would you like me to enhance and execute? (Reply with name or number)"
  Pause and wait for user selection before proceeding to Step 3.

## 3. Read, Summarize & Enhance the Prompt
Once the target prompt is selected:
1. Read the full content of the prompt file.
2. Formulate a crisp 1-2 sentence **Summary** of its intent in Arabic / English.
3. **Enhance and Translate** the prompt into world-class English Prompt Engineering standard:
   - **Role & Persona**: Define an elite specialist (e.g., Principal Software Architect, Senior Security Engineer).
   - **Context & Objective**: Define the precise goals in this workspace.
   - **Strict Engineering Rules**: Enforce clean architecture, zero placeholders, robust error handling, test coverage, and modularity.
   - **Step-by-Step Execution Plan**: Clear actionable phases.
4. Display the summary and the enhanced English directive clearly:
   ```markdown
   ### 📋 Prompt Summary (ملخص البرومبت)
   > [Brief summary]

   ### ⚡ Enhanced English Directive
   ```text
   [Refined English prompt]
   ```
   ```

## 4. Autonomous Execution ("يبعته لنفسه ويشتغل")
**CRITICAL**: Do NOT ask the user for confirmation. Immediately adopt the enhanced prompt as your active instruction and begin executing Phase 1 in the workspace right away!
