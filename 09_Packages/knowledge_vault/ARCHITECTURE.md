# knowledge_vault — Architecture

**ID:** PKG-002

## Structure

```
knowledge_vault/
├── lib/
│   ├── src/
│   │   ├── domain/
│   │   ├── data/
│   │   ├── application/
│   │   └── presentation/
│   └── knowledge_vault.dart
├── test/
└── pubspec.yaml
```

## Design Principles

1. Single responsibility per class
2. All dependencies injectable via Riverpod
3. Offline-first — no required network
4. Vegetarian policy enforced at this layer
