# Task Queue

## Week 1 Foundation - COMPLETE ✅
All 16 tasks completed. See completed.md.

## Week 2: Testing & Validation

### Priority 1 (Critical) - Smoke Tests

- [ ] TASK-017: Test loop-control hook manually
  - Status: ready
  - Est: 15 mins
  - Agent: tester
  - Dependencies: none
  - Notes: Run hook directly, verify JSON output

- [ ] TASK-018: Test pre-commit hook manually
  - Status: ready
  - Est: 15 mins
  - Agent: tester
  - Dependencies: none
  - Notes: Run with passing/failing scenarios

- [ ] TASK-019: Test orchestrator state file reading
  - Status: ready
  - Est: 20 mins
  - Agent: tester
  - Dependencies: none
  - Notes: Verify orchestrator reads all state files correctly

### Priority 2 (High) - Integration Tests

- [ ] TASK-020: Test single task execution flow
  - Status: blocked
  - Est: 30 mins
  - Agent: tester
  - Dependencies: TASK-017, TASK-018, TASK-019
  - Notes: Orchestrator picks task, dispatches, updates state

- [ ] TASK-021: Test context rotation trigger
  - Status: ready
  - Est: 25 mins
  - Agent: tester
  - Dependencies: none
  - Notes: Verify rotation triggers at 60% threshold

- [ ] TASK-022: Test handoff file creation
  - Status: ready
  - Est: 20 mins
  - Agent: tester
  - Dependencies: none
  - Notes: Verify /handoff creates proper handoff.md

### Priority 3 (Medium) - Loop Tests

- [ ] TASK-023: Test 30-minute autonomous loop
  - Status: blocked
  - Est: 45 mins
  - Agent: tester
  - Dependencies: TASK-020
  - Notes: Run loop, verify multiple tasks complete

- [ ] TASK-024: Test loop stop conditions
  - Status: blocked
  - Est: 20 mins
  - Agent: tester
  - Dependencies: TASK-020
  - Notes: Empty queue, blocked item, rate limit

- [ ] TASK-025: Test recovery from handoff
  - Status: blocked
  - Est: 25 mins
  - Agent: tester
  - Dependencies: TASK-022
  - Notes: Create handoff, clear, resume from state

### Priority 4 (Low) - Documentation

- [ ] TASK-026: Write TESTING.md guide
  - Status: ready
  - Est: 30 mins
  - Agent: implementer
  - Dependencies: none
  - Notes: How to run and verify CADL tests

- [ ] TASK-027: Write TROUBLESHOOTING.md guide
  - Status: ready
  - Est: 30 mins
  - Agent: implementer
  - Dependencies: none
  - Notes: Common issues and solutions

- [ ] TASK-028: Update README with Week 1 completion
  - Status: ready
  - Est: 15 mins
  - Agent: implementer
  - Dependencies: none
  - Notes: Update status, add usage examples
