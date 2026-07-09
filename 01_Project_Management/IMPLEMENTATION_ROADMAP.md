# Implementation Roadmap

**ID:** PM-IMPL-001 | **v2.0** | **2026-07-06**

## Phase 1 Architecture (Frozen)

| Layer | Technology | Status |
|---|---|---|
| UI | Flutter 3.x + Riverpod | ✅ Frozen |
| Decision Engine | Pure Dart, 7 sub-engines | ✅ Frozen |
| AI | Anthropic via ai_sdk | ✅ Frozen |
| Persistence | SharedPreferences + versioned keys | ✅ Frozen |
| Crash | LoggingCrashReporter → ErrorStore | ✅ Frozen |
| Privacy | UserDataService (export/delete) | ✅ Frozen |

## Phase 2 Implementation Order

```
1. Sentry DSN → activate SentryCrashReporter (1h)
2. "Manage my data" Settings screen (1d)
3. Dinner vault +8 recipes (2d)
4. Supabase project setup (1d)
5. auth-service + household-service (1w)
6. Client SP → server sync (1w)
7. Shopping + finance modules (2w)
8. App Store submission (1d)
```
