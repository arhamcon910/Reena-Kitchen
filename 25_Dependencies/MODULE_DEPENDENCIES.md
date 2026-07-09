# Module Dependencies

## Dependency Flow

```
AdaptiveHomeScreen
  → ReenaBrainProvider
    → RecommendationEngine → DecisionContext
      ← LearningProfileProvider ← SP
      ← FamilyPrefsProvider ← SP
      ← PantryProvider

TalkToReenaScreen
  → AnthropicChatService
    → ConversationRepository
      → AnthropicAiProvider
      → AiResponseFilter (veg guard)
      → SharedPrefsChatPersistence
```
