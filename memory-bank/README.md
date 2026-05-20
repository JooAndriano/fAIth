# Memory Bank

Central repository for AI-DLC Flow project context, planning, and execution artifacts.

## Directory Structure

```
memory-bank/
├── project.yaml              # Project metadata and configuration
├── story-index.md            # Master index of all stories
├── intents/                  # Feature/capability definitions
│   └── {NNN}-{intent-name}/
│       ├── inception-log.md
│       ├── units/
│       │   └── {UUU}-{unit-name}/
│       │       ├── construction-log.md
│       │       └── stories/
│       │           └── {SSS}-{story-title}.md
├── bolts/                    # Execution instances (Bolt sessions)
│   └── {BBB}-{unit-name}/
│       ├── bolt.md
│       ├── ddd-01-domain-model.md
│       ├── ddd-02-technical-design.md
│       └── ddd-03-test-report.md
├── standards/                # Project standards and decisions
│   └── decision-index.md
└── operations/               # Deployment and monitoring context
```

## Key Concepts

- **Intents**: Features or capabilities to be built
- **Units**: Decomposed work items within an intent
- **Stories**: User stories and acceptance criteria
- **Bolts**: Execution instances that implement units
- **Standards**: Architecture decisions and technical standards

## Naming Conventions

- **Intents**: `{NNN}-{intent-name}` (e.g., `001-user-authentication`)
- **Units**: `{UUU}-{unit-name}` (e.g., `001-auth-service`)
- **Stories**: `{SSS}-{story-title}.md` (e.g., `001-user-signup.md`)
- **Bolts**: `{BBB}-{unit-name}/` (e.g., `001-auth-service/`)

## Timestamps

All timestamps use ISO 8601 format with time and timezone:
- Format: `YYYY-MM-DDTHH:MM:SSZ`
- Example: `2026-05-20T06:58:40Z`

---

**Initialized:** 2026-05-20T06:58:40Z
