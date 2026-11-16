# Story 003-view-state — ViewState and state widgets

**Intent:** 002-static-ui  
**Unit:** 001-ui-foundation  
**Priority:** Must  
**Status:** Draft

## Acceptance Criteria
- `ViewState<T>` sealed type: loading, empty, error(message), data(T)
- EmptyState, LoadingState, ErrorState(onRetry) widgets
- A `ViewStateBuilder` maps state to widgets
