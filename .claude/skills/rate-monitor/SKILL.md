# Rate Monitor Skill

Tracks model usage against Max subscription limits to ensure sustainable operation.

## When to Load
- At session start
- When planning work allocation
- Before Opus-heavy tasks
- When rate limited

## Max Subscription Limits

### Max 20x Plan (Weekly)
| Model | Hours/Week | Hours/Day (avg) |
|-------|------------|-----------------|
| Sonnet 4.5 | 240-480 | 48-96 |
| Opus 4.5 | 24-40 | 4.8-8 |

### Max 5x Plan (Weekly)
| Model | Hours/Week | Hours/Day (avg) |
|-------|------------|-----------------|
| Sonnet 4.5 | 60-120 | 12-24 |
| Opus 4.5 | 6-10 | 1.2-2 |

## Model Selection Strategy

### Use Sonnet For
- Orchestration (task routing, state management)
- Exploration (searching, reading files)
- Testing (running tests, writing test code)
- Documentation (writing docs, comments)
- Simple implementations (<50 lines)
- Repetitive tasks

### Use Opus For
- Complex implementation (architecture, algorithms)
- Code review (nuanced quality assessment)
- Debugging (root cause analysis)
- Architectural decisions
- Security-sensitive code
- Performance-critical code

## Usage Tracking

### Session Log
Create `.claude/state/usage-log.md`:

```markdown
# Usage Log

## Week of [date]

### Monday
| Session | Start | End | Opus (mins) | Sonnet (mins) | Tasks |
|---------|-------|-----|-------------|---------------|-------|
| 1 | 09:00 | 12:30 | 45 | 165 | 5 |
| 2 | 14:00 | 17:00 | 30 | 150 | 4 |
| **Total** | | | **75** | **315** | **9** |

### Running Weekly Total
- Opus: 75 mins (1.25 hrs) of ~32 hrs budget
- Sonnet: 315 mins (5.25 hrs) of ~360 hrs budget
```

### Task Tracking
In task-queue.md, track model per task:

```markdown
- [x] TASK-001: Create explorer agent
  - Model: sonnet
  - Actual: 18 mins
```

## Budget Management

### 8-Hour Session Budget (Max 20x)

Recommended allocation:
```
Planning:       1 hr  → Sonnet (0 Opus)
Exploration:    1 hr  → Sonnet (0 Opus)
Implementation: 4 hrs → Opus   (4 Opus hrs)
Testing:        1 hr  → Sonnet (0 Opus)
Review/Debug:   1 hr  → Opus   (1 Opus hr)
─────────────────────────────────────────
Total:          8 hrs → 5 Opus hours used
```

This leaves 19-35 Opus hours for rest of week.

### Weekly Planning

```markdown
## Week Budget (Max 20x)

### Opus Hours: ~32 available
| Day | Planned | Actual | Running |
|-----|---------|--------|---------|
| Mon | 5 | | |
| Tue | 5 | | |
| Wed | 5 | | |
| Thu | 5 | | |
| Fri | 5 | | |
| Sat | 4 | | |
| Sun | 3 | | |
| **Total** | **32** | | |

### Buffer
Keep 20% buffer (6-7 hrs) for:
- Unexpected debugging
- Complex issues
- End-of-week crunch
```

## Rate Limit Detection

### Signs of Rate Limiting
- Slower response times
- "Rate limit exceeded" errors
- Degraded output quality
- Model fallback notifications

### Response to Rate Limit

1. **Immediate**: Switch to Sonnet for current work
2. **Short-term**: Reduce Opus usage for rest of day
3. **Planning**: Rebalance week's remaining budget

### Recovery Protocol

```markdown
## Rate Limit Incident: [timestamp]

### Trigger
- Task: TASK-XXX
- Model: Opus
- Error: [rate limit message]

### Response
1. Switched to Sonnet
2. Deferred Opus tasks to tomorrow
3. Adjusted weekly budget

### Prevention
- Reduce daily Opus target by 30 mins
- Front-load Opus work earlier in week
```

## Opus Hour Preservation Tactics

### 1. Sonnet-First
Default to Sonnet, escalate to Opus only when needed.

### 2. Batch Opus Work
Group Opus tasks together to avoid context switching overhead.

### 3. Prepare Before Opus
Use Sonnet for research/exploration, then use Opus efficiently.

### 4. Opus Plan Mode
Use `claude --model opusplan` for automatic model switching.

### 5. Early-Week Loading
Use more Opus Mon-Wed, conserve Thu-Sun.

## Monitoring Commands

### Check Current Session
```bash
# Estimate based on conversation length
# (rough proxy - actual varies by task complexity)
wc -l .claude/state/in-progress.md
```

### Week Summary
```bash
# View usage log
cat .claude/state/usage-log.md
```

### Budget Check
Add to orchestrator startup:
```markdown
Before starting: Check .claude/state/usage-log.md
- If Opus budget < 2 hrs remaining: Use Sonnet for all tasks
- If Opus budget 2-5 hrs: Use Opus only for complex tasks
- If Opus budget > 5 hrs: Normal operation
```

## Output Format

### Status Report
```
## Rate Status

### Current Session
- Duration: 2h 15m
- Opus used: ~30 mins
- Sonnet used: ~105 mins

### Weekly Budget
- Opus: 3.5 hrs used / 32 hrs budget (11%)
- Days remaining: 5

### Recommendation
✅ On track. Continue normal operation.
```

### Warning Report
```
## Rate Warning

### Current Session
- Duration: 6h 30m
- Opus used: ~5.5 hrs
- Sonnet used: ~60 mins

### Weekly Budget
- Opus: 18 hrs used / 32 hrs budget (56%)
- Days remaining: 2

### Recommendation
⚠️ High Opus usage. Switch to Sonnet for remaining work.
Defer complex tasks to next week if possible.
```

## Integration

### Orchestrator Check
Before dispatching Opus tasks:
1. Read usage-log.md
2. Calculate remaining budget
3. If low: downgrade to Sonnet or defer
4. Log decision in decisions.md if deviating

### Session End
At end of each session:
1. Update usage-log.md with actual times
2. Review budget status
3. Adjust next session plan if needed
