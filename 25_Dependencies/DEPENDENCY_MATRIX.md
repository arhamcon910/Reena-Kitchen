# Dependency Matrix

## Flutter Package Graph

```
reena (app)
├── design_system (tokens, components)
├── knowledge_vault → design_system
├── decision_engine → knowledge_vault
├── ai_sdk (Anthropic + Mock, http, SP)
├── personality_engine → ai_sdk
└── reena_brain → decision_engine + ai_sdk + personality_engine
```

## External Services

| Service | Phase | Status |
|---|---|---|
| Anthropic API | 1 | ✅ Active |
| Apple Developer | 1 | 📋 Required |
| Google Play | 1 | 📋 Required |
| Sentry | 2 | 📋 Planned |
| Supabase | 2 | 📋 Planned |
