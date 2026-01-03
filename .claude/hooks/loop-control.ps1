# CADL Loop Control Hook (PowerShell)
# Returns JSON to tell Claude Code whether to continue

$taskQueue = ".claude/state/task-queue.md"
$blocked = ".claude/state/blocked.md"

# Check for blocked items
if (Test-Path $blocked) {
    $blockedContent = Get-Content $blocked -Raw
    if ($blockedContent -match "- \[ \] TASK-") {
        @{
            decision = "block"
            continue = $false
            stopReason = "Blocked items require human input. Check .claude/state/blocked.md"
        } | ConvertTo-Json -Compress
        exit 0
    }
}

# Check for ready tasks
if (Test-Path $taskQueue) {
    $queueContent = Get-Content $taskQueue -Raw
    if ($queueContent -match "Status: ready") {
        @{
            decision = "approve"
            continue = $true
        } | ConvertTo-Json -Compress
        exit 0
    }
}

# No ready tasks
@{
    decision = "approve"
    continue = $false
    stopReason = "Task queue empty. All work complete."
} | ConvertTo-Json -Compress
