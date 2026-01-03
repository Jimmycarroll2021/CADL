# CADL Validation Runbook

Step-by-step test cases with exact commands and expected outputs.

---

## Prerequisites

### 1. Clone Repository

```bash
git clone https://github.com/Jimmycarroll2021/CADL.git
cd CADL
```

**Expected**: Directory created with all files.

### 2. Set Permissions

```bash
chmod +x .claude/hooks/*.sh scripts/*.sh
```

**Expected**: No output (silent success).

### 3. Verify Structure

```bash
ls -la .claude/
```

**Expected**:
```
drwxr-xr-x  agents
drwxr-xr-x  commands
drwxr-xr-x  hooks
drwxr-xr-x  skills
drwxr-xr-x  state
-rw-r--r--  settings.json
```

---

## Test 1: Hook Scripts (Terminal)

Run these in your terminal BEFORE opening Claude Code.

### 1.1 Loop Control - Tasks Exist

```bash
./.claude/hooks/loop-control.sh
```

**Expected**:
```json
{"decision": "approve", "continue": true}
```

### 1.2 Loop Control - Empty Queue

```bash
mv .claude/state/task-queue.md .claude/state/task-queue.md.bak
echo "# Task Queue" > .claude/state/task-queue.md
./.claude/hooks/loop-control.sh
```

**Expected**:
```json
{"decision": "approve", "continue": false, "stopReason": "Task queue empty. All work complete."}
```

**Restore**:
```bash
mv .claude/state/task-queue.md.bak .claude/state/task-queue.md
```

### 1.3 Loop Control - Blocked Item

```bash
echo "" >> .claude/state/blocked.md
echo "- [ ] TASK-999: Test blocker" >> .claude/state/blocked.md
./.claude/hooks/loop-control.sh
```

**Expected**:
```json
{"decision": "block", "continue": false, "stopReason": "Blocked items require human input. Check .claude/state/blocked.md"}
```

**Restore**:
```bash
git checkout .claude/state/blocked.md
```

### 1.4 Pre-commit Hook

```bash
echo '{}' | ./.claude/hooks/pre-commit.sh
```

**Expected**:
```json
{"decision": "approve"}
```

**Test 1 Result**: All 4 commands return valid JSON? ✅ Hooks working.

---

## Test 2: Claude Code Startup

### 2.1 Open Claude Code

```bash
claude
```

**Expected**: Claude Code opens in terminal.

### 2.2 Check CLAUDE.md Loaded

Copy and paste this into Claude Code:

```
What project am I working on? What are the state files I should read?
```

**Expected Response Should Include**:
- "CADL" or "Continuous Autonomous Development Loop"
- References to `.claude/state/task-queue.md`
- References to `.claude/state/completed.md`

If CC doesn't know about CADL, it hasn't read CLAUDE.md. Check file exists.

---

## Test 3: State File Reading

### 3.1 Read Task Queue

Copy and paste:

```
Read .claude/state/task-queue.md and tell me how many tasks are ready vs blocked.
```

**Expected Response Should Include**:
- Count of tasks with "Status: ready"
- Count of tasks with "Status: blocked"
- Specific task IDs mentioned

### 3.2 Read Completed

Copy and paste:

```
Read .claude/state/completed.md and tell me how many tasks are done.
```

**Expected Response Should Include**:
- "30 tasks" or similar count
- Mention of Week 1 and Week 2

### 3.3 Read Decisions

Copy and paste:

```
Read .claude/state/decisions.md and summarise the architectural decisions.
```

**Expected Response Should Include**:
- ADR-001: State in files
- ADR-002: Agent specialisation
- ADR-003: Opus budget
- ADR-004: Context rotation at 60%
- ADR-005: Hook-based loop

**Test 3 Result**: All state files read correctly? ✅ State management working.

---

## Test 4: Agent Loading

### 4.1 Load Orchestrator

Copy and paste:

```
Read .claude/agents/orchestrator.md and explain what model it uses and why.
```

**Expected Response**:
- Uses Sonnet
- Preserves Opus hours for specialists

### 4.2 Load Implementer

