# REENA Engineering Handbook

**ID:** ENG-HANDBOOK-001 | **v1.0** | **2026-07-06**

---

## 1. Coding Standards

- File names: `snake_case.dart`
- Classes: `PascalCase`
- All SP keys: `reena.[domain].v1`
- All providers: overridable via `ProviderScope.overrides`
- `Image.network()`: 0 occurrences permitted
- API key: `String.fromEnvironment("ANTHROPIC_API_KEY")` only

Full guide: `19_Standards/CODING_STANDARDS.md`

## 2. Review Standards

All PRs must pass before merge:
- [ ] `flutter analyze` — 0 warnings
- [ ] `flutter test` — 847+ assertions passing
- [ ] Code balance: CLEAN
- [ ] Vegetarian audit: no new escape paths
- [ ] `01_Project_Management/CLAUDE_DELIVERY_REGISTER.md` updated

## 3. Testing Standards

- Every feature: unit tests for domain logic
- Every food/AI output: vegetarian assertion
- Every integration: use real vault + real engine (no mocks)

```dart
// Required on all food-related tests
_test("Result is vegetarian", () =>
    engine.recommend(ctx).topPick.recipe.isVegetarian);
```

## 4. Git Standards

### Branch Naming
```
feature/pkg-XXX-description
fix/iss-XXX-description
chore/description
release/vX.Y.Z
```

### Commit Messages
```
feat(decision-engine): add NutritionTiebreaker
fix(learning): correct cuisine affinity threshold
chore(deps): add sentry_flutter ^8.0.0
docs(engineering): add ENGINEERING_HANDBOOK
```

## 5. Architecture Standards

- Strict layers: Presentation → Application → Domain → Data
- No circular imports between packages
- Vegetarian policy: 9-layer permanent invariant, never configurable
- Phase 1 architecture is **frozen** — changes require ADR

## 6. AI Standards

- All Claude prompts: use template from `22_Claude/PROMPT_STANDARDS.md`
- End every prompt with `/oodo`
- State vegetarian policy requirement for all food features
- API key: `--dart-define` only

## 7. Release Standards

Before any tag:
1. Engineering audit: ≥75 checks
2. Tests: all assertions passing
3. Code balance: CLEAN
4. Vegetarian: 0 violations

See `21_Engineering/RELEASE_CHECKLIST.md`

---

## Quick Reference

| Need | Document |
|---|---|
| Coding style | `19_Standards/CODING_STANDARDS.md` |
| Security | `19_Standards/SECURITY_STANDARDS.md` |
| Accessibility | `19_Standards/ACCESSIBILITY_STANDARDS.md` |
| Performance | `19_Standards/PERFORMANCE_STANDARDS.md` |
| Test guide | `12_Testing/TESTING_STRATEGY.md` |
| Sprint template | `20_Templates/TEMPLATE_SPRINT.md` |
| Claude prompts | `22_Claude/PROMPT_STANDARDS.md` |

---
*REENA AI Kitchen · Engineering Handbook v1.0 · 2026-07-06*
