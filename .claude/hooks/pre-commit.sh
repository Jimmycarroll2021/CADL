#!/bin/bash
# Pre-commit Quality Gate Hook
# Called by Claude Code PreToolUse hook before git commit

# Read the tool input from stdin
read -r INPUT

# Check if tests exist and run them
if [ -f "package.json" ] && grep -q '"test"' package.json; then
    npm test --silent 2>&1
    TEST_RESULT=$?
elif [ -f "pytest.ini" ] || [ -d "tests" ]; then
    python -m pytest --quiet 2>&1
    TEST_RESULT=$?
else
    # No tests configured, allow commit
    TEST_RESULT=0
fi

if [ $TEST_RESULT -ne 0 ]; then
    echo '{"decision": "block", "reason": "Tests failed. Fix failing tests before committing."}'
    exit 0
fi

# Check for lint if configured
if [ -f "package.json" ] && grep -q '"lint"' package.json; then
    npm run lint --silent 2>&1
    LINT_RESULT=$?
    if [ $LINT_RESULT -ne 0 ]; then
        echo '{"decision": "block", "reason": "Linting failed. Fix lint errors before committing."}'
        exit 0
    fi
fi

# All checks passed
echo '{"decision": "approve"}'
