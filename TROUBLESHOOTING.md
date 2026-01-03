# Troubleshooting CADL

Common issues and solutions.

## Loop Won't Start

### Symptom
`/loop` stops immediately or doesn't pick tasks.

### Causes & Solutions

**No ready tasks**
```bash
# Check for ready tasks
grep "Status: ready" .claude/state/task-queue.md
```
Fix: Add tasks with `Status: ready` or unblock dependencies.

**Blocked items exist**
```bash
# Check blocked file
cat .claude/state/blocked.md
```
Fix: Resolve blocked items or remove them.

**Hooks not executable**
```bash
# Fix permissions
chmod +x .claude/hooks/*.sh
```

**Invalid hook JSON**
```bash
# Test hook directly
.claude/hooks/loop-control.sh
```
Fix: Check hook script for syntax errors.

---

## State Files Out of Sync

### Symptom
Task shows complete but still in queue, or vice versa.

### Solution
```bash
# Find all task references
grep -h "TASK-" .claude/state/*.md | sort | uniq -c

# Manual reconciliation
# Move task to correct file
```

### Prevention
- Always update state files atomically
- Use orchestrator for task transitions
- Don't manually edit during active loop

---

## Context Fills Too Fast

### Symptom
Need to rotate every 30-45 mins instead of 2+ hours.

### Causes & Solutions

**Reading full files unnecessarily**
- Use targeted reads: specific lines, grep results
- Don't paste entire files into prompts

**Not compacting regularly**
- Run `/compact` at 50% instead of waiting for 60%
- More frequent soft rotations

**Large state files**
- Archive old completed tasks monthly
- Keep task-queue.md under 100 tasks

**Verbose agent outputs**
- Configure agents to summarise, not dump
- Use structured output formats

---

## Rate Limited Mid-Session

### Symptom
Slow responses, model fallback, or rate limit errors.

### Immediate Actions
1. Switch to Sonnet for remaining work
2. Note current task state
3. Defer Opus tasks to tomorrow

### Prevention
- Track usage in usage-log.md
- Front-load Opus work Mon-Wed
- Keep 20% weekly buffer
- Use `claude --model opusplan`

### Recovery
```bash
# Check usage
cat .claude/state/usage-log.md

# Adjust remaining week
# Reduce daily Opus target
```

---

## Handoff Recovery Fails

### Symptom
After `/clear`, can't resume from handoff.

### Causes & Solutions

**handoff.md not created**
- Always run `/handoff` before `/clear`
- Check file exists: `ls .claude/state/handoff.md`

**handoff.md incomplete**
- Verify all sections populated
- Re-create if necessary from git history

**State files corrupted**
```bash
# Restore from git
git checkout .claude/state/task-queue.md
git checkout .claude/state/in-progress.md
```

### Manual Recovery
1. Read completed.md to see what's done
2. Read task-queue.md to see what's left
3. Reconstruct in-progress.md if needed
4. Continue from last known good state

---

## Hook Execution Fails

### Symptom
Hooks don't run or return errors.

### Debugging
```bash
# Check hook exists
ls -la .claude/hooks/

# Test hook directly
bash -x .claude/hooks/loop-control.sh

# Check for dependencies
which jq  # loop-control needs jq on some systems
```

### Common Fixes

**Missing shebang**
```bash
# First line should be:
#!/bin/bash
```

**Windows line endings**
```bash
# Convert to Unix
sed -i 's/\r$//' .claude/hooks/*.sh
```

**Wrong working directory**
Hooks run from project root. Use relative paths from there.

---

## Agent Dispatch Fails

### Symptom
Orchestrator doesn't route to correct agent.

### Causes & Solutions

**Missing agent file**
```bash
ls .claude/agents/
# Should have: orchestrator, explorer, implementer, tester, reviewer, debugger
```

**Task type unclear**
- Add explicit `Agent:` field in task
- Use clear task descriptions

**Agent file malformed**
- Check for Markdown syntax errors
- Verify model specification present

---

## Tests Fail in Quality Gate

### Symptom
Pre-commit blocks all commits.

### Quick Fix (emergency only)
```bash
git commit --no-verify -m "Emergency: [reason]"
```
Document in decisions.md.

### Proper Fix
1. Check which tests fail: `npm test`
2. Fix failing tests
3. Re-run quality gate
4. Commit normally

### Disable Gate Temporarily
Edit `.claude/settings.json`:
```json
{
  "hooks": {
    "PreToolUse": []
  }
}
```
Re-enable after fixing issues.

---

## Performance Degradation

### Symptom
Tasks taking longer, quality declining.

### Causes & Solutions

**Context bloat**
- Rotate more frequently
- Clear irrelevant conversation

**Wrong model for task**
- Check agent model assignments
- Upgrade to Opus for complex tasks

**Fragmented state**
- Consolidate state files
- Clean up completed.md

**Too many parallel concerns**
- Focus on one task at a time
- Reduce scope of in-progress work

---

## GitHub Push Fails

### Symptom
Can't push state to remote.

### Solutions

**Auth expired**
- Regenerate GitHub token
- Update remote URL

**Conflicts**
```bash
git pull --rebase origin main
git push
```

**Protected branch**
- Push to feature branch
- Create PR

---

## Quick Reference

| Issue | Quick Check | Quick Fix |
|-------|-------------|-----------|
| Loop won't start | `grep "ready" task-queue.md` | Add ready tasks |
| Hook fails | `.claude/hooks/loop-control.sh` | `chmod +x` |
| Rate limited | Check usage-log.md | Switch to Sonnet |
| Context full | `/status context` | `/handoff` + `/compact` |
| State corrupted | `git status` | `git checkout .claude/state/` |
| Tests fail | `npm test` | Fix tests, then commit |

## Getting Help

1. Check this guide
2. Review TESTING.md for validation steps
3. Check decisions.md for past issues
4. Search repo issues on GitHub
5. Document new issues in blocked.md
