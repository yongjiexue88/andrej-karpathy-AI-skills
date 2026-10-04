# Karpathy-Inspired Coding and Output Guidelines

[Project repository](https://github.com/yongjiexue88/andrej-karpathy-output-skills)

An installable Claude Code plugin with one reusable skill: four coding principles and four output control rules for AI agents. The coding principles are derived from [Andrej Karpathy's observations](https://x.com/karpathy/status/2015883857489522876) on LLM coding pitfalls. The output rules follow his advice on making model outputs easier to understand.

Use [`skills/karpathy-output-guidelines/SKILL.md`](./skills/karpathy-output-guidelines/SKILL.md), or the combined [`AGENTS.md`](./AGENTS.md) and [`CLAUDE.md`](./CLAUDE.md) for all eight rules. `AGENTS.md` is the standard instruction filename for Codex; `CLAUDE.md` serves Claude Code.

English | [简体中文](./README.zh.md)

## Install with Your Agent

Copy this prompt into Codex, Claude Code, or Cursor:

```text
Install the guidelines from https://github.com/yongjiexue88/andrej-karpathy-output-skills for this agent using the README's installation instructions, preserve existing skills and project instructions, and verify the installation.
```

## Install

**Option A: Claude Code Plugin (recommended)**

From within Claude Code, first add the marketplace:

```text
/plugin marketplace add yongjiexue88/andrej-karpathy-output-skills
```

Then install the plugin:

```text
/plugin install andrej-karpathy-output-skills@karpathy-output-skills
```

This makes the guidelines available as a Claude Code plugin across your projects. All eight rules are in one skill, which Claude can use when relevant. To invoke it directly:

```text
/andrej-karpathy-output-skills:karpathy-output-guidelines
```

The repository includes [plugin metadata](./.claude-plugin/plugin.json) and a [marketplace catalog](./.claude-plugin/marketplace.json), following the official [Claude Code marketplace format](https://code.claude.com/docs/en/plugin-marketplaces).

**Option B: CLAUDE.md (per-project)**

For a new project, copy [`CLAUDE.md`](./CLAUDE.md) into the project root.

For an existing project, append its contents to your project's `CLAUDE.md`, preserving your existing instructions.

For Codex, use [`AGENTS.md`](./AGENTS.md) instead. You can ask your agent to do this with the prompt above.

## The Problems

From Andrej's post:

> "The models make wrong assumptions on your behalf and just run along with them without checking. They don't manage their confusion, don't seek clarifications, don't surface inconsistencies, don't present tradeoffs, don't push back when they should."

> "They really like to overcomplicate code and APIs, bloat abstractions, don't clean up dead code... implement a bloated construction over 1000 lines when 100 would do."

> "They still sometimes change/remove comments and code they don't sufficiently understand as side effects, even if orthogonal to the task."

Even correct results can be hard to understand when the writing is dense or the output format does not suit the topic.

## The Solution

Eight principles in one skill: four for coding and four for output.

| # | Principle | Addresses |
|---|-----------|-----------|
| 1 | **Think Before Coding** | Wrong assumptions, hidden confusion, missing tradeoffs |
| 2 | **Simplicity First** | Overcomplication, bloated abstractions |
| 3 | **Surgical Changes** | Orthogonal edits, touching code you shouldn't |
| 4 | **Goal-Driven Execution** | Verifiable success criteria and focused checks |
| 5 | **Prefer Clarity over Complexity** | Dense language, jargon, and ambiguity |
| 6 | **Prefer Visual Explanations When They Improve Understanding** | Relationships, processes, and architecture hidden in long prose |
| 7 | **Use Interactive Outputs for Complex Topics** | Inputs, states, and cause and effect that need exploration |
| 8 | **Match the Output Medium to the Learning Problem** | Formats that add polish without improving understanding |

## The Four Coding Principles in Detail

### 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

LLMs often pick an interpretation silently and run with it. This principle forces explicit reasoning:

- **State assumptions explicitly** — If uncertain, ask rather than guess
- **Present multiple interpretations** — Don't pick silently when ambiguity exists
- **Push back when warranted** — If a simpler approach exists, say so
- **Stop when confused** — Name what's unclear and ask for clarification

### 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

Combat the tendency toward overengineering:

- No features beyond what was asked
- No abstractions for single-use code
- No "flexibility" or "configurability" that wasn't requested
- No error handling for impossible scenarios
- If 200 lines could be 50, rewrite it

**The test:** Would a senior engineer say this is overcomplicated? If yes, simplify.

### 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:

- Don't "improve" adjacent code, comments, or formatting
- Don't refactor things that aren't broken
- Match existing style, even if you'd do it differently
- If you notice unrelated dead code, mention it — don't delete it

When your changes create orphans:

- Remove imports/variables/functions that YOUR changes made unused
- Don't remove pre-existing dead code unless asked

**The test:** Every changed line should trace directly to the user's request.

### 4. Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform imperative tasks into verifiable goals:

| Instead of... | Transform to... |
|--------------|-----------------|
| "Add validation" | "Write tests for invalid inputs, then make them pass" |
| "Fix the bug" | "Write a test that reproduces it, then make it pass" |
| "Refactor X" | "Ensure tests pass before and after" |

For multi-step tasks, state a brief plan:

```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong success criteria let the LLM loop independently. Weak criteria ("make it work") require constant clarification.

## The Four Output Rules in Detail

As agents do more work autonomously, more of our work becomes oversight and understanding. Agents can help by producing clear writing and custom diagrams, interactive pages, or explainer videos suited to the topic.

### 5. Prefer Clarity over Complexity

**Simple words. Short sentences. Precise meaning.**

Aim for roughly 80% of ASD-STE100's clarity principles. This is a practical style target, not a claim of formal compliance.

When writing:
- Lead with the main point, then explain the details the reader needs.
- Use short sentences and one main idea per sentence.
- Prefer active voice, direct verbs, and familiar words.
- Use the same term for the same concept. Define necessary technical terms.
- Make actors, actions, conditions, and references explicit.
- Keep important facts, qualifications, and technical identifiers intact.
- Remove filler, repeated points, and complexity that adds no meaning.

The test: Can the intended reader understand each sentence on the first pass without losing important information?

### 6. Prefer Visual Explanations When They Improve Understanding

**Show the relationship. Label what matters.**

Add a visual when it improves understanding. A simple fact or action usually needs only text.

When explaining:
- Use a diagram for components, dependencies, or architecture.
- Use a flowchart for steps, branches, or decisions.
- Use a table for options, mappings, or comparisons.
- Use an image when shape, position, or appearance carries the meaning.
- Keep labels, arrows, units, and legends clear. Match them to the facts.
- Include a short text takeaway so the reader knows what to notice.
- Remove decoration and detail that hide the main relationship.

The test: Does the visual make the relationship easier to understand than the equivalent prose?

### 7. Use Interactive Outputs for Complex Topics

**Let the reader change something and see why it matters.**

Interactivity must teach something. Keep the artifact as small as the learning problem allows.

When static output is insufficient:
- Identify what the reader needs to explore: inputs, states, sequence, or cause and effect.
- Create an HTML/web-based explainer focused on that learning goal.
- Use sliders, toggles, step controls, or worked examples with visible feedback.
- Use animation to explain change over time. Provide pause or replay when useful.
- Start with a meaningful default state and a short explanation of the controls.
- Keep essential conclusions available in text as well as through interaction.
- Verify the initial view and representative interactions before sharing the artifact.
- Provide the usable file or preview link with a brief takeaway.

The test: Does interacting with the artifact reveal something the static explanation could not show clearly?

### 8. Match the Output Medium to the Learning Problem

**Choose the format that makes the topic easiest to understand.**

Prefer richer formats when they materially improve comprehension. Account for the reader's time and the cost of producing and using the output.

Before producing an explanation:
- Respect the user's requested format, audience, and constraints.
- Consider the progression: **text → diagram → interactive webpage → explainer video**. It is a set of options, not a mandatory sequence.
- Use text for direct answers, definitions, and short instructions.
- Use a diagram, table, or image when relationships or comparisons carry the meaning.
- Use an interactive webpage when the reader needs to explore variables, states, or examples.
- Use a custom explainer video when a guided visual sequence, motion, or narration materially improves understanding.
- Choose the simplest format that meets the learning goal. Richer output should add insight, not just polish.
- If the chosen medium is unavailable, provide a usable alternative and state the limitation.

The test: What can the reader understand in this format that would be harder to understand in a simpler one?

All eight principles are packaged in one [`karpathy-output-guidelines` skill](./skills/karpathy-output-guidelines/SKILL.md).

## Using with Cursor

See **[CURSOR.md](CURSOR.md)** to copy the skill into Cursor or create an always-applied project rule.

## Key Insight

From Andrej:

> "LLMs are exceptionally good at looping until they meet specific goals... Don't tell it what to do, give it success criteria and watch it go."

The "Goal-Driven Execution" principle captures this: transform imperative instructions into declarative goals with verification loops.

## How to Know It's Working

These guidelines are working if you see:

- **Fewer unnecessary changes in diffs** — Only requested changes appear
- **Fewer rewrites due to overcomplication** — Code is simple the first time
- **Clarifying questions come before implementation** — Not after mistakes
- **Clean, minimal PRs** — No drive-by refactoring or "improvements"
- **Clearer explanations** — Precise language and visuals that expose the important relationships
- **Useful richer outputs** — Interactivity or video teaches something that simpler output would make harder to understand

## Customization

These guidelines are designed to be merged with project-specific instructions in `AGENTS.md` or `CLAUDE.md`. Preserve your existing project instructions when adding or updating these guidelines.

For project-specific rules, add sections like:

```markdown
## Project-Specific Guidelines

- Use TypeScript strict mode
- All API endpoints must have tests
- Follow the existing error handling patterns in `src/utils/errors.ts`
```

## Tradeoff Note

These guidelines bias toward **caution over speed**. For trivial tasks (simple typo fixes, obvious one-liners), use judgment — not every change needs the full rigor.

The goal is reducing costly mistakes on non-trivial work, not slowing down simple tasks.

## License

MIT
