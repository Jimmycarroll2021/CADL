#!/bin/bash
# Loop Control Hook - enables continuous autonomous operation
# Called by Claude Code Stop hook

STATE_DIR=".claude/state"
QUEUE_FILE="$STATE_DIR/task-queue.md"
BLOCKED_FILE="$STATE_DIR/blocked.md"

# Check if task queue has ready tasks
has_ready_tasks() {
    if [ -f "$QUEUE_FILE" ]; then
        grep -q "Status: ready" "$QUEUE_FILE" 2>/dev/null
        return $?
    fi
    return 1
}

# Check if there are blocking issues
has_blockers() {
    if [ -f "$BLOCKED_FILE" ]; then
        # Check if blocked file has actual blocked items (not just template)
        grep -q "^\- \[ \] TASK-" "$BLOCKED_FILE" 2>/dev/null
        return $?
    fi
    return 1
}

# Main logic
if has_blockers; then
    # Stop - human intervention needed
    echo '{"decision": "block", "continue": false, "stopReason": "Blocked items require human input. Check .claude/state/blocked.md"}'
elif has_ready_tasks; then
    # Continue - more work to do
    echo '{"decision": "approve", "continue": true}'
else
    # Stop - queue empty
    echo '{"decision": "approve", "continue": false, "stopReason": "Task queue empty. All work complete."}'
fi
