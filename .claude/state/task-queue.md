# Task Queue

## Week 1: Foundation - COMPLETE ✅
## Week 2: Testing Infrastructure - COMPLETE ✅

---

## Week 2: Manual Testing - REMAINING

### Priority 1 (Critical) - Smoke Tests

- [ ] TASK-017: Test loop-control hook manually
  - Status: ready
  - Est: 15 mins
  - Agent: tester
  - Notes: Run hook directly in terminal, verify JSON output

- [ ] TASK-018: Test pre-commit hook manually
  - Status: ready
  - Est: 15 mins
  - Agent: tester
  - Notes: Test with passing and failing scenarios

- [ ] TASK-019: Test orchestrator state file reading
  - Status: ready
  - Est: 20 mins
  - Agent: tester
  - Notes: Start Claude Code, verify it reads all state files

### Priority 2 (High) - Integration Tests

- [ ] TASK-020: Test single task execution flow
  - Status: blocked
  - Est: 30 mins
  - Agent: tester
  - Dependencies: TASK-017, TASK-018, TASK-019
  - Notes: Full cycle: pick task → dispatch → complete → update state

- [ ] TASK-021: Test context rotation trigger
  - Status: ready
  - Est: 25 mins
  - Agent: tester
  - Notes: Simulate high context, verify skill triggers

- [ ] TASK-022: Test handoff file creation
  - Status: ready
  - Est: 20 mins
  - Agent: tester
  - Notes: Run /handoff, verify handoff.md created correctly

### Priority 3 (Medium) - Loop Tests

- [ ] TASK-023: Test 30-minute autonomous loop
  - Status: blocked
  - Est: 45 mins
  - Agent: tester
  - Dependencies: TASK-020
  - Notes: Run /loop, verify multiple tasks complete

- [ ] TASK-024: Test loop stop conditions
  - Status: blocked
  - Est: 20 mins
  - Agent: tester
  - Dependencies: TASK-020
  - Notes: Test empty queue, blocked item, rate limit scenarios

- [ ] TASK-025: Test recovery from handoff
  - Status: blocked
  - Est: 25 mins
  - Agent: tester
  - Dependencies: TASK-022
  - Notes: Create handoff → clear → resume from state

---

## Backlog

These require manual testing to complete. Run them in Claude Code:

1. Clone repo locally
2. `chmod +x .claude/hooks/*.sh scripts/*.sh`
3. Start `claude` in the directory
4. Work through tasks TASK-017 through TASK-025
