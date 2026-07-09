# Security Standards

**ID:** STD-SEC-001 | **v2.0** | **2026-07-06**

## API Key Rules

| Rule | Implementation |
|---|---|
| Never hardcode key | `String.fromEnvironment("ANTHROPIC_API_KEY")` |
| Build-time injection | `--dart-define=ANTHROPIC_API_KEY=$KEY` |
| CI/CD | GitHub Secret → `--dart-define` |
| Audit | Automated: scan for `sk-ant-*` pattern |

## SharedPreferences PII Rules

- No email, phone, or national ID in any SP key
- All keys start with `reena.`
- All keys end with `.v1` (or `.v2` etc.)
- `deleteUserData()` removes all `reena.*` keys except `reena.schema.version`

## Logging Rules

- Only `requestId` logged in AI request logs
- No prompt content ever logged
- No SP values ever logged in production
- `kDebugMode` guard on all debug prints
