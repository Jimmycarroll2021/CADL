# /handoff - Prepare for Session Transition

Prepares state for context rotation or session end, ensuring continuity.

## Usage
```
/handoff [type]
```

## Types
- `soft`: Prepare for /compact (default)
- `hard`: Prepare for /clear
- `end`: End of session handoff
- `human`: Handoff to human operator

## When to Use

### Soft Handoff
Context at 60-70%, quality still good.
- Summarises current state
- Prepares for compaction
- Minimal information loss

### Hard Handoff
Context >70% or quality degrading.
- Full state dump to files
- Prepares for complete clear
- Detailed continuation notes

### End Handoff
Finishing work session.
- Logs session metrics
- Updates usage tracking
- Prepares for next session

### Human Handoff
Needs human intervention.
- Documents blockers
- Lists questions/decisions needed
- Provides context for human

## Handoff Process

### 1. State Verification
```
□ task-queue.md is current
□ in-progress.md reflects actual state
□ completed.md has all finished work
□ blocked.md lists any blockers
□ decisions.md has new decisions
```

### 2. Create Handoff File
Writes to `.claude/state/handoff.md`:

```markdown
# Session Handoff

## Metadata
- Type: soft|hard|end|human
- Timestamp: 2025-01-06T14:32:00Z
- Session Duration: 3h 45m
- Context at Handoff: 62%

## Current State

### In Progress
TASK-012: Implement rate monitoring skill
- Status: 70% complete
- Files modified: .claude/skills/rate-monitor/SKILL.md
- Remaining: Add integration section, output formats

### Just Completed
- TASK-010: Create quality-gate skill
- TASK-011: Create pre-commit hook

### Blocked
None

## Key Context

### Recent Decisions
- ADR-006: Using markdown for skill docs (not JSON)
- ADR-007: Hooks return JSON for structured responses

### Important Files
- `.claude/skills/rate-monitor/SKILL.md` - partially written
- `.claude/hooks/pre-commit.sh` - complete, needs testing

### Gotchas
- pre-commit hook expects npm scripts, adjust for Python projects
- rate-monitor skill assumes Max 20x plan

## Continuation Notes

### Immediate Next Steps
1. Complete rate-monitor skill (add output formats section)
2. Test pre-commit hook with failing tests
3. Pick up TASK-013 (loop command)

### Things to Remember
- Weekly Opus budget: 27.5 hrs remaining
- Project uses TypeScript (not JavaScript)
- Tests use Vitest, not Jest

### Warnings
- Don't refactor hooks until all are tested
- Keep skills under 300 lines each

## For Human (if human handoff)

### Questions Needing Answers
None currently

### Decisions Needed
None currently

### Blockers
None currently
```

### 3. Update State Files
Ensures all state files are current before transition.

### 4. Execute Transition

**Soft Handoff:**
```
/compact
```
Then continue working.

**Hard Handoff:**
```
/clear
```
Then resume by reading handoff.md.

**End Handoff:**
Log session, close.

**Human Handoff:**
Stop and wait for human.

## Output Format

### Soft Handoff Complete
```
📋 SOFT HANDOFF COMPLETE
────────────────────────────────────────────────────

State files updated:
  ✓ task-queue.md
  ✓ in-progress.md
  ✓ completed.md
  ✓ handoff.md

Context: 62% → Ready for /compact

Next: Run /compact to reduce context, then continue.
────────────────────────────────────────────────────
```

### Hard Handoff Complete
```
📋 HARD HANDOFF COMPLETE
────────────────────────────────────────────────────

State files updated:
  ✓ task-queue.md
  ✓ in-progress.md
  ✓ completed.md
  ✓ handoff.md
  ✓ decisions.md

Handoff file: .claude/state/handoff.md

Context: 73% → Ready for /clear

Next: Run /clear, then read handoff.md to resume.
────────────────────────────────────────────────────
```

### End Handoff Complete
```
📋 SESSION END HANDOFF
────────────────────────────────────────────────────

Session Summary:
  Duration:     3h 45m
  Tasks Done:   8
  Opus Used:    ~1.5 hrs
  Success Rate: 100%

State saved for next session.
Weekly Opus remaining: 26 hrs

Next session: Start with /status, then /loop
────────────────────────────────────────────────────
```

### Human Handoff Complete
```
📋 HUMAN HANDOFF
────────────────────────────────────────────────────

Attention needed on:

🚫 BLOCKED: TASK-015
   Question: Should /handoff support custom templates?
   Options:
     A) Yes, allow .claude/templates/handoff.md override
     B) No, keep standard format
   Impact: Affects implementation scope

Please update blocked.md with decision, then run /loop.
────────────────────────────────────────────────────
```

## Recovery from Handoff

After /clear or new session:

```
1. Read CLAUDE.md (project context)
2. Read .claude/state/handoff.md (continuation notes)
3. Read .claude/state/task-queue.md (what's left)
4. Read .claude/state/in-progress.md (resume point)
5. Continue from where handoff occurred
```

## Best Practices

### Handoff Early
Don't wait until forced. Handoff at natural breakpoints:
- After completing a task
- Before starting complex work
- When context hits 55-60%

### Keep Handoff Lean
Include only what's needed to continue. Don't dump everything.

### Verify Before Clearing
Always check handoff.md was written before running /clear.

### Test Recovery
Occasionally do a hard handoff and recovery to verify it works.
