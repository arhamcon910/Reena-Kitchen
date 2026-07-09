# Risk Register

**ID:** PM-RISK-001 | **v2.0** | **2026-07-06**

| ID | Risk | Severity | Mitigation | Status |
|---|---|---|---|---|
| R-001 | Anthropic API outage | High | MockAiEngine fallback | ✅ Mitigated |
| R-002 | Vegetarian policy violation | Critical | 9-layer enforcement + 50 scenarios | ✅ Mitigated |
| R-003 | SP data loss on update | High | SpMigrationService write-before-remove | ✅ Mitigated |
| R-004 | Confidence over-inflation | Medium | 67% floor, calibrated design | ✅ Mitigated |
| R-005 | Dinner vault exhaustion | Medium | Variety enforcement; flagged M-4 | 📋 Open |
| R-006 | No remote crash visibility | High | LoggingCrashReporter + Sentry stub | 📋 Phase 2 |
| R-007 | Reinstall loses personalisation | High | Device backup; server sync Phase 2 | 📋 Phase 2 |
| R-008 | GDPR compliance gap | Medium | Export+delete ready; UI Phase 2 | 📋 Phase 2 |
