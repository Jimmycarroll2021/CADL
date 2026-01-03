#!/bin/bash
# CADL Installation Script
# Usage: curl -fsSL https://raw.githubusercontent.com/Jimmycarroll2021/CADL/main/install.sh | bash

set -e

REPO="https://github.com/Jimmycarroll2021/CADL.git"
DEFAULT_DIR="$HOME/cadl-project"

echo "═══════════════════════════════════════════════════"
echo "        CADL: Continuous Autonomous Development Loop"
echo "═══════════════════════════════════════════════════"
echo ""

# Parse arguments
INSTALL_DIR="${1:-$DEFAULT_DIR}"

echo "Installing CADL to: $INSTALL_DIR"
echo ""

# Check for git
if ! command -v git &> /dev/null; then
    echo "❌ Error: git is required but not installed."
    exit 1
fi

# Check for Claude Code
if ! command -v claude &> /dev/null; then
    echo "⚠️  Warning: Claude Code CLI not found."
    echo "   Install from: https://claude.ai/code"
    echo "   Continuing anyway..."
    echo ""
fi

# Clone or update
if [ -d "$INSTALL_DIR" ]; then
    echo "Directory exists. Updating..."
    cd "$INSTALL_DIR"
    git pull origin main
else
    echo "Cloning repository..."
    git clone "$REPO" "$INSTALL_DIR"
    cd "$INSTALL_DIR"
fi

# Make hooks executable
echo "Setting permissions..."
chmod +x .claude/hooks/*.sh 2>/dev/null || true
chmod +x scripts/*.sh 2>/dev/null || true

# Verify structure
echo ""
echo "Verifying installation..."

MISSING=0
for file in CLAUDE.md .claude/settings.json .claude/hooks/loop-control.sh; do
    if [ ! -f "$file" ]; then
        echo "❌ Missing: $file"
        MISSING=1
    fi
done

if [ $MISSING -eq 1 ]; then
    echo ""
    echo "❌ Installation incomplete. Some files are missing."
    exit 1
fi

echo "✅ All core files present"

# Run hook tests if available
if [ -f "scripts/test-hooks.sh" ]; then
    echo ""
    echo "Running hook tests..."
    ./scripts/test-hooks.sh || echo "⚠️  Some tests failed (may need jq installed)"
fi

echo ""
echo "═══════════════════════════════════════════════════"
echo "        Installation Complete!"
echo "═══════════════════════════════════════════════════"
echo ""
echo "Next steps:"
echo "  cd $INSTALL_DIR"
echo "  claude"
echo ""
echo "Then in Claude Code:"
echo "  /status    - Check current state"
echo "  /loop      - Start autonomous development"
echo ""
echo "Documentation:"
echo "  README.md          - Overview"
echo "  TESTING.md         - Test guide"
echo "  TROUBLESHOOTING.md - Common issues"
echo ""
