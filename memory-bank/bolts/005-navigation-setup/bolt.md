---
id: 005-navigation-setup
unit: 005-navigation-setup
intent: 001-project-setup
type: simple-construction-bolt
status: planned
stories:
  - 001-shell
  - 002-routes
  - 003-shell-states
created: 2026-05-20T07:15:00Z
started: null
completed: null
current_stage: null
stages_completed: []
requires_bolts:
  - 001-flutter-project-init
enables_bolts: []
requires_units: []
blocks: false
complexity:
  avg_complexity: 1
  avg_uncertainty: 1
  max_dependencies: 2
  testing_scope: 2
---

# Bolt: 005-navigation-setup

## Overview
Implement bottom navigation shell and GetX route map.

## Objective
Establish app navigation structure matching `fAIth_web` Information Architecture.

## Stories Included
- **001-shell**: Navigation Shell (Must)
- **002-routes**: Routes + Guards (Must)
- **003-shell-states**: Shell State (Must)

## Bolt Type
**Type**: simple-construction-bolt
**Definition**: `.specsmd/aidlc/templates/construction/bolt-types/simple-construction-bolt.md`

## Stages
- [ ] **1. Plan**: Pending → `implementation-plan.md`
- [ ] **2. Implement**: Pending → nav code + `implementation-walkthrough.md`
- [ ] **3. Test**: Pending → nav/route validation + `test-walkthrough.md`

## Dependencies
### Requires
- `001-flutter-project-init`

### Enables
- None

## Success Criteria
- [ ] Bottom tabs exist: Home, Chat, Study, Devotional, Profile
- [ ] Switching tabs updates route/view correctly
- [ ] Guard mechanism prevents unauth access (hooked to Auth state)
