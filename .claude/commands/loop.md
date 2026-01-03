# /loop - Start Autonomous Development Loop

Initiates continuous autonomous operation using CADL framework.

## Usage
```
/loop [options]
```

## Options
- `--max-tasks N`: Stop after N tasks (default: unlimited)
- `--max-hours N`: Stop after N hours (default: 8)
- `--dry-run`: Show what would be done without executing
- `--opus-only`: Use Opus for all tasks (burns budget faster)
- `--sonnet-only`: Use Sonnet for all tasks (lower quality, preserves budget)

## Startup Sequence

### 1. Environment Check
```
□ Verify .claude/state/ exists
□ Verify task-queue.md has tasks
□ Verify hooks are executable
□ Check rate limit status
```

### 2. Load State
```
□ Read task-queue.md
□ Read in-progress.md
□ Read blocked.md
□ Read decisions.md
```

### 3. Resume or Start
If in-progress.md has active task:
- Resume from last checkpoint
- Complete in-progress task first

If in-progress.md empty:
- Pick highest priority ready task
- Begin fresh

### 4. Enter Loop
```
while (tasks_remain && !rate_limited && context < 60%):
    task = pick_highest_priority_ready_task()
    agent = determine_agent(task)
    
    move_to_in_progress(task)
    result = dispatch_to_agent(agent, task)
    
    if result.success:
        move_to_completed(task)
        unblock_dependent_tasks()
    else if result.blocked:
        move_to_blocked(task)
    else:
        handle_failure(task, result)
    
    check_context_usage()
    check_rate_limits()
```

### 5. Loop Continuation
The Stop hook (`loop-control.sh`) checks:
- Tasks remaining in queue?
- Any blockers requiring human input?
- Rate limits okay?

Returns `continue: true` to keep going.

## Example Session

```
> /loop

🔄 CADL Loop Starting

📋 State Loaded
   - Tasks queued: 12
   - In progress: 0
   - Blocked: 0
   - Completed: 3

🎯 Picking Task
   - Selected: TASK-004 (Priority 1, ready)
   - Agent: implementer
   - Est: 25 mins

🚀 Dispatching to Implementer
   [implementation work happens]

✅ Task Complete
   - TASK-004 moved to completed
   - Unblocked: TASK-007, TASK-008

📊 Status
   - Context: 23%
   - Session time: 0:25
   - Tasks done: 1

🔄 Continuing...
   - Selected: TASK-007 (Priority 2, ready)
   ...
```

## Stop Conditions

Loop stops when:
1. **Queue empty**: All tasks complete
2. **Blocked**: Task requires human input
3. **Rate limited**: Opus hours exhausted
4. **Context full**: Needs rotation (will resume after)
5. **Max tasks reached**: If `--max-tasks` specified
6. **Max hours reached**: If `--max-hours` specified
7. **Critical error**: Unrecoverable failure

## Manual Intervention

To interrupt the loop:
- Press `Ctrl+C` (graceful stop)
- Type `stop` when prompted
- Edit blocked.md to force stop

## Recovery

If loop crashes:
1. Check in-progress.md for partial work
2. Check completed.md for last success
3. Run `/status` to assess
4. Run `/loop` to resume

## Best Practices

### Before Starting
- Ensure task queue is populated
- Review blocked items
- Check weekly Opus budget
- Plan approximate session duration

### During Loop
- Monitor context usage
- Watch for quality degradation
- Let it run - avoid interrupting

### After Loop
- Review completed.md
- Check for blocked items
- Update task queue with new tasks
- Log session in usage-log.md

## Troubleshooting

### Loop stops immediately
Check:
- task-queue.md has tasks with `status: ready`
- No items in blocked.md
- Hooks are executable (`chmod +x`)

### Loop skips tasks
Check:
- Task dependencies are satisfied
- Task status is `ready` not `blocked`

### Context fills too fast
- Enable aggressive compaction
- Break tasks into smaller units
- Reduce file reading scope

### Rate limited mid-session
- Switch to Sonnet-only mode
- Defer remaining tasks
- Resume tomorrow
