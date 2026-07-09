# decision_engine — Architecture

**ID:** PKG-003

## Structure

```
decision_engine/
├── lib/
│   ├── src/
│   │   ├── domain/
│   │   ├── data/
│   │   ├── application/
│   │   └── presentation/
│   └── decision_engine.dart
├── test/
└── pubspec.yaml
```

## Design Principles

1. Single responsibility per class
2. All dependencies injectable via Riverpod
3. Offline-first — no required network
4. Vegetarian policy enforced at this layer
