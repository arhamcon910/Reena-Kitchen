# Decision Engine Architecture

**ID:** AI-DE-001 | **v2.0** | **2026-07-06**

## Overview

7 sub-engines orchestrated by `MealRankingEngine`, scoring all eligible vegetarian recipes for a given meal slot, family context, and moment.

## Engine Stack

```
MealRankingEngine (orchestrator)
├── BudgetEngine          10–22 pts  (4-tier cost-to-target)
├── VarietyEngine         −25→+8 pts (novel=+8, same-day=−25)
├── WeatherEngine         0–6 pts    (±6 at 12°C/38°C extremes)
├── FestivalEngine        0–24 pts   (+20 match, +4 veg tiebreaker)
├── HealthGoalEngine      −10→+30pts (8 goal types, stackable)
├── LearningEngine        0–12 pts   (pantry + affinity + seasonal×1.5)
└── NutritionTiebreaker   0.3–3.0pts (protein + fibre + calorie band)
```

## Confidence Formula

```
confidence = gapWeight × 0.60 + rankWeight × 0.40
gapWeight  = max(0.45, min(1.0, gap / (gap + σ)))
σ          = max(1.0, score_range / 4)
```

**Minimum confidence:** 67% (gapWeight floor: 0.45×0.60 + 1.0×0.40 = 0.67)

## 5-Tier Labels

| Tier | Threshold | Meaning |
|---|---|---|
| Strong pick | ≥90% | Exceptional alignment |
| Confident pick | ≥75% | Clear winner |
| Good match | ≥55% | Solid choice |
| Worth trying | ≥35% | Viable option |
| Exploratory | <35% | Cold start |

## Test Coverage: 847 assertions across 18 files

Key gate suites:
- `family_journey_integration_test.dart` — 43 tests, 10 lifecycle steps
- `release_candidate_test.dart` — 36 RC1 gate tests
- `benchmark_test.dart` — 50/50 vegetarian scenarios
