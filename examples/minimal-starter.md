# CADL Minimal Starter

A stripped-down CADL setup for adding to existing projects.

## Quick Setup

Copy these files to your project:

```
your-project/
├── CLAUDE.md           # Copy and customise
└── .claude/
    ├── settings.json   # Copy as-is
    ├── state/
    │   ├── task-queue.md    # Copy template
    │   └── completed.md     # Copy template
    └── hooks/
        └── loop-control.sh  # Copy as-is
```

## Minimal CLAUDE.md

```markdown
# [Your Project Name]

## Project
[One-line description]

## Commands
- Build: `npm run build`
- Test: `npm test`
- Lint: `npm run lint`

## State Management
Read state before starting work:
- `.claude/state/task-queue.md` - Pending tasks
- `.claude/state/completed.md` - Done items

## Working Pattern
1. Read task-queue.md
2. Pick highest priority ready task
3. Complete work
4. Move to completed.md
5. Repeat
```

## Minimal task-queue.md

```markdown
# Task Queue

## Priority 1 (High)

- [ ] TASK-001: [First task]
  - Status: ready
  - Est: 30 mins
  - Notes: [Any context]

- [ ] TASK-002: [Second task]
  - Status: ready
  - Est: 20 mins
  - Notes: [Any context]

## Priority 2 (Medium)

- [ ] TASK-003: [Third task]
  - Status: blocked
  - Dependencies: TASK-001
  - Notes: [Any context]
```

## Minimal completed.md

```markdown
# Completed

## [Date]

- [x] TASK-000: Initial setup
  - Completed: [date]
  - Notes: Project initialised
```

## Minimal settings.json

```json
{
  "hooks": {
    "Stop": [
      {
        "matcher": "",
        "hooks": [".claude/hooks/loop-control.sh"]
      }
    ]
  }
}
```

## What You're Skipping

The minimal setup doesn't include:
- Agent definitions (orchestrator handles everything)
- Skills (load from main repo if needed)
- Commands (use manual workflow)
- Pre-commit hooks (add later if needed)
- Usage tracking (add later if needed)

## Upgrading to Full CADL

When ready for the full framework:

```bash
# Copy agents
cp -r /path/to/CADL/.claude/agents .claude/

# Copy skills
cp -r /path/to/CADL/.claude/skills .claude/

# Copy commands
cp -r /path/to/CADL/.claude/commands .claude/

# Update settings.json with full hook config
```

## Usage

```bash
# Start Claude Code
claude

# Work through tasks manually
# Read task-queue.md, complete tasks, update state

# Or if you have loop-control hook:
# CC will continue automatically between tasks
```
