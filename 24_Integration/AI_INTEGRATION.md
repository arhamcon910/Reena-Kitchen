# AI Integration

## Provider Stack

```
aiSdkProvider
  → instrumentedAiSdkProvider
    → AnthropicAiProvider [retry+cache+filter]
      or MockAiEngine [offline fallback]
```

## Build Command

```bash
flutter run --dart-define=ANTHROPIC_API_KEY=sk-ant-...
```

## Vegetarian Enforcement in AI

Pre-filter (26 kw) → LLM call → Post-filter → ConvRepo filter (independent)
