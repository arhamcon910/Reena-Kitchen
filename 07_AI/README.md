# 07_AI — AI Architecture

| Document | Purpose |
|---|---|
| [DECISION_ENGINE.md](DECISION_ENGINE.md) | 7-engine recommendation system |
| [AI_PROVIDER_ARCHITECTURE.md](AI_PROVIDER_ARCHITECTURE.md) | LLM provider stack |

## Quick Reference

- Decision Engine: 7 sub-engines, 162µs peak latency, 847 tests
- AI Provider: Anthropic + MockAiEngine fallback, retry(3), 30s timeout
- Vegetarian: 9-layer enforcement, 0 violations ever recorded
