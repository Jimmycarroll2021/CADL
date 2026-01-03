# Example: CLI/Automation Project Tasks

Copy these templates to your `.claude/state/task-queue.md` and customise.

## CLI Command

```markdown
- [ ] TASK-XXX: Implement [command] CLI command
  - Status: ready
  - Est: 30 mins
  - Agent: implementer
  - Files: src/commands/[command].ts, src/commands/index.ts
  - Dependencies: none
  - Notes:
    - Usage: `tool [command] [options]`
    - Options: --flag, --param <value>
    - Output: [expected output format]
```

## Configuration Parser

```markdown
- [ ] TASK-XXX: Add [format] config file support
  - Status: ready
  - Est: 25 mins
  - Agent: implementer
  - Files: src/config/[format]-parser.ts, src/config/index.ts
  - Dependencies: none
  - Notes: Support .toolrc, tool.config.js, tool.config.json
```

## Shell Script

```markdown
- [ ] TASK-XXX: Create [name] automation script
  - Status: ready
  - Est: 20 mins
  - Agent: implementer
  - Files: scripts/[name].sh
  - Dependencies: none
  - Notes:
    - Input: [what it takes]
    - Output: [what it produces]
    - Error handling: [requirements]
```

## Integration

```markdown
- [ ] TASK-XXX: Integrate with [service/tool]
  - Status: ready
  - Est: 45 mins
  - Agent: implementer
  - Files: src/integrations/[service].ts
  - Dependencies: none
  - Notes:
    - API endpoint: [url]
    - Auth: [method]
    - Rate limits: [if any]
```

## Output Formatter

```markdown
- [ ] TASK-XXX: Add [format] output formatter
  - Status: ready
  - Est: 20 mins
  - Agent: implementer
  - Files: src/formatters/[format].ts
  - Dependencies: none
  - Notes: Support JSON, table, plain text outputs
```

## Hook/Plugin

```markdown
- [ ] TASK-XXX: Create [name] hook
  - Status: ready
  - Est: 25 mins
  - Agent: implementer
  - Files: src/hooks/[name].ts
  - Dependencies: none
  - Notes:
    - Trigger: [when it runs]
    - Input: [what it receives]
    - Output: [what it returns]
```

## Performance Optimisation

```markdown
- [ ] TASK-XXX: Optimise [operation] performance
  - Status: ready
  - Est: 40 mins
  - Agent: implementer
  - Files: src/[module]/
  - Dependencies: none
  - Notes:
    - Current: [current performance]
    - Target: [target performance]
    - Approach: [optimisation strategy]
```

## Error Handling

```markdown
- [ ] TASK-XXX: Improve error handling in [module]
  - Status: ready
  - Est: 25 mins
  - Agent: implementer
  - Files: src/[module]/, src/errors/
  - Dependencies: none
  - Notes:
    - Add custom error classes
    - Improve error messages
    - Add recovery suggestions
```

## Logging

```markdown
- [ ] TASK-XXX: Add structured logging to [module]
  - Status: ready
  - Est: 20 mins
  - Agent: implementer
  - Files: src/[module]/, src/logger.ts
  - Dependencies: none
  - Notes:
    - Levels: debug, info, warn, error
    - Format: JSON for production, pretty for dev
    - Include context: timestamp, module, operation
```
