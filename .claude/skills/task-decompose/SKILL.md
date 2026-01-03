# Task Decomposition Skill

Breaks large tasks into atomic units that fit within context and time constraints.

## When to Load
- Task estimate exceeds 30 minutes
- Task scope is unclear
- Task has multiple deliverables
- Task requires multiple agents

## Decomposition Principles

### Atomic Tasks
Each task should be:
- **Independent**: Can be completed without other pending tasks
- **Completeable**: Can finish in one session (<30 mins)
- **Testable**: Has clear success criteria
- **Assignable**: Maps to one agent type

### Size Guidelines

| Task Type | Target Duration | Max Lines Changed |
|-----------|-----------------|-------------------|
| Exploration | 10-20 mins | 0 (read-only) |
| Small implementation | 15-30 mins | <100 lines |
| Medium implementation | 30-45 mins | 100-300 lines |
| Large implementation | Split required | >300 lines |
| Testing | 15-30 mins | <200 lines tests |
| Review | 10-20 mins | N/A |

## Decomposition Process

### 1. Analyse the Task
```
Original: "Build user authentication system"

Components identified:
- Database schema for users
- Password hashing utility
- Login endpoint
- Registration endpoint
- Session management
- Auth middleware
- Tests for each component
```

### 2. Identify Dependencies
```
Dependency graph:
1. Database schema (no deps)
2. Password hashing (no deps)
3. Registration endpoint (needs 1, 2)
4. Login endpoint (needs 1, 2)
5. Session management (needs 1)
6. Auth middleware (needs 5)
7. Tests (needs all above)
```

### 3. Create Atomic Tasks
```markdown
- [ ] TASK-101: Create users table schema
  - Status: ready
  - Est: 15 mins
  - Agent: implementer
  - Dependencies: none

- [ ] TASK-102: Implement password hashing utility
  - Status: ready
  - Est: 20 mins
  - Agent: implementer
  - Dependencies: none

- [ ] TASK-103: Build registration endpoint
  - Status: blocked
  - Est: 25 mins
  - Agent: implementer
  - Dependencies: TASK-101, TASK-102

- [ ] TASK-104: Build login endpoint
  - Status: blocked
  - Est: 25 mins
  - Agent: implementer
  - Dependencies: TASK-101, TASK-102

- [ ] TASK-105: Implement session management
  - Status: blocked
  - Est: 20 mins
  - Agent: implementer
  - Dependencies: TASK-101

- [ ] TASK-106: Create auth middleware
  - Status: blocked
  - Est: 20 mins
  - Agent: implementer
  - Dependencies: TASK-105

- [ ] TASK-107: Write auth system tests
  - Status: blocked
  - Est: 30 mins
  - Agent: tester
  - Dependencies: TASK-103 through TASK-106
```

### 4. Set Status Based on Dependencies
- `ready`: All dependencies complete
- `blocked`: Waiting on other tasks
- `in-progress`: Currently being worked

## Task Template

```markdown
- [ ] TASK-XXX: [Clear, action-oriented title]
  - Status: ready|blocked|in-progress
  - Est: [minutes]
  - Agent: explorer|implementer|tester|reviewer|debugger
  - Files: [expected output files]
  - Dependencies: [TASK-XXX, TASK-YYY] or none
  - Notes: [context, constraints, gotchas]
```

## Splitting Strategies

### By Component
Split a feature into its constituent parts.
```
Feature → Component A, Component B, Component C
```

### By Layer
Split across architectural layers.
```
Feature → Database, API, Business Logic, UI
```

### By Operation
Split CRUD operations separately.
```
Feature → Create, Read, Update, Delete
```

### By User Flow
Split along user journey steps.
```
Feature → Step 1, Step 2, Step 3
```

### By Risk
Isolate risky/uncertain parts.
```
Feature → Known parts, Experimental parts
```

## Verification

After decomposition, verify:
- [ ] No task exceeds 30 mins estimate
- [ ] Each task has clear deliverable
- [ ] Dependencies form valid DAG (no cycles)
- [ ] At least one task is ready (no deadlock)
- [ ] Tasks map to appropriate agents
- [ ] Sum of estimates reasonable for original scope

## Common Patterns

### API Endpoint
```
1. Define request/response types
2. Implement handler logic
3. Add route registration
4. Write tests
5. Add documentation
```

### Database Feature
```
1. Create migration
2. Define model/entity
3. Implement repository methods
4. Write tests
```

### UI Component
```
1. Create component structure
2. Implement styling
3. Add interactivity
4. Connect to state/API
5. Write tests
```

## Output Format

After decomposition, update task-queue.md with new tasks and respond:

```
## Decomposition Complete

### Original Task
TASK-XXX: [description]

### Subtasks Created
- TASK-XXX-1: [title] (ready)
- TASK-XXX-2: [title] (ready)
- TASK-XXX-3: [title] (blocked on XXX-1)
- TASK-XXX-4: [title] (blocked on XXX-2, XXX-3)

### Dependency Graph
XXX-1 ──┬──→ XXX-3 ──┐
        │            ├──→ XXX-4
XXX-2 ──┴────────────┘

### Estimated Total
[sum of estimates] minutes

### Ready to Start
TASK-XXX-1, TASK-XXX-2 can begin immediately
```
