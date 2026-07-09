# Accessibility Standards

**ID:** STD-A11Y-001 | **v2.0** | **2026-07-06**

## RC1 Metrics

| Metric | Count | Target |
|---|---|---|
| `Semantics()` uses | 37 | ≥30 ✓ |
| `MergeSemantics` | 2 | ≥2 ✓ |
| `tooltip:` | 6 | ≥5 ✓ |
| `RepaintBoundary` | 6 | ≥6 ✓ |
| `dispose()` | 17 | ≥10 ✓ |

## Required Per Screen

```dart
// Hero text: textScaler.clamp
Text(style: ..., textScaler: MediaQuery.textScalerOf(context)
  .clamp(minScaleFactor: 0.8, maxScaleFactor: 1.4))

// Chips: toggled semantics
Semantics(toggled: isSelected, label: chipLabel, child: Chip(...))

// Icon buttons: tooltip
IconButton(tooltip: "Description", icon: ...)
```

## WCAG 2.1 AA Targets

- Contrast ratio: 4.5:1 normal text, 3.0:1 large text
- Touch targets: 48×48dp minimum
- Focus order: logical top-to-bottom, left-to-right
