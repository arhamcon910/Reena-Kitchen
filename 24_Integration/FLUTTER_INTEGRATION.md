# Flutter Integration

## Startup Sequence

```dart
main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = reporter.recordFlutterError;
  PlatformDispatcher.instance.onError = ...;
  final prefs = await SharedPreferences.getInstance();
  await SpMigrationService.initialise(prefs);
  runApp(ProviderScope(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(prefs),
      onboardingRepositoryProvider.overrideWithValue(
        SharedPreferencesOnboardingRepository(prefs)),
      crashReporterProvider.overrideWithValue(LoggingCrashReporter()),
    ],
    child: const ReenaApp(),
  ));
}
```

## Recommendation Flow

```
Home Screen → ReenaBrainProvider → RecommendationEngine.recommend(ctx)
    → DecisionContext (from LearningProfile + FamilyPrefs + Pantry)
    → MealRankingEngine (7 sub-engines, 162µs)
    → RankedRecipe + DecisionMetadata
    → UI render
```
