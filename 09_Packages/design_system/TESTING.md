# design_system — Testing

## Running Tests

```bash
cd 09_Packages/design_system
flutter test
```

## Coverage Target

| Area | Target |
|---|---|
| Domain models | 90% |
| Data layer | 80% |
| Application | 75% |

## Vegetarian Assertion (required for all food-related tests)

```dart
_test('Result is vegetarian', () =>
    engine.recommend(ctx).topPick.recipe.isVegetarian);
```
