# Task Queue

## Priority 1 (Critical) - Week 1 Foundation

- [ ] TASK-001: Create explorer agent definition
  - Status: ready
  - Est: 20 mins
  - Files: .claude/agents/explorer.md
  - Dependencies: none
  - Notes: Read-only codebase search, uses Sonnet

- [ ] TASK-002: Create implementer agent definition
  - Status: ready
  - Est: 20 mins
  - Files: .claude/agents/implementer.md
  - Dependencies: none
  - Notes: Write access, uses Opus for complex work

- [ ] TASK-003: Create tester agent definition
  - Status: ready
  - Est: 15 mins
  - Files: .claude/agents/tester.md
  - Dependencies: none
  - Notes: Runs tests, writes new tests, uses Sonnet

- [ ] TASK-004: Create reviewer agent definition
  - Status: ready
  - Est: 15 mins
  - Files: .claude/agents/reviewer.md
  - Dependencies: none
  - Notes: Code review, quality check, uses Opus

- [ ] TASK-005: Create debugger agent definition
  - Status: ready
  - Est: 15 mins
  - Files: .claude/agents/debugger.md
  - Dependencies: none
  - Notes: Diagnose and fix issues, uses Opus

- [ ] TASK-006: Create orchestrator agent definition
  - Status: ready
  - Est: 30 mins
  - Files: .claude/agents/orchestrator.md
  - Dependencies: TASK-001 through TASK-005
  - Notes: Coordinates all specialists, uses Sonnet

## Priority 2 (High) - Week 1 Skills

- [ ] TASK-007: Create context-rotate skill
  - Status: ready
  - Est: 25 mins
  - Files: .claude/skills/context-rotate/SKILL.md
  - Dependencies: none
  - Notes: Manages context window, triggers at 60%

- [ ] TASK-008: Create task-decompose skill
  - Status: ready
  - Est: 20 mins
  - Files: .claude/skills/task-decompose/SKILL.md
  - Dependencies: none
  - Notes: Breaks large tasks into atomic units

- [ ] TASK-009: Create quality-gate skill
  - Status: ready
  - Est: 20 mins
  - Files: .claude/skills/quality-gate/SKILL.md
  - Dependencies: none
  - Notes: Evaluates work quality before proceeding

- [ ] TASK-010: Create rate-monitor skill
  - Status: ready
  - Est: 20 mins
  - Files: .claude/skills/rate-monitor/SKILL.md
  - Dependencies: none
  - Notes: Tracks Opus vs Sonnet usage for Max sub

## Priority 3 (Medium) - Week 1 Hooks

- [ ] TASK-011: Create pre-commit hook
  - Status: ready
  - Est: 30 mins
  - Files: .claude/hooks/pre-commit.sh, .claude/settings.json
  - Dependencies: none
  - Notes: Blocks commits if tests fail

- [ ] TASK-012: Create loop-control hook
  - Status: ready
  - Est: 30 mins
  - Files: .claude/hooks/loop-control.sh
  - Dependencies: none
  - Notes: Enables continuous operation via Stop hook

## Priority 4 (Low) - Week 1 Commands

- [ ] TASK-013: Create /loop slash command
  - Status: ready
  - Est: 20 mins
  - Files: .claude/commands/loop.md
  - Dependencies: TASK-006, TASK-012
  - Notes: Starts autonomous development loop

- [ ] TASK-014: Create /status slash command
  - Status: ready
  - Est: 15 mins
  - Files: .claude/commands/status.md
  - Dependencies: none
  - Notes: Shows current state, queue, progress

- [ ] TASK-015: Create /handoff slash command
  - Status: ready
  - Est: 15 mins
  - Files: .claude/commands/handoff.md
  - Dependencies: TASK-007
  - Notes: Prepares state for session transition
