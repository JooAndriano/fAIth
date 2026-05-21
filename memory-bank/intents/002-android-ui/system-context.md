# System Context — Intent 002: Android UI Parity (Web → Mobile)

**Intent:** 002-android-ui
**Status:** Draft
**Created:** 2026-05-21T00:00:00Z

## System Under Design
**fAIth Mobile App UI layer** (`fAIth_mobile/`) — Flutter + GetX presentation layer updated for UI parity with web reference.

## Actors
- **End User**: Uses mobile app.
- **Developer/Designer**: Uses web UI (`fAIth_web/`) as reference-of-truth.

## External Systems
- **fAIth Web (reference only)**: `fAIth_web/` source code provides layout/components/tokens to mirror.
- **Firebase**: Existing backend; not primary scope in this intent.

## Data / Control Flows (UI-centric)
- Web UI patterns → translated into Flutter widgets/theme tokens.
- GetX controllers/state → feed UI (no behavioral changes required).

## Context Notes
- Primary risk: overusing blur/gradients → performance. Use light blur or gradient-only fallback on low-end devices.
