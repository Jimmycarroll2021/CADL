# Quality Gate Skill

Evaluates work quality before allowing progression to next stage.

## When to Load
- Before committing code
- Before marking task complete
- Before proceeding to dependent tasks
- When reviewer requests validation

## Gate Stages

### Stage 1: Compilation/Parse
Verify code is syntactically valid.

```bash
# TypeScript
npx tsc --noEmit

# Python
python -m py_compile file.py

# JavaScript
node --check file.js
```

**Pass criteria**: Zero syntax errors
**Fail action**: Return to implementer

### Stage 2: Lint
Verify code follows style rules.

```bash
# ESLint
npm run lint

# Python
ruff check .
# or
flake8 .

# Prettier
npx prettier --check .
```

**Pass criteria**: Zero lint errors (warnings acceptable)
**Fail action**: Return to implementer for fixes

### Stage 3: Tests
Verify functionality works correctly.

```bash
# Jest/Vitest
npm test

# Pytest
python -m pytest

# With coverage
npm run test:coverage
python -m pytest --cov
```

**Pass criteria**: All tests pass, coverage meets threshold
**Fail action**: Return to implementer or debugger

### Stage 4: Type Check (if applicable)
Verify type safety.

```bash
# TypeScript
npx tsc --noEmit

# Python (mypy)
mypy .
```

**Pass criteria**: Zero type errors
**Fail action**: Return to implementer

### Stage 5: Review
Human or reviewer agent assessment.

**Pass criteria**: Approved by reviewer
**Fail action**: Address feedback, re-submit

## Gate Configuration

Create `.claude/quality-gate.json` to configure:

```json
{
  "stages": {
    "compile": {
      "enabled": true,
      "command": "npx tsc --noEmit",
      "required": true
    },
    "lint": {
      "enabled": true,
      "command": "npm run lint",
      "required": true
    },
    "test": {
      "enabled": true,
      "command": "npm test",
      "required": true,
      "coverage_threshold": 70
    },
    "typecheck": {
      "enabled": true,
      "command": "npx tsc --noEmit",
      "required": true
    }
  },
  "skip_on": ["*.md", "*.json", "*.txt"]
}
```

## Running Gates

### Full Gate Check
Run all enabled stages in order:

```bash
#!/bin/bash
# .claude/scripts/quality-gate.sh

set -e

echo "=== Stage 1: Compile ==="
npx tsc --noEmit
echo "✅ Compile passed"

echo "=== Stage 2: Lint ==="
npm run lint
echo "✅ Lint passed"

echo "=== Stage 3: Tests ==="
npm test
echo "✅ Tests passed"

echo "=== Stage 4: Type Check ==="
npx tsc --noEmit
echo "✅ Type check passed"

echo ""
echo "🎉 All quality gates passed"
```

### Quick Gate (pre-commit)
Faster check for commit blocking:

```bash
#!/bin/bash
# Compile + lint only
npx tsc --noEmit && npm run lint
```

### Full Gate (pre-merge)
Complete check including tests:

```bash
#!/bin/bash
# All stages
npm run lint && npm test && npx tsc --noEmit
```

## Gate Results Format

### Pass
```
## Quality Gate: ✅ PASSED

### Task
TASK-XXX: [description]

### Results
| Stage | Status | Duration |
|-------|--------|----------|
| Compile | ✅ Pass | 2.1s |
| Lint | ✅ Pass | 1.3s |
| Test | ✅ Pass | 4.5s |
| Types | ✅ Pass | 2.0s |

### Metrics
- Test coverage: 82%
- Lint warnings: 3
- Type coverage: 95%

### Ready For
- [ ] Review
- [ ] Merge
```

### Fail
```
## Quality Gate: ❌ FAILED

### Task
TASK-XXX: [description]

### Results
| Stage | Status | Duration |
|-------|--------|----------|
| Compile | ✅ Pass | 2.1s |
| Lint | ❌ Fail | 1.3s |
| Test | ⏸️ Skipped | - |
| Types | ⏸️ Skipped | - |

### Failures
**Lint (Stage 2)**
```
src/auth.ts:45:10 - error: 'user' is defined but never used
src/auth.ts:67:5 - error: Missing semicolon
```

### Action Required
Return to implementer to fix lint errors.
```

## Integration with Hooks

The pre-commit hook (`.claude/hooks/pre-commit.sh`) integrates quality gates:

```bash
#!/bin/bash
# Run quick gate before allowing commit

npm run lint --silent 2>&1
if [ $? -ne 0 ]; then
    echo '{"decision": "block", "reason": "Lint failed"}'
    exit 0
fi

npm test --silent 2>&1
if [ $? -ne 0 ]; then
    echo '{"decision": "block", "reason": "Tests failed"}'
    exit 0
fi

echo '{"decision": "approve"}'
```

## Bypassing Gates

Gates should rarely be bypassed. Valid reasons:
- Emergency hotfix (document in decisions.md)
- Test environment broken (not code issue)
- Explicit human override

To bypass (use sparingly):
```bash
git commit --no-verify -m "Emergency fix: [reason]"
```

Always document bypass in decisions.md:
```markdown
## Gate Bypass: [date]
- Task: TASK-XXX
- Reason: [why bypass was necessary]
- Risk: [what could go wrong]
- Follow-up: [how this will be addressed]
```

## Continuous Quality

### Per-Task Gates
Every task goes through gates before completion.

### Per-Session Gates
Run full gate check at end of each session.

### Pre-Merge Gates
Full gate check required before any merge.

### Scheduled Gates
Consider nightly full test runs for larger projects.
