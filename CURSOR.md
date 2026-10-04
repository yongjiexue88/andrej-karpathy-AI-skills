# Using this repo with Cursor

This repository provides one [`karpathy-output-guidelines` skill](skills/karpathy-output-guidelines/SKILL.md) with four coding principles and four output control rules. [`AGENTS.md`](AGENTS.md) and [`CLAUDE.md`](CLAUDE.md) contain the same eight principles.

## Personal Agent Skills

Copy the [`karpathy-output-guidelines` folder](skills/karpathy-output-guidelines) to `~/.cursor/skills/karpathy-output-guidelines/`, under the user-level directory described in the official [Cursor skill documentation](https://cursor.com/docs/skills#skill-directories). Start a new agent session after copying the skill.

## Project Rules

To apply all eight principles as a project rule, create a file such as `.cursor/rules/karpathy-output-guidelines.mdc` in the target project. Add this frontmatter, then paste the contents of [`CLAUDE.md`](CLAUDE.md) below it:

```yaml
---
description: Coding and output control guidelines inspired by Andrej Karpathy.
alwaysApply: true
---
```

## For contributors

Keep [`AGENTS.md`](AGENTS.md), [`CLAUDE.md`](CLAUDE.md), and the combined [`SKILL.md`](skills/karpathy-output-guidelines/SKILL.md) aligned. Update both READMEs when changing the skill or installation instructions.
