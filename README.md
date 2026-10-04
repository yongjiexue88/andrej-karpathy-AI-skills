# Karpathy-Inspired Coding and Output Guidelines

[Project repository](https://github.com/yongjiexue88/andrej-karpathy-output-skills)

One reusable skill with four coding principles and four output control rules for AI agents. The coding principles are derived from [Andrej Karpathy's observations](https://x.com/karpathy/status/2015883857489522876) on LLM coding pitfalls. The output rules follow his advice on making model outputs easier to understand.

Use [`skills/karpathy-output-guidelines/SKILL.md`](./skills/karpathy-output-guidelines/SKILL.md), or the combined [`AGENTS.md`](./AGENTS.md) and [`CLAUDE.md`](./CLAUDE.md) for all eight rules. `AGENTS.md` is the standard instruction filename for Codex; `CLAUDE.md` serves Claude Code.

English | [简体中文](./README.zh.md)

## Install with Your Agent

Copy this prompt into Codex, Claude Code, or Cursor:

```text
Install karpathy-output-guidelines from https://github.com/yongjiexue88/andrej-karpathy-output-skills for this agent following the repository's README, preserve existing skills and project instructions, and verify the installation.
```

## Quick Install

```bash
git clone https://github.com/yongjiexue88/andrej-karpathy-output-skills.git
cd andrej-karpathy-output-skills
bash install.sh
```

This installs one skill containing all eight rules for Codex. If you already have this checkout, run `bash install.sh` in it. See [Install](#install) for Claude Code, Cursor, and project instructions.

## The Problems

From Andrej's post:

> "The models make wrong assumptions on your behalf and just run along with them without checking. They don't manage their confusion, don't seek clarifications, don't surface inconsistencies, don't present tradeoffs, don't push back when they should."

> "They really like to overcomplicate code and APIs, bloat abstractions, don't clean up dead code... implement a bloated construction over 1000 lines when 100 would do."

> "They still sometimes change/remove comments and code they don't sufficiently understand as side effects, even if orthogonal to the task."

## The Solution

Four coding principles that directly address these issues:

| Principle | Addresses |
|-----------|-----------|
| **Think Before Coding** | Wrong assumptions, hidden confusion, missing tradeoffs |
| **Simplicity First** | Overcomplication, bloated abstractions |
| **Surgical Changes** | Orthogonal edits, touching code you shouldn't |
| **Goal-Driven Execution** | Leverage through tests-first, verifiable success criteria |

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

## Output Control Rules

As agents do more work autonomously, more of our work becomes oversight and understanding. Agents can help by producing clear writing and custom diagrams, interactive pages, or explainer videos suited to the topic.

| Rule | Agent behavior |
|-----------------------|----------------|
| **Prefer clarity over complexity** | Use simple, precise writing. Aim for roughly 80% of ASD-STE100's clarity principles: short sentences, direct language, and minimal ambiguity. |
| **Prefer visual explanations** | Use diagrams, flowcharts, tables, or images when they clarify relationships, processes, comparisons, or architecture. |
| **Use interactive outputs for complex topics** | Create an HTML/web-based explainer when the reader needs to explore inputs, states, sequences, or examples that static output cannot explain clearly. |
| **Match the output medium to the learning problem** | Consider **text → diagram → interactive webpage → explainer video**. Choose richer formats when they materially improve comprehension, not just appearance. |

All eight principles live in one [`karpathy-output-guidelines` skill](./skills/karpathy-output-guidelines/SKILL.md). The output rules follow the existing style: a concise principle, concrete agent instructions, a tradeoff, and a comprehension check. The 80% target is a writing heuristic, not formal ASD-STE100 compliance. The format progression is a set of options, not a required sequence.

## Install

**Personal skill**

Run the installer from the repository root. It requires Bash and standard shell utilities on macOS, Linux, or Windows with Git Bash/WSL.

| Agent | Command | Destination |
|-------|---------|-------------|
| Codex (default) | `bash install.sh` | `$CODEX_HOME/skills`, or `~/.codex/skills` when unset |
| Claude Code | `bash install.sh claude` | `~/.claude/skills` |
| Cursor | `bash install.sh cursor` | `~/.cursor/skills` |

The Claude Code and Cursor destinations follow their official [Claude Code skill documentation](https://code.claude.com/docs/en/skills#choose-where-skills-load) and [Cursor skill documentation](https://cursor.com/docs/skills#skill-directories).

Start a new agent session after installation. Skills load when relevant; project instruction files apply as the project's standing guidance.

**Project instructions: AGENTS.md and CLAUDE.md**

To add all eight rules to an existing project:

```bash
bash install.sh project "/path/to/your/project"
```

This creates or updates `AGENTS.md` and `CLAUDE.md`. Existing project instructions stay intact. The installer manages one marked block, so re-running it updates the rules without duplicating them. Changed files get a backup beside the destination; unchanged files are skipped.

**Custom skills directory**

To choose another destination:

```bash
bash install.sh codex --dest "/path/to/skills"
```

Run `bash install.sh --help` for usage. You can also manually copy the [`karpathy-output-guidelines` folder](./skills/karpathy-output-guidelines) into your agent's skills directory, or merge the relevant instruction file into your project.

## Using with Cursor

Run `bash install.sh cursor` to install the combined skill. See **[CURSOR.md](CURSOR.md)** for setup and creating an always-applied project rule.

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

These guidelines are designed to be merged with project-specific instructions in `AGENTS.md` or `CLAUDE.md`. Keep your own instructions outside the installer's marked block so future updates preserve them.

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
