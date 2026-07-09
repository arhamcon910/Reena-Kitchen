# System Architecture

**ID:** ARCH-SYS-001 | **v2.0** | **2026-07-06**

## Layered Architecture

```
┌──────────────────────────────────────────────────────────┐
│                    Flutter App (lib/)                      │
│  ┌──────────────────────────────────────────────────────┐ │
│  │              Feature Layer (screens)                  │ │
│  │  Home │ Onboarding │ Journey │ Talk │ Planner        │ │
│  │  Pantry │ Discover │ BetaOps                         │ │
│  └──────────────────────────────────────────────────────┘ │
│  ┌──────────────────────────────────────────────────────┐ │
│  │          Application Layer (Riverpod providers)       │ │
│  │  Brain │ Learning │ Analytics │ Error │ Privacy      │ │
│  └──────────────────────────────────────────────────────┘ │
│  ┌───────────────┐ ┌─────────────────┐ ┌──────────────┐ │
│  │ decision_engine│ │     ai_sdk       │ │knowledge_vault│ │
│  │ 7 sub-engines  │ │ Anthropic+Mock   │ │ 48 veg recipes│ │
│  │ 847 tests      │ │ retry+cache+filt │ │ festival data │ │
│  └───────────────┘ └─────────────────┘ └──────────────┘ │
│  ┌──────────────────────────────────────────────────────┐ │
│  │               Data Layer                              │ │
│  │  SharedPreferences │ SpMigrationService              │ │
│  │  UserDataService   │ reena.*.v1 keys                 │ │
│  └──────────────────────────────────────────────────────┘ │
└──────────────────────────────────────────────────────────┘
                          │ (Phase 2)
┌──────────────────────────────────────────────────────────┐
│              REENA Backend (NestJS Microservices)         │
│  gateway │ auth │ household │ pantry │ recipe │ shopping  │
│  finance │ workflow │ notification │ file │ ai-runtime    │
│                    Supabase PostgreSQL + Redis            │
└──────────────────────────────────────────────────────────┘
```

## Startup Sequence

```dart
main() async {
  WidgetsFlutterBinding.ensureInitialized();         // Flutter
  FlutterError.onError = reporter.recordFlutterError; // Error hooks
  PlatformDispatcher.instance.onError = ...;
  final prefs = await SharedPreferences.getInstance(); // 1 await
  await SpMigrationService.initialise(prefs);          // 1 await
  runApp(ProviderScope(overrides: [...], child: ReenaApp()));
}
// Total: 2 awaits, 1.12ms to first recommendation
```

## Key Architectural Decisions

| ADR | Decision |
|---|---|
| ADR-001 | Vegetarian: 9-layer permanent invariant |
| ADR-002 | SharedPreferences for Phase 1 |
| ADR-003 | Confidence formula: gapWeight×0.60 + rankWeight×0.40 |
| ADR-004 | Anthropic + MockAiEngine offline fallback |
| ADR-007 | API key via --dart-define only |
| ADR-008 | SP migration: write-before-remove |
