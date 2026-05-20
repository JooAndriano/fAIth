# Tech Stack Standard

This document defines the core technology choices for the fAIth mobile application.

## Core Technologies

- **Language**: Dart
- **Framework**: Flutter
- **State Management**: GetX
- **Backend-as-a-Service**: Firebase
- **Functions**: Cloud Functions for Firebase (Node.js/TypeScript)
- **Database**: Cloud Firestore
- **Authentication**: Firebase Authentication (Google Sign-In)
- **AI Integration**: Google Gemini API via Firebase Functions

## Architectural Decisions

1. **AI Security**: The Flutter app will **not** directly call the Gemini API. All AI requests must route through Firebase Functions to ensure security, moderation, and usage tracking.
2. **State Management**: GetX is the chosen framework for state management and dependency injection.
3. **Data Sync**: Real-time data sync using Firestore listeners for chat history, prayer journal, and devotional content.

## Status: Accepted
**Date**: 2026-05-20
