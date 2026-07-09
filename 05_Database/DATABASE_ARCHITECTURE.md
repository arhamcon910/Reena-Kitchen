# Database Architecture

**ID:** DB-ARCH-001 | **v2.0** | **2026-07-06**

## Phase 1 — SharedPreferences (Current)

### SP Key Schema

| Key | Type | Description |
|---|---|---|
| `reena.schema.version` | int | Migration sentinel |
| `reena.learning.signals.v1` | JSON Array | LearningSignal[] |
| `reena.family.v1` | JSON Object | FamilyPreferences |
| `reena.family.memories.v1` | JSON Object | Extended context |
| `reena.onboarding.complete.v1` | bool | Onboarding done |
| `reena.onboarding.skipped.v1` | bool | Onboarding skipped |
| `reena.chat.<threadId>.v1` | JSON Array | ChatMessage[] (50) |

### LearningSignal Schema

```json
{
  "recipeId": "string",
  "type": "accepted|completed|rated|seasonal|festival",
  "recordedAt": "ISO-8601",
  "starRating": "float|null",
  "cookMinutes": "int|null",
  "pantryIngredients": ["string"],
  "cuisineRegion": "string|null",
  "festivalName": "string|null"
}
```

### Storage Budget

| Component | Typical | Max | Limit |
|---|---|---|---|
| 200 signals | — | 39.8 KB | 50 KB ✓ |
| Total SP | ~17 KB | 56.4 KB | 5,120 KB ✓ |

## Phase 2 — Supabase (Planned)

```sql
CREATE TABLE learning_signals (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    household_id    UUID REFERENCES households(id) ON DELETE CASCADE,
    recipe_id       TEXT NOT NULL,
    signal_type     TEXT NOT NULL,
    recorded_at     TIMESTAMPTZ NOT NULL,
    star_rating     FLOAT,
    cook_minutes    INT,
    pantry_ingredients TEXT[],
    cuisine_region  TEXT,
    festival_name   TEXT
);
CREATE INDEX ON learning_signals(household_id, recorded_at DESC);
```

## Migration Rules

1. Write new key before removing old key
2. Idempotent: safe on every cold start
3. Silent-fail per key
4. Schema version key never deleted by `deleteUserData()`
