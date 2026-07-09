# AI Provider Architecture

**ID:** AI-PROV-001 | **v2.0** | **2026-07-06**

## Provider Stack

```
aiSdkProvider
  └► instrumentedAiSdkProvider
       └► InstrumentedAiProvider (telemetry)
            └► AnthropicAiProvider
            │    ├── AiResponseCache (TTL + LRU-30)
            │    ├── AiResponseFilter (26 kw pre+post)
            │    ├── AiRequestLogger (requestId only)
            │    └── retry(3) + timeout(30s) + exp. backoff
            └► MockAiEngine (fallback on all failures)
```

## Retry Policy

```
Attempt 1: immediate
Attempt 2: 1s  (1 << 1)
Attempt 3: 2s  (1 << 2)
isRetryable: 503, 429 → retry; 4xx → fast-fail
Timeout: 30s per attempt
```

## Vegetarian Double Enforcement

```
AiResponseFilter.validateRequest(prompt)  // pre-filter: 26 keywords
AnthropicAiProvider.generate(request)     // LLM call
AiResponseFilter.filter(response)         // post-filter
ConversationRepository._filter.filter()   // independent 2nd check
```

## Security

- API key: `String.fromEnvironment("ANTHROPIC_API_KEY")` — build-time only
- Logging: `requestId` only — no prompt content, no user data
- 0 occurrences of `sk-ant-*` verified by automated audit
