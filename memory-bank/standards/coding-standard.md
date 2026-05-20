# Dart/Flutter Coding Standard

## File/Folder Structure
- `lib/` follows feature-first, not layer-first
- One widget per file (if >30 lines)
- Use `snake_case` for files, `PascalCase` for classes

## Formatting
- Use `dart format .` before PR/commit
- Indent: 2 spaces
- Max line length: 100
- Setelah membuat/memodifikasi code tampilan atau function, lakukan hot reload untuk memastikan code tidak crash/error

## Naming
- Widgets: `PascalCase`
- Variables: `camelCase`
- Constants: `ALL_CAPS`

## Comments
- Use DartDoc (`///`) for public APIs
- Write why, not just what

## Testing
- Place all test files in `test/`
- Name: `{target}_test.dart`

## Version Control
- Commit secara atomic: satu perubahan logis per commit, pesan jelas dan terfokus.

---

**Status:** Accepted
**Date:** 2026-05-20