Copy and paste:

```
Read .claude/agents/implementer.md and list what it's allowed and forbidden to do.
```

**Expected Response Should Include**:
- Allowed: Write files, create files, run builds
- Forbidden: Delete without instruction, refactor beyond scope, run tests

**Test 4 Result**: Agent files load and parse? ✅ Agent system working.

---

## Test 5: Skill Loading

### 5.1 Context Rotate Skill

Copy and paste:

```
Read .claude/skills/context-rotate/SKILL.md and tell me at what percentage I should trigger rotation.
```

**Expected Response**:
- 60% for soft rotation
- 70% for hard rotation

### 5.2 Rate Monitor Skill

Copy and paste:

```
Read .claude/skills/rate-monitor/SKILL.md and tell me the weekly Opus budget for Max 20x.
```

**Expected Response**:
- 24-40 hours per week
- ~5 hours per 8-hour session

**Test 5 Result**: Skills load correctly? ✅ Skill system working.

---

## Test 6: Single Task Execution

This tests the full cycle manually.

### 6.1 Create Test Task

First, add a simple test task. Copy and paste:

```
Add this task to the TOP of .claude/state/task-queue.md under a new "## Test" heading:

- [ ] TASK-TEST-001: Read README.md and report word count
  - Status: ready
  - Est: 5 mins
  - Agent: explorer
  - Dependencies: none
  - Notes: Simple validation task
```

### 6.2 Execute Task

Copy and paste:

```
Read .claude/state/task-queue.md, find TASK-TEST-001, and complete it. 

Follow this process:
1. Move task to .claude/state/in-progress.md
2. Read README.md and count words
3. Move task to .claude/state/completed.md with completion notes
4. Report what you did
```

**Expected**:
1. CC reads task queue
2. CC moves task to in-progress
3. CC reads README, counts words
4. CC moves task to completed with timestamp
5. CC reports completion

### 6.3 Verify State Updated

Copy and paste:

```
Read .claude/state/in-progress.md - is it empty?
Read .claude/state/completed.md - is TASK-TEST-001 there with completion time?
```

**Expected**:
- in-progress.md is empty or has template only
- completed.md has TASK-TEST-001 marked done

**Test 6 Result**: Task moved through states correctly? ✅ Task lifecycle working.

---

## Test 7: Handoff Command

### 7.1 Create Handoff

Copy and paste:

```
Read .claude/commands/handoff.md, then create a soft handoff. Write the handoff file to .claude/state/handoff.md with current session state.
```

**Expected**:
- CC creates .claude/state/handoff.md
- File contains timestamp, current state, next steps

### 7.2 Verify Handoff

Copy and paste:

```
Read .claude/state/handoff.md and confirm it has: timestamp, current state, and next steps.
```

**Expected**: All three sections present.

**Test 7 Result**: Handoff file created correctly? ✅ Handoff system working.

---

## Test 8: Recovery from Clear

### 8.1 Note Current State

Copy and paste:

```
Before I clear context, summarise: what tasks are in the queue, what's completed today, and what should happen next?
```

**Save the response somewhere.**

### 8.2 Clear Context

Type:

```
/clear
```

**Expected**: Context cleared, fresh start.

### 8.3 Recover

Copy and paste:

```
Read these files in order and tell me where we left off:
1. .claude/state/handoff.md
2. .claude/state/task-queue.md  
3. .claude/state/in-progress.md
4. .claude/state/completed.md

Then summarise current state and next steps.
```

**Expected**:
- CC reads handoff
- CC understands current state
- CC knows what to do next
- Summary matches what you saved in 8.1

**Test 8 Result**: Recovery works from handoff? ✅ Continuity system working.

---

## Test 9: Loop Continuation (30-min test)

This is the big one. Set aside 30 minutes.

### 9.1 Add Test Tasks

Copy and paste:

