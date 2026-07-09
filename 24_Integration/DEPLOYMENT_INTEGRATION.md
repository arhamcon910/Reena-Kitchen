# Deployment Integration

## iOS

```bash
flutter build ipa --release \
  --dart-define=ANTHROPIC_API_KEY=$KEY
xcrun altool --upload-app -f build/ios/ipa/reena.ipa ...
```

## Android

```bash
flutter build appbundle --release \
  --dart-define=ANTHROPIC_API_KEY=$KEY
```

## CI/CD (GitHub Actions)

```yaml
- run: flutter test packages/decision_engine/test/
- run: flutter build ipa --dart-define=ANTHROPIC_API_KEY=${{ secrets.ANTHROPIC_API_KEY }}
```
