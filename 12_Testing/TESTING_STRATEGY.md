# Testing Strategy

**ID:** TEST-STRAT-001 | **v2.0** | **2026-07-06**

## Philosophy

> No code reaches distribution without passing its gate suite.

## Test Suite — RC1 (847 total)

| File | Type | Count | Gate |
|---|---|---|---|
| family_journey_integration_test | Integration | 43 | ⭐ RC1 |
| release_candidate_test | Gate | 36 | ⭐ RC1 |
| release_v120_test | Gate | 68 | ⭐ CB1 |
| benchmark_test | Scenario | 51 | ⭐ Veg |
| decision_engine_test | Unit | 67 | — |
| decision_quality_test | Unit | 61 | — |
| explainability_test | Unit | 45 | — |
| explanation_test | Unit | 33 | — |
| family_intelligence_test | Unit | 48 | — |
| family_memory_test | Unit | 47 | — |
| learning_engine_test | Unit | 49 | — |
| persistence_test | Unit | 44 | — |
| production_readiness_test | Unit | 47 | — |
| sprint1_persistence_test | Unit | 38 | — |
| sprint3_completion_test | Unit | 32 | — |
| sprint4_readiness_test | Unit | 48 | — |
| sprint5_completion_test | Unit | 59 | — |
| vegetarian_policy_test | Unit | 31 | — |
| **Total** | | **847** | |

## Vegetarian Test Coverage

| Test | Scenarios | Result |
|---|---|---|
| benchmark_test scenarios | 50/50 | ✅ ALL VEG |
| family scenarios | 15/15 | ✅ ALL VEG |
| spot-checks | 10/10 | ✅ ALL VEG |
| Integration steps 3,7,8,10 | 4/4 | ✅ ALL VEG |

## RC1 Gate Requirements

Before `1.0.0-rc.1` tag:
- release_candidate_test ≥ 30 assertions ✅
- family_journey_integration_test ≥ 40 ✅
- benchmark_test 50/50 vegetarian ✅
- Code balance: CLEAN ✅
- 75/75 engineering audit checks ✅

## Test Conventions

```dart
// Lightweight harness used in all REENA tests
int _p = 0, _f = 0;
final _fails = <String>[];

void _test(String name, bool Function() body) {
  try {
    if (body()) { _p++; }
    else { _f++; _fails.add("  ✗ $name"); }
  } catch (e) { _f++; _fails.add("  ✗ $name threw: $e"); }
}
```
