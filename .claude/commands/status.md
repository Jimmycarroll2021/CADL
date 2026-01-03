# /status - Show Current CADL State

Displays comprehensive status of the CADL framework and current work.

## Usage
```
/status [section]
```

## Sections
- `tasks`: Task queue and progress
- `agents`: Agent availability and last actions
- `context`: Context window usage
- `rate`: Rate limit status
- `all`: Everything (default)

## Output Format

### Full Status (`/status` or `/status all`)
```
═══════════════════════════════════════════════════
                    CADL STATUS
═══════════════════════════════════════════════════

📋 TASKS
────────────────────────────────────────────────────
Queued:      8 tasks
In Progress: 1 task
Blocked:     0 tasks
Completed:   15 tasks (this session: 6)

Current Task:
  TASK-012: Implement rate monitoring skill
  Agent: implementer (Opus)
  Started: 14:32
  Est: 25 mins

Next Up:
  TASK-013: Create /loop command (ready)
  TASK-014: Create /status command (ready)

Blocked Items:
  None

────────────────────────────────────────────────────

🤖 AGENTS
────────────────────────────────────────────────────
Orchestrator: Active (coordinating)
Explorer:     Idle
Implementer:  Working on TASK-012
Tester:       Idle
Reviewer:     Idle
Debugger:     Idle

────────────────────────────────────────────────────

📊 CONTEXT
────────────────────────────────────────────────────
Usage:        34% ████████░░░░░░░░░░░░░░░░░░░░
Status:       🟢 Healthy
Next Rotation: ~45 mins at current rate
Last Compact:  13:15

────────────────────────────────────────────────────

⏱️ RATE LIMITS
────────────────────────────────────────────────────
Session Duration: 2h 17m
Opus Used:        ~45 mins (session)
Sonnet Used:      ~92 mins (session)

Weekly Budget (Opus):
  Used:      4.5 hrs
  Remaining: 27.5 hrs
  Status:    🟢 On track

────────────────────────────────────────────────────

📈 SESSION METRICS
────────────────────────────────────────────────────
Tasks Completed:  6
Avg Task Time:    22 mins
Success Rate:     100%
Blockers Hit:     0

═══════════════════════════════════════════════════
```

### Task Status (`/status tasks`)
```
📋 TASK STATUS
────────────────────────────────────────────────────

PRIORITY 1 (Critical)
  ✅ TASK-001: Create explorer agent
  ✅ TASK-002: Create implementer agent
  ✅ TASK-003: Create tester agent
  ✅ TASK-004: Create reviewer agent
  ✅ TASK-005: Create debugger agent
  ✅ TASK-006: Create orchestrator agent

PRIORITY 2 (High)
  ✅ TASK-007: Create context-rotate skill
  🔄 TASK-008: Create task-decompose skill
  ⏳ TASK-009: Create quality-gate skill
  ⏳ TASK-010: Create rate-monitor skill

PRIORITY 3 (Medium)
  ⏳ TASK-011: Create pre-commit hook
  ⏳ TASK-012: Create loop-control hook

PRIORITY 4 (Low)
  ⏳ TASK-013: Create /loop command
  ⏳ TASK-014: Create /status command
  ⏳ TASK-015: Create /handoff command

Legend: ✅ Complete | 🔄 In Progress | ⏳ Queued | 🚫 Blocked
────────────────────────────────────────────────────
```

### Context Status (`/status context`)
```
📊 CONTEXT STATUS
────────────────────────────────────────────────────

Current Usage: 34%
████████░░░░░░░░░░░░░░░░░░░░

Thresholds:
  🟢 0-40%   Healthy
  🟡 40-60%  Monitor
  🟠 60-70%  Soft rotation needed
  🔴 70%+    Hard rotation needed

Trend: +2.3% per task average
Estimated tasks until rotation: ~11

Last Actions:
  - Compact at 58% (saved 23%)
  - Clear at 72% (2 sessions ago)

Recommendations:
  ✓ Continue normal operation
────────────────────────────────────────────────────
```

### Rate Status (`/status rate`)
```
⏱️ RATE LIMIT STATUS
────────────────────────────────────────────────────

SESSION
  Duration:    2h 17m
  Opus:        ~45 mins
  Sonnet:      ~92 mins
  Ratio:       33% Opus / 67% Sonnet

WEEKLY BUDGET (Opus)
  ████████░░░░░░░░░░░░░░░░░░░░░░ 14%

  Used:        4.5 hrs
  Remaining:   27.5 hrs
  Daily Avg:   0.9 hrs (target: 4.5 hrs)

PROJECTION
  At current rate: 8.2 hrs/week ✓
  Buffer:          23.8 hrs
  Status:          🟢 Well under budget

RECOMMENDATIONS
  ✓ Normal Opus usage acceptable
  ✓ Could increase Opus for complex tasks
────────────────────────────────────────────────────
```

## Implementation

The /status command reads from state files:
- `.claude/state/task-queue.md`
- `.claude/state/in-progress.md`
- `.claude/state/completed.md`
- `.claude/state/blocked.md`
- `.claude/state/usage-log.md`

## Quick Status

For minimal output during loop:
```
/status --brief
```

Output:
```
CADL: 6/15 tasks | 34% context | 4.5/32 Opus hrs | 🟢 healthy
```