```
Add these 3 tasks to .claude/state/task-queue.md under "## Loop Test":

- [ ] TASK-LOOP-001: Count files in .claude/ directory
  - Status: ready
  - Est: 5 mins
  - Agent: explorer
  - Dependencies: none

- [ ] TASK-LOOP-002: List all agent names from .claude/agents/
  - Status: ready
  - Est: 5 mins
  - Agent: explorer
  - Dependencies: none

- [ ] TASK-LOOP-003: Summarise the 5 ADRs from decisions.md
  - Status: ready
  - Est: 5 mins
  - Agent: explorer
  - Dependencies: none
```

### 9.2 Start Loop

Copy and paste:

```
Read .claude/commands/loop.md to understand the loop process.

Then execute the loop:
1. Read task-queue.md
2. Pick highest priority READY task
3. Execute it (following agent instructions)
4. Update state files (move to completed)
5. Check if more ready tasks exist
6. If yes, continue to next task
7. If no, stop

Process TASK-LOOP-001, TASK-LOOP-002, and TASK-LOOP-003 in sequence.
Report after each task completion.
```

### 9.3 Observe

**Expected Behaviour**:
1. CC picks TASK-LOOP-001
2. CC completes it, updates state
3. CC picks TASK-LOOP-002 (without you prompting)
4. CC completes it, updates state
5. CC picks TASK-LOOP-003 (without you prompting)
6. CC completes it, updates state
7. CC reports all 3 done

**Key Observation**: Does CC continue between tasks automatically, or does it stop and wait for you after each one?

- If continues automatically: ✅ Loop working
- If stops after each: Needs hook configuration check

### 9.4 Verify Final State

Copy and paste:

```
Read .claude/state/completed.md and confirm TASK-LOOP-001, TASK-LOOP-002, and TASK-LOOP-003 are all marked complete.
```

**Test 9 Result**: All 3 tasks completed in sequence? ✅ Loop system working.

---

## Test 10: Stop Conditions

### 10.1 Empty Queue Stop

Copy and paste:

```
Read .claude/state/task-queue.md. Are there any tasks with Status: ready?

If not, the loop should stop. Confirm the loop would stop with reason "queue empty".
```

### 10.2 Blocked Stop

Copy and paste:

```
Add a blocked task to .claude/state/blocked.md:

- [ ] TASK-BLOCKED-001: Needs human decision
  - Blocked: 2025-01-03
  - Reason: Testing stop condition

Then check: should the loop continue or stop?
```

**Expected**: Loop should stop due to blocked item.

**Cleanup**:

```
Remove TASK-BLOCKED-001 from .claude/state/blocked.md
```

**Test 10 Result**: Loop stops correctly on empty/blocked? ✅ Stop conditions working.

---

## Results Summary

After completing all tests, fill in:

| Test | Description | Pass/Fail |
|------|-------------|-----------|
| 1.1 | Loop control - tasks exist | |
| 1.2 | Loop control - empty queue | |
| 1.3 | Loop control - blocked item | |
| 1.4 | Pre-commit hook | |
| 2.1 | CC opens | |
| 2.2 | CLAUDE.md loaded | |
| 3.1 | Read task queue | |
| 3.2 | Read completed | |
| 3.3 | Read decisions | |
| 4.1 | Load orchestrator | |
| 4.2 | Load implementer | |
| 5.1 | Context rotate skill | |
| 5.2 | Rate monitor skill | |
| 6.1 | Create test task | |
| 6.2 | Execute task | |
| 6.3 | Verify state | |
| 7.1 | Create handoff | |
| 7.2 | Verify handoff | |
| 8.1 | Note state | |
| 8.2 | Clear context | |
| 8.3 | Recover | |
| 9.1 | Add loop tasks | |
| 9.2 | Start loop | |
| 9.3 | Observe continuation | |
| 9.4 | Verify completion | |
| 10.1 | Empty queue stop | |
| 10.2 | Blocked stop | |

**All Pass?** → CADL validated, ready for real work.

**Some Fail?** → Check TROUBLESHOOTING.md or open GitHub issue.

---

## Cleanup After Testing

```bash
git checkout .claude/state/task-queue.md
git checkout .claude/state/completed.md
git checkout .claude/state/in-progress.md
git checkout .claude/state/blocked.md
rm -f .claude/state/handoff.md
```

This resets state files to original.
