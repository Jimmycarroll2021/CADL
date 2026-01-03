# Changelog

All notable changes to CADL.

## [0.1.0] - 2025-01-03

### Added
- Initial release of CADL framework
- **Agents**: orchestrator, explorer, implementer, tester, reviewer, debugger
- **Skills**: context-rotate, task-decompose, quality-gate, rate-monitor
- **Commands**: /loop, /status, /handoff
- **Hooks**: loop-control (Stop hook), pre-commit (PreToolUse hook)
- **State files**: task-queue, in-progress, completed, blocked, decisions, usage-log
- **Documentation**: README, TESTING, TROUBLESHOOTING, CONTRIBUTING
- **CI**: GitHub Actions workflow for automated testing
- **Installation**: install.sh script for quick setup

### Architecture Decisions
- ADR-001: State in files, not context
- ADR-002: Agent specialisation pattern
- ADR-003: Opus budget preservation
- ADR-004: Context rotation at 60%
- ADR-005: Hook-based loop control

### Optimised For
- Anthropic Max 20x subscription
- 8+ hour autonomous sessions
- ~5 Opus hours per session

---

## Roadmap

### [0.2.0] - Planned
- Validated loop mechanics
- Recovery testing complete
- Performance benchmarks

### [0.3.0] - Planned
- Cross-project skill sharing
- Advanced model routing
- Parallel agent execution

### [1.0.0] - Planned
- Production-ready release
- Comprehensive test coverage
- Community contributions integrated
