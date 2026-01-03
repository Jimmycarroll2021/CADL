# Context Rotation Skill

Manages context window usage to prevent degradation and information loss.

## When to Load
- Context usage exceeds 60%
- Response quality appears degraded
- Before starting large tasks
- After completing major milestones

## Context Thresholds

| Usage | Status | Action |
|-------|--------|--------|
| < 40% | Green | Continue normally |
| 40-60% | Yellow | Monitor, prepare for rotation |
| 60-70% | Orange | Initiate soft rotation |
| > 70% | Red | Initiate hard rotation |

## Soft Rotation (60-70%)

Use when context is filling but quality is still good.

### Process
1. Run `/compact` to compress context
2. Verify state files are current
3. Continue working

### Command
```
/compact
```

### Verification
After compaction, check:
- Can still access recent decisions
- State files are readable
- Current task context preserved

## Hard Rotation (>70% or quality degraded)

Use when compaction isn't enough or quality is degrading.

### Process
1. Update all state files with current status
2. Create handoff summary
3. Clear context
4. Resume from state files

### Pre-Rotation Checklist
Before running `/clear`:
- [ ] task-queue.md is current
- [ ] in-progress.md has current task status
- [ ] decisions.md has any new decisions
- [ ] Any blocking issues in blocked.md
- [ ] Handoff notes written

### Create Handoff
Write to `.claude/state/handoff.md`:
```markdown
# Session Handoff

## Timestamp
[ISO timestamp]

## Context
[What was being worked on]

## Current Task
TASK-XXX: [description]
- Status: [in progress/blocked/ready for next step]
- Progress: [what's done, what remains]

## Key Context
- [Important decision made]
- [File that was being modified]
- [Issue encountered]

## Next Steps
1. [Immediate next action]
2. [Following action]

## Warnings
- [Anything to watch out for]
```

### Execute Rotation
```
/clear
```

### Post-Rotation
1. Read CLAUDE.md
2. Read state files in order:
   - handoff.md (if exists)
   - task-queue.md
   - in-progress.md
   - decisions.md
3. Resume from handoff point

## Monitoring Context Usage

### Signs of High Context
- Responses becoming slower
- Forgetting earlier conversation
- Repeating information already discussed
- Errors in recalling file contents

### Signs of Quality Degradation
- Inconsistent responses
- Missing obvious connections
- Forgetting task constraints
- Hallucinating file contents

## Emergency Rotation

If context fills unexpectedly:
1. Immediately save current state to in-progress.md
2. Note any unsaved work
3. Run `/clear`
4. Resume from state files

## Best Practices

### Reduce Context Accumulation
- Don't paste full file contents unless necessary
- Use targeted file reads
- Clear irrelevant conversation threads
- Keep state in files, not conversation

### Proactive Rotation
- Rotate at natural breakpoints (task completion)
- Don't wait until forced
- Schedule rotation every 2-3 hours of active work

### State File Discipline
- Update state files continuously, not just at rotation
- Include enough context to resume cold
- Keep handoff notes brief but complete
