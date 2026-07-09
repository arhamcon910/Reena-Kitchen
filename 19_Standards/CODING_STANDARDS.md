# Coding Standards

**ID:** STD-CODE-001 | **v2.0** | **2026-07-06**

## Core Rules

1. Every SP key: `reena.[domain].v1` format
2. Every provider overridable via `ProviderScope.overrides`
3. API key: `String.fromEnvironment("ANTHROPIC_API_KEY")` only
4. Vegetarian invariants: never configurable, never loosened
5. `Image.network()`: 0 occurrences permitted

## File Naming

```
snake_case.dart           # all Dart files
feature_screen.dart       # screens
feature_provider.dart     # Riverpod providers
feature_service.dart      # services
feature_repository.dart   # data repositories
```

## Import Order

```dart
// 1. Dart SDK
import "dart:async";
// 2. Flutter
import "package:flutter/material.dart";
// 3. Third-party
import "package:flutter_riverpod/flutter_riverpod.dart";
// 4. Internal packages
import "package:decision_engine/decision_engine.dart";
// 5. Relative
import "../widgets/card.dart";
```

## Error Handling

```dart
// Production: silent catch + ErrorStore
try {
  final data = await prefs.getString(key);
} catch (e, stack) {
  crashReporter.recordError(e, stack);
  return null;  // graceful degradation
}
```
