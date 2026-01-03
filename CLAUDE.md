# CADL: Continuous Autonomous Development Loop

## Project
Building CADL - a framework for 8+ hour autonomous Claude Code operation.

## Commands
- Build: N/A (framework, not application)
- Test: `./scripts/test-hooks.sh` (when created)
- Lint: N/A

## State Management
This project uses external state files for coordination.
**Always read state files before starting work.**

- `.claude/state/task-queue.md` - Pending tasks
- `.claude/state/in-progress.md` - Current work
- `.claude/state/completed.md` - Done items
- `.claude/state/decisions.md` - Architectural choices
- `.claude/state/blocked.md` - Needs human input

## Agent Coordination
- Orchestrator manages task flow
- Specialists handle specific work types
- Update state files after completing work
- Never rely on conversation memory alone

## Skills
Load on-demand when needed:
- Context full → read `.claude/skills/context-rotate/SKILL.md`
- Complex task → read `.claude/skills/task-decompose/SKILL.md`
- Before commit → read `.claude/skills/quality-gate/SKILL.md`

## Constraints
- Never refactor beyond task scope
- Always update state files after work
- If blocked, log to blocked.md and stop
- Preserve 20% weekly Opus hours buffer

## Working Pattern
1. Read task-queue.md
2. Pick highest priority ready task
3. Move to in-progress.md
4. Complete work
5. Move to completed.md
6. Repeat
