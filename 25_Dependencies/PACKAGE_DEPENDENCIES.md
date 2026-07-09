# Package Dependencies

| Package | Depends On |
|---|---|
| design_system | flutter |
| knowledge_vault | design_system |
| decision_engine | knowledge_vault, flutter_riverpod |
| ai_sdk | http, shared_preferences, flutter_riverpod |
| personality_engine | ai_sdk |
| reena_brain | decision_engine, ai_sdk, personality_engine |
| reena (app) | all packages above |
