# REENA Flutter App

**Version:** 1.0.0-rc.1+100 | **Platform:** iOS 15+ · Android API 31+

## App Structure

```
lib/
├── main.dart                    2 awaits → 1.12ms startup
├── core/
│   ├── analytics/               29 events, 0 untracked
│   ├── ai/                      InstrumentedAiProvider
│   ├── brain/                   ReenaBrainProvider (try/catch)
│   ├── error/                   LoggingCrashReporter + SentryCR stub
│   ├── learning/                LearningProfileProvider (Riverpod)
│   ├── performance/             PerformanceMonitor (AI metrics)
│   ├── persistence/             SpMigrationService
│   └── privacy/                 UserDataService + provider
└── features/
    ├── home/                    AdaptiveHomeScreen + hero card
    ├── onboarding/              9-step flow + SP repository
    ├── pantry/                  Ingredient management
    ├── cooking_journey/         Start → complete → rate
    ├── talk_to_reena/           AnthropicChatService + 10-turn SP
    ├── planner/                 AI weekly plan (988L)
    ├── discover/                48 vault recipes
    └── beta/                    BetaOperationsScreen (10 panels)
```

## Running

```bash
flutter run --dart-define=ANTHROPIC_API_KEY=sk-ant-your-key
```

## Building for Distribution

```bash
# iOS
flutter build ipa --release --dart-define=ANTHROPIC_API_KEY=$KEY

# Android
flutter build appbundle --release --dart-define=ANTHROPIC_API_KEY=$KEY
```
