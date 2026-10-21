---
description: Intelligent prompt engine with Smart Context & Keyword Matching for autonomous code generation.
---

You are executing the **Prompted (برومتد) Smart Engine**. Follow these instructions precisely:

## 1. Analyze Mode & Arguments
User input: `$ARGUMENTS`

- **Scenario A: Direct File/Number** (e.g. `/prompted 1`, `/prompted components-v2`):
  Load that specific prompt file from `./prompts/` or `~/.prompted/prompts/`. Proceed to Step 3.

- **Scenario B: Smart Keyword & Context Matching Mode (الوضع الذكي)**:
  Triggered when `$ARGUMENTS` contains natural language requirements (e.g. `/prompted build a music bot with lean tokens`), OR when `/prompted` has no argument but previous chat messages contain user requirements.
  1. Extract core keywords: `discord`, `components v2`, `ui design`, `davinci colors`, `lean tokens`, `minecraft`, `audit`.
  2. Scan the prompt library and retrieve the most relevant prompt template(s).
  3. Synthesize the requirements: fuse best architectural practices, zero-placeholder rules, and visual aesthetics from the matched templates.
  4. Proceed directly to Step 3 & 4.

- **Scenario C: Interactive Catalog**:
  Triggered ONLY if `$ARGUMENTS` is empty AND no project context exists in the chat.
  List all available prompts in a clean table and prompt the user to choose.

## 2. Locate Prompt Files
Check `./prompts/` and `~/.prompted/prompts/`.

## 3. Summarize & Synthesize English Directive
1. Summarize the matched domain and goals in 1-2 bullet points.
2. Formulate a crisp, production-grade English engineering directive embodying all rules.
3. Display the summary and directive to the user.

## 4. Autonomous Execution ("يبدأ يشتغل بيه ويعمل كود الأفضل")
**CRITICAL**: Do NOT ask the user for confirmation. Immediately adopt the directive as your active working instructions and begin building and outputting the complete, production-ready code in the workspace right away!
