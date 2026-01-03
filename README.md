# CADL: Continuous Autonomous Development Loop

A framework for 8+ hour autonomous Claude Code operation.

## What This Is

CADL enables Claude Code to work continuously on complex projects without losing context or requiring constant human intervention. It achieves this through:

- **External state files** that survive context rotations
- **Specialist agents** for different work types
- **Hooks** that enable loop continuation and quality gates
- **Skills** for context management and task decomposition

## Quick Start

```bash
# Clone this repo
git clone <repo-url> my-project
cd my-project

# Make hooks executable
chmod +x .claude/hooks/*.sh

# Start Claude Code
claude

# Begin autonomous loop
/loop
```

## Directory Structure

```
.claude/
├── state/           # Coordination state (survives /clear)
│   ├── task-queue.md
│   ├── in-progress.md
│   ├── completed.md
│   ├── decisions.md
│   └── blocked.md
├── agents/          # Specialist agent definitions
│   └── orchestrator.md
├── skills/          # On-demand capabilities
├── hooks/           # CC hook scripts
│   ├── loop-control.sh
│   └── pre-commit.sh
├── commands/        # Custom slash commands
└── settings.json    # CC configuration
```

## How It Works

1. **Orchestrator** reads task-queue.md, picks highest priority task
2. **Dispatches** to specialist agent (explorer, implementer, tester, etc.)
3. **Specialist** completes work, updates state files
4. **Stop hook** checks if more work exists, continues if yes
5. **Context rotation** triggers at 60% usage to preserve quality

## Bootstrap Mode

This repo is bootstrapping itself. The initial scaffold was created externally. Claude Code will now build out the remaining components:

- [ ] Explorer, Implementer, Tester, Reviewer, Debugger agents
- [ ] Context rotation, task decomposition, quality gate skills
- [ ] /loop, /status, /handoff commands

Run `/loop` to continue building CADL using CADL.

## Model Usage (Max 20x)

Optimised for Anthropic Max subscription:

| Agent | Model | Reason |
|-------|-------|--------|
| Orchestrator | Sonnet | Coordination doesn't need Opus |
| Explorer | Sonnet | Read-only search |
| Implementer | Opus | Complex reasoning |
| Tester | Sonnet | Procedural work |
| Reviewer | Opus | Quality judgement |
| Debugger | Opus | Diagnosis |

Expected: ~5 Opus hours per 8-hour session.

## Status

**Week 1 of 6** — Foundation phase. See task-queue.md for current work.
