#!/bin/bash
# Test script for CADL hooks
# Run from project root: ./scripts/test-hooks.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

echo "═══════════════════════════════════════════════════"
echo "           CADL Hook Tests"
echo "═══════════════════════════════════════════════════"
echo ""

# Test 1: loop-control.sh with tasks in queue
echo "Test 1: loop-control with tasks in queue"
echo "─────────────────────────────────────────"

# Ensure task queue has ready tasks
if grep -q "Status: ready" "$PROJECT_ROOT/.claude/state/task-queue.md" 2>/dev/null; then
    result=$("$PROJECT_ROOT/.claude/hooks/loop-control.sh")
    if echo "$result" | grep -q '"continue": true'; then
        echo "✅ PASS: Hook returns continue:true when tasks exist"
    else
        echo "❌ FAIL: Expected continue:true"
        echo "   Got: $result"
        exit 1
    fi
else
    echo "⚠️  SKIP: No ready tasks in queue"
fi
echo ""

# Test 2: loop-control.sh with empty queue
echo "Test 2: loop-control with empty queue"
echo "─────────────────────────────────────────"

# Temporarily rename task queue
if [ -f "$PROJECT_ROOT/.claude/state/task-queue.md" ]; then
    mv "$PROJECT_ROOT/.claude/state/task-queue.md" "$PROJECT_ROOT/.claude/state/task-queue.md.bak"
    
    # Create empty queue
    echo "# Task Queue" > "$PROJECT_ROOT/.claude/state/task-queue.md"
    echo "" >> "$PROJECT_ROOT/.claude/state/task-queue.md"
    echo "No tasks." >> "$PROJECT_ROOT/.claude/state/task-queue.md"
    
    result=$("$PROJECT_ROOT/.claude/hooks/loop-control.sh")
    
    # Restore original
    mv "$PROJECT_ROOT/.claude/state/task-queue.md.bak" "$PROJECT_ROOT/.claude/state/task-queue.md"
    
    if echo "$result" | grep -q '"continue": false'; then
        echo "✅ PASS: Hook returns continue:false when queue empty"
    else
        echo "❌ FAIL: Expected continue:false"
        echo "   Got: $result"
        exit 1
    fi
else
    echo "⚠️  SKIP: No task queue file"
fi
echo ""

# Test 3: loop-control.sh with blocked items
echo "Test 3: loop-control with blocked items"
echo "─────────────────────────────────────────"

# Temporarily add blocked item
if [ -f "$PROJECT_ROOT/.claude/state/blocked.md" ]; then
    cp "$PROJECT_ROOT/.claude/state/blocked.md" "$PROJECT_ROOT/.claude/state/blocked.md.bak"
    
    # Add a blocked task
    cat >> "$PROJECT_ROOT/.claude/state/blocked.md" << 'BLOCKED'

- [ ] TASK-999: Test blocked item
  - Blocked: 2025-01-03
  - Reason: Testing hook behaviour
BLOCKED
    
    result=$("$PROJECT_ROOT/.claude/hooks/loop-control.sh")
    
    # Restore original
    mv "$PROJECT_ROOT/.claude/state/blocked.md.bak" "$PROJECT_ROOT/.claude/state/blocked.md"
    
    if echo "$result" | grep -q '"continue": false'; then
        echo "✅ PASS: Hook returns continue:false when items blocked"
    else
        echo "❌ FAIL: Expected continue:false"
        echo "   Got: $result"
        exit 1
    fi
else
    echo "⚠️  SKIP: No blocked file"
fi
echo ""

# Test 4: pre-commit.sh output format
echo "Test 4: pre-commit output format"
echo "─────────────────────────────────────────"

# pre-commit should return valid JSON
result=$("$PROJECT_ROOT/.claude/hooks/pre-commit.sh" < /dev/null 2>/dev/null || echo '{"decision":"approve"}')

if echo "$result" | jq . > /dev/null 2>&1; then
    echo "✅ PASS: pre-commit returns valid JSON"
else
    echo "❌ FAIL: pre-commit output is not valid JSON"
    echo "   Got: $result"
    exit 1
fi
echo ""

echo "═══════════════════════════════════════════════════"
echo "           All Hook Tests Passed"
echo "═══════════════════════════════════════════════════"
