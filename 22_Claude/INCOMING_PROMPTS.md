# Incoming Prompts Queue

| ID | Sprint | Task | Priority |
|---|---|---|---|
| P-S12-001 | S12 | Sentry activation (RC-084) | P0 |
| P-S12-002 | S12 | "Manage my data" UI (RC-085) | P0 |
| P-S12-003 | S12 | Dinner vault +8 recipes (RC-086) | P1 |

## P-S12-001: Sentry Activation

```
Task: Sentry Crash Reporting Activation
Goal: Activate SentryCrashReporter for REENA open beta.
Requirements:
- Add sentry_flutter: ^8.0.0 to pubspec.yaml
- Swap crashReporterProvider to SentryCrashReporter(dsn: ...)
- Un-comment all TODO(open-beta) Sentry.* calls in crash_reporter.dart
- Update CLAUDE_DELIVERY_REGISTER.md RC-084
Deliver:
1. Files modified
2. Test: Sentry event received
3. 847+ regression tests still passing
Gate: Sentry shows event. Code balance CLEAN.
/oodo
```
