# Testing Integration

## Test Injection (Riverpod)

```dart
final container = ProviderContainer(overrides: [
  sharedPreferencesProvider.overrideWithValue(FakeSP()),
  crashReporterProvider.overrideWithValue(NoOpCrashReporter()),
]);
```

## Integration Test Rule

Use real vault + real engine in integration tests:
```dart
final _vault  = IndianKnowledgeVault();  // REAL
final _engine = RecommendationEngine(vault: _vault);  // REAL
```
