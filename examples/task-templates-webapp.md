# Example: Web Application Tasks

Copy these templates to your `.claude/state/task-queue.md` and customise.

## API Endpoint

```markdown
- [ ] TASK-XXX: Create [resource] API endpoint
  - Status: ready
  - Est: 30 mins
  - Agent: implementer
  - Files: src/api/[resource].ts, src/types/[resource].ts
  - Dependencies: none
  - Notes: 
    - GET /api/[resource] - list all
    - GET /api/[resource]/:id - get one
    - POST /api/[resource] - create
    - PUT /api/[resource]/:id - update
    - DELETE /api/[resource]/:id - delete
```

## Database Migration

```markdown
- [ ] TASK-XXX: Create [table] database migration
  - Status: ready
  - Est: 15 mins
  - Agent: implementer
  - Files: migrations/[timestamp]_create_[table].ts
  - Dependencies: none
  - Notes: Fields: id, name, created_at, updated_at
```

## React Component

```markdown
- [ ] TASK-XXX: Create [Component] React component
  - Status: ready
  - Est: 25 mins
  - Agent: implementer
  - Files: src/components/[Component]/index.tsx, src/components/[Component]/styles.ts
  - Dependencies: none
  - Notes: 
    - Props: [list props]
    - State: [list state]
    - Use existing design system
```

## Unit Tests

```markdown
- [ ] TASK-XXX: Write tests for [module]
  - Status: ready
  - Est: 20 mins
  - Agent: tester
  - Files: tests/[module].test.ts
  - Dependencies: TASK-YYY (module implementation)
  - Notes: Cover happy path, error cases, edge cases
```

## Code Review

```markdown
- [ ] TASK-XXX: Review [feature] implementation
  - Status: blocked
  - Est: 15 mins
  - Agent: reviewer
  - Dependencies: TASK-YYY (implementation), TASK-ZZZ (tests)
  - Notes: Check security, performance, code style
```

## Bug Fix

```markdown
- [ ] TASK-XXX: Fix [bug description]
  - Status: ready
  - Est: 30 mins
  - Agent: debugger
  - Files: [suspected files]
  - Dependencies: none
  - Notes: 
    - Reproduction: [steps]
    - Expected: [behaviour]
    - Actual: [behaviour]
```

## Documentation

```markdown
- [ ] TASK-XXX: Document [feature] API
  - Status: ready
  - Est: 20 mins
  - Agent: implementer
  - Files: docs/api/[feature].md
  - Dependencies: TASK-YYY (implementation)
  - Notes: Include examples, error codes, rate limits
```

## Refactoring

```markdown
- [ ] TASK-XXX: Refactor [module] for [reason]
  - Status: ready
  - Est: 45 mins
  - Agent: implementer
  - Files: src/[module]/
  - Dependencies: none
  - Notes: 
    - Keep external interface unchanged
    - Add tests for any new internal functions
    - Update related documentation
```
