# Database Integration

## Phase 1 — SP Keys

```
reena.schema.version          int
reena.learning.signals.v1     JSON Array<LearningSignal>
reena.family.v1               JSON Object
reena.chat.<id>.v1            JSON Array<ChatMessage>
```

## Phase 2 — Supabase

```dart
await Supabase.initialize(
  url: "https://xxx.supabase.co",
  anonKey: String.fromEnvironment("SUPABASE_ANON_KEY"),
);
```
