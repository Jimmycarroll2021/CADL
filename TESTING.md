# Testing CADL

Guide for testing and validating CADL framework components.

## Quick Start

```bash
# Make scripts executable
chmod +x .claude/hooks/*.sh
chmod +x scripts/*.sh

# Run hook tests
./scripts/test-hooks.sh
```

## Test Categories

### 1. Hook Tests
Verify hooks return correct JSON responses.

```bash
./scripts/test-hooks.sh
```

Tests:
- loop-control.sh with tasks in queue → `continue: true`
- loop-control.sh with empty queue → `continue: false`
- loop-control.sh with blocked items → `continue: false`
- pre-commit.sh returns valid JSON

### 2. State File Tests
Verify state files parse correctly.

```bash
# Check task queue has valid format
grep -c "Status: ready\|Status: blocked" .claude/state/task-queue.md

# Check completed has entries
grep -c "\[x\] TASK-" .claude/state/completed.md

# Check decisions have dates
grep -c "Date:" .claude/state/decisions.md
```

### 3. Manual Loop Test

Test single task execution:

1. Open Claude Code in CADL directory
2. Read state files manually:
   ```
   Read .claude/state/task-queue.md
   Read .claude/state/in-progress.md
   ```
3. Pick a ready task
4. Execute it following the agent instructions
5. Update state files
6. Verify state reflects completion

### 4. Integration Test

Test full loop (30 mins):

1. Ensure 3-5 ready tasks in queue
2. Run `/loop --max-tasks 3`
3. Observe:
   - Tasks picked in priority order
   - State files updated after each task
   - Loop continues between tasks
   - Loop stops after 3 tasks

Expected outcome:
- 3 tasks moved to completed.md
- in-progress.md is empty
- No orphaned state

### 5. Context Rotation Test

Test rotation trigger:

1. Start work session
2. Fill context to ~55%
3. Read `.claude/skills/context-rotate/SKILL.md`
4. Run `/handoff soft`
5. Run `/compact`
6. Verify can still access state files
7. Continue working

### 6. Recovery Test

Test handoff recovery:

1. Create handoff:
   ```
   /handoff hard
   ```
2. Clear context:
   ```
   /clear
   ```
3. Resume:
   ```
   Read .claude/state/handoff.md
   Read .claude/state/task-queue.md
   ```
4. Verify can continue from handoff point

## Validation Checklist

### Pre-Release
- [ ] All hooks return valid JSON
- [ ] State files have correct format
- [ ] Single task execution works
- [ ] 30-min loop completes without error
- [ ] Context rotation preserves state
- [ ] Recovery from handoff works

### Per-Session
- [ ] `/status` shows correct counts
- [ ] Tasks complete in priority order
- [ ] State files stay in sync
- [ ] No context overflow

## Troubleshooting Test Failures

### Hook returns invalid JSON
```bash
# Debug hook output
bash -x .claude/hooks/loop-control.sh

# Check for syntax errors
shellcheck .claude/hooks/*.sh
```

### State files out of sync
```bash
# Find discrepancies
grep "TASK-" .claude/state/*.md | sort | uniq -c

# Reset state (careful!)
git checkout .claude/state/
```

### Loop stops unexpectedly
Check:
1. blocked.md for items
2. task-queue.md for ready tasks
3. Hook exit codes

```bash
# Test hook directly
.claude/hooks/loop-control.sh
echo $?
```

## Test Data

### Sample task for testing
```markdown
- [ ] TASK-TEST: Test task for validation
  - Status: ready
  - Est: 5 mins
  - Agent: explorer
  - Dependencies: none
  - Notes: Read README.md and report findings
```

Add to task-queue.md for testing, remove after.

## CI/CD Integration

For automated testing in GitHub Actions:

```yaml
name: CADL Tests
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Make scripts executable
        run: chmod +x .claude/hooks/*.sh scripts/*.sh
      - name: Run hook tests
        run: ./scripts/test-hooks.sh
      - name: Validate state files
        run: |
          test -f .claude/state/task-queue.md
          test -f .claude/state/completed.md
          test -f .claude/state/decisions.md
```
