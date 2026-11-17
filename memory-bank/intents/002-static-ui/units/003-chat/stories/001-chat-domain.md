# Story 001-chat-domain — Chat models and fake AI repository

**Intent:** 002-static-ui  
**Unit:** 003-chat  
**Priority:** Must  
**Status:** Draft

## Acceptance Criteria
- `ChatMessage{id, role, text, createdAt, status}`
- `ChatRepository.sendMessage()` returns `Stream<String>` chunks
- `ChatRepository.loadHistory({int limit = 20, String? before})` returns a page (messages + hasMore) (D9)
-  `MockChatRepository` streams a canned Indonesian reply with delay and can be configured to fail
