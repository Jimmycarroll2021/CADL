# CADL: Continuous Autonomous Development Loop

A framework for 8+ hour autonomous Claude Code operation.

## Status

| Phase | Status |
|-------|--------|
| Week 1: Foundation | ✅ Complete |
| Week 2: Testing | 🔄 In Progress |
| Week 3: Hooks & Skills | ⏳ Planned |
| Week 4: Loop Mechanics | ⏳ Planned |
| Week 5: Optimisation | ⏳ Planned |
| Week 6: Documentation | ⏳ Planned |

## What This Is

CADL enables Claude Code to work continuously on complex projects without losing context or requiring constant human intervention. It achieves this through:

- **External state files** that survive context rotations
- **Specialist agents** for different work types
- **Hooks** that enable loop continuation and quality gates
- **Skills** for context management and task decomposition

## Quick Start

```bash
# Clone this repo
git clone https://github.com/Jimmycarroll2021/CADL.git
cd CADL

# Make hooks executable
chmod +x .claude/hooks/*.sh

# Start Claude Code
claude

# Check status
/status

# Begin autonomous loop
/loop
```

## Directory Structure

```
CADL/
├── CLAUDE.md              # Main config CC reads
├── README.md              # This file
├── TESTING.md             # Test guide
├── TROUBLESHOOTING.md     # Common issues
├── scripts/
│   └── test-hooks.sh      # Automated hook tests
└── .claude/
    ├── settings.json      # CC hook configuration
    ├── state/             # Coordination state
    │   ├── task-queue.md
    │   ├── in-progress.md
    │   ├── completed.md
    │   ├── decisions.md
    │   ├── blocked.md
    │   └── usage-log.md
    ├── agents/            # Specialist definitions
    │   ├── orchestrator.md
    │   ├── explorer.md
    │   ├── implementer.md
    │   ├── tester.md
    │   ├── reviewer.md
    │   └── debugger.md
    ├── skills/            # On-demand capabilities
    │   ├── context-rotate/
    │   ├── task-decompose/
    │   ├── quality-gate/
    │   └── rate-monitor/
    ├── hooks/             # CC hook scripts
    │   ├── loop-control.sh
    │   └── pre-commit.sh
    └── commands/          # Slash commands
        ├── loop.md
        ├── status.md
        └── handoff.md
```

## How It Works

1. **Orchestrator** reads task-queue.md, picks highest priority task
2. **Dispatches** to specialist agent (explorer, implementer, tester, etc.)
3. **Specialist** completes work, updates state files
4. **Stop hook** checks if more work exists, continues if yes
5. **Context rotation** triggers at 60% usage to preserve quality

## Commands

| Command | Purpose |
|---------|---------|
| `/loop` | Start autonomous development loop |
| `/status` | Show current state and progress |
| `/handoff` | Prepare state for context rotation |

## Model Usage (Max 20x)

Optimised for Anthropic Max subscription:

| Agent | Model | Reason |
|-------|-------|--------|
| Orchestrator | Sonnet | Coordination doesn't need Opus |
| Explorer | Sonnet | Read-only search |
| Implementer | Opus | Complex reasoning |
| Tester | Sonnet | Procedural work |
| Reviewer | Opus | Quality judgement |
| Debugger | Opus | Diagnosis |

Expected: ~5 Opus hours per 8-hour session.

## Testing

```bash
# Run automated tests
./scripts/test-hooks.sh

# Manual validation
# See TESTING.md for full guide
```

## Troubleshooting

Common issues and solutions in [TROUBLESHOOTING.md](TROUBLESHOOTING.md).

## Architecture Decisions

Key decisions documented in `.claude/state/decisions.md`:

- **ADR-001**: State in files, not context
- **ADR-002**: Agent specialisation pattern
- **ADR-003**: Opus budget preservation
- **ADR-004**: Context rotation at 60%
- **ADR-005**: Hook-based loop control

## Contributing

1. Fork the repo
2. Create feature branch
3. Make changes
4. Run tests: `./scripts/test-hooks.sh`
5. Submit PR

## License

MIT

## Acknowledgements

Built on research from:
- [awesome-claude-code](https://github.com/hesreallyhim/awesome-claude-code)
- [claude-code-hooks-mastery](https://github.com/disler/claude-code-hooks-mastery)
- [VoltAgent subagents](https://github.com/VoltAgent/awesome-claude-code-subagents)
- Claude Code official documentation
