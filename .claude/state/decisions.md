# Architectural Decisions

## ADR-001: State in Files, Not Context
- Date: 2025-01-03
- Status: accepted
- Context: Claude Code context window fills in 30-60 mins, auto-compaction loses information
- Decision: All coordination state lives in .claude/state/ files, not conversation memory
- Consequences: Survives /clear, enables handoffs, requires file I/O overhead

## ADR-002: Agent Specialisation Pattern
- Date: 2025-01-03
- Status: accepted
- Context: Single agent doing everything leads to context bloat and role confusion
- Decision: Six specialist agents (orchestrator, explorer, implementer, tester, reviewer, debugger)
- Consequences: Clear separation of concerns, orchestrator overhead, explicit handoffs needed

## ADR-003: Opus Budget Preservation
- Date: 2025-01-03
- Status: accepted
- Context: Max 20x has 24-40 Opus hours/week, must last full week
- Decision: Use Sonnet for orchestration/exploration/testing, reserve Opus for implementation/review/debug
- Consequences: 8-hour session uses ~5 Opus hours, leaves buffer for rest of week

## ADR-004: Context Rotation at 60%
- Date: 2025-01-03
- Status: accepted
- Context: Context degradation accelerates past 70%, auto-compaction buggy
- Decision: Trigger rotation at 60% usage, soft (/compact) first, hard (/clear + handoff) if needed
- Consequences: More frequent rotations but higher quality output

## ADR-005: Hook-Based Loop Control
- Date: 2025-01-03
- Status: accepted
- Context: CC has no native loop primitive, Stop hook can control continuation
- Decision: Use Stop hook to check task queue, return continue:true if work remains
- Consequences: Enables autonomous operation, requires robust error handling
