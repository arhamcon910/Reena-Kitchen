# Performance Standards

**ID:** STD-PERF-001 | **v2.0** | **2026-07-06**

## Budgets

| Metric | Budget | RC1 | Headroom |
|---|---|---|---|
| Total startup path | <2ms | 1.12ms | 44% |
| Peak engine latency | <200µs | 162µs | 19% |
| 100 calls max complexity | <200ms | 11ms | 94% |
| SP total | <1MB | 56.4KB | 94% |
| Pre-prune signals | <50KB | 39.8KB | 20% |

## Rules

1. Exactly 2 `await` calls in `main()` — no more
2. `RecommendationEngine.recommend()` is synchronous — no async in ranking
3. Vault is in-memory — 0µs load, 0 network calls
4. `Image.network()`: 0 occurrences
5. All providers that can GC: use `autoDispose`
