import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/storage/auth_storage.dart';
import '../domain/meal_plan.dart';
import '../providers/meal_plan_provider.dart';

class MealPlannerScreen extends ConsumerWidget {
  const MealPlannerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final planAsync = ref.watch(mealPlanProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text('Meal Planner'),
            centerTitle: false,
            actions: [
              IconButton(
                tooltip: 'Regenerate plan',
                icon: const Icon(Icons.refresh),
                onPressed: () async {
                  final prefs = ref.read(sharedPreferencesProvider);
                  await prefs.remove(AppConstants.keyMealPlan);
                  ref.invalidate(mealPlanProvider);
                },
              ),
            ],
          ),
          planAsync.when(
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (e, _) => SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48),
                    const SizedBox(height: 16),
                    Text('Could not load plan',
                        style: Theme.of(context).textTheme.titleMedium),
                    TextButton(
                      onPressed: () => ref.invalidate(mealPlanProvider),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
            data: (plan) => SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, i) => _DayCard(day: plan.days[i]),
                  childCount: plan.days.length,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DayCard extends StatelessWidget {
  const _DayCard({required this.day});
  final DayPlan day;

  @override
  Widget build(BuildContext context) {
    final isToday = day.isToday;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: isToday ? 3 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: isToday
            ? BorderSide(color: Theme.of(context).colorScheme.primary, width: 2)
            : BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Text(day.dayName,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isToday
                          ? Theme.of(context).colorScheme.primary
                          : null,
                    )),
            const SizedBox(width: 8),
            Text('${day.date.day}/${day.date.month}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.5),
                    )),
            if (isToday) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text('Today',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 11,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ]),
          const SizedBox(height: 12),
          ...day.slots.map((slot) => _MealSlotTile(slot: slot)),
        ]),
      ),
    );
  }
}

class _MealSlotTile extends StatelessWidget {
  const _MealSlotTile({required this.slot});
  final MealSlot slot;

  static const _icons = {
    'BREAKFAST': Icons.wb_sunny_outlined,
    'LUNCH': Icons.light_mode_outlined,
    'DINNER': Icons.nights_stay_outlined,
  };

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: slot.recipeId != null
          ? () => context.push('/recipes/${slot.recipeId}')
          : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(children: [
          Icon(_icons[slot.mealType] ?? Icons.restaurant_outlined,
              size: 20, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(slot.mealType,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: 0.5),
                      )),
              Text(slot.recipeName ?? 'No meal planned',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      )),
            ]),
          ),
          if (slot.recipeId != null)
            Icon(Icons.chevron_right,
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.3)),
        ]),
      ),
    );
  }
}
