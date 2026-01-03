# Contributing to CADL

Thanks for your interest in improving CADL.

## Quick Start

```bash
# Fork and clone
git clone https://github.com/YOUR_USERNAME/CADL.git
cd CADL

# Make hooks executable
chmod +x .claude/hooks/*.sh scripts/*.sh

# Run tests
./scripts/test-hooks.sh
```

## Development Workflow

### 1. Create a Branch
```bash
git checkout -b feature/your-feature-name
```

### 2. Make Changes
Follow existing patterns:
- Agents go in `.claude/agents/`
- Skills go in `.claude/skills/[skill-name]/SKILL.md`
- Commands go in `.claude/commands/`
- Hooks go in `.claude/hooks/`

### 3. Test Locally
```bash
# Automated tests
./scripts/test-hooks.sh

# Manual testing in Claude Code
claude
/status
```

### 4. Update Documentation
- Update README.md if adding features
- Add to TESTING.md if adding testable components
- Document in TROUBLESHOOTING.md if relevant

### 5. Submit PR
```bash
git add .
git commit -m "feat: description of change"
git push origin feature/your-feature-name
```

Then open a PR on GitHub.

## Code Standards

### Shell Scripts
- Use `#!/bin/bash` shebang
- Return valid JSON for hooks
- Handle errors gracefully
- Test with shellcheck: `shellcheck script.sh`

### Markdown Files
- Use consistent heading levels
- Include code examples where helpful
- Keep lines under 100 characters

### State Files
- Follow existing format in `.claude/state/`
- Use consistent task ID format: `TASK-XXX`
- Include all required fields

## Adding New Components

### New Agent
1. Create `.claude/agents/[name].md`
2. Follow template from existing agents
3. Specify model (Sonnet/Opus)
4. Define responsibilities and constraints
5. Add to orchestrator dispatch table

### New Skill
1. Create `.claude/skills/[name]/SKILL.md`
2. Document when to load
3. Provide clear procedures
4. Include examples

### New Command
1. Create `.claude/commands/[name].md`
2. Document usage and options
3. Describe expected behaviour
4. Include examples

### New Hook
1. Create `.claude/hooks/[name].sh`
2. Make executable
3. Return valid JSON
4. Add to `.claude/settings.json`
5. Add test to `scripts/test-hooks.sh`

## Testing Requirements

All PRs should:
- [ ] Pass `./scripts/test-hooks.sh`
- [ ] Pass GitHub Actions CI
- [ ] Include manual testing notes if applicable
- [ ] Not break existing functionality

## Commit Messages

Use conventional commits:
- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation only
- `refactor:` Code change that neither fixes nor adds
- `test:` Adding tests
- `chore:` Maintenance

Examples:
```
feat: add rate-limit recovery skill
fix: loop-control hook handles empty queue
docs: add troubleshooting section for context overflow
```

## Questions?

Open an issue for:
- Bug reports
- Feature requests
- Questions about implementation

Include:
- What you're trying to do
- What you expected
- What actually happened
- Relevant logs or error messages
