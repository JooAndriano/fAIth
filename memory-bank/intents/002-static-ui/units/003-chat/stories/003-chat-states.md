# Story 003-chat-states — Typing effect and error handling

**Intent:** 002-static-ui  
**Unit:** 003-chat  
**Priority:** Must  
**Status:** Draft

## Acceptance Criteria
- Typing indicator before first chunk, then text appears progressively
- Error bubble with "Coba lagi" retries the last message
- Leaving and returning to the tab keeps the conversation (controller kept alive)
