import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/providers/auth_provider.dart';
import '../../../meal_planner/providers/meal_plan_provider.dart';

class HomeTab extends ConsumerWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final name = auth.name ?? 'there';
    final planAsync = ref.watch(mealPlanProvider);

    return CustomScrollView(
      slivers: [
        const SliverAppBar.large(
          title: Text('REENA AI Kitchen'),
          centerTitle: false,
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // ── Greeting ───────────────────────────────────────────────
              Card(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hello, $name 👋',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                              )),
                      const SizedBox(height: 4),
                      Text('What shall we cook today?',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer
                                    .withValues(alpha: 0.8),
                              )),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // ── Today's meals ──────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Today\'s Meals',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600)),
                  TextButton(
                    onPressed: () => context.push('/planner'),
                    child: const Text('Full plan →'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              planAsync.when(
                loading: () => const SizedBox(
                    height: 80,
                    child: Center(child: CircularProgressIndicator())),
                error: (_, __) => const SizedBox.shrink(),
                data: (plan) {
                  final today = plan.today;
                  if (today == null) return const SizedBox.shrink();
                  return Card(
                    child: Column(
                      children: today.slots
                          .map((slot) => ListTile(
                                dense: true,
                                leading: Icon(
                                  slot.mealType == 'BREAKFAST'
                                      ? Icons.wb_sunny_outlined
                                      : slot.mealType == 'LUNCH'
                                          ? Icons.light_mode_outlined
                                          : Icons.nights_stay_outlined,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                title: Text(slot.recipeName ?? '—'),
                                subtitle: Text(slot.mealType),
                                trailing: const Icon(Icons.chevron_right),
                                onTap: slot.recipeId != null
                                    ? () => context
                                        .push('/recipes/${slot.recipeId}')
                                    : null,
                              ))
                          .toList(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),

              // ── Quick actions ──────────────────────────────────────────
              Text('Quick Actions',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      )),
              const SizedBox(height: 12),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.4,
                children: [
                  _QuickActionCard(
                    icon: Icons.calendar_today,
                    label: 'Meal Plan',
                    subtitle: 'This week',
                    onTap: () => context.push('/planner'),
                  ),
                  _QuickActionCard(
                    icon: Icons.restaurant_menu,
                    label: 'Recipes',
                    subtitle: 'Discover meals',
                    onTap: () {},
                  ),
                  _QuickActionCard(
                    icon: Icons.kitchen,
                    label: 'Pantry',
                    subtitle: 'Manage ingredients',
                    onTap: () {},
                  ),
                  _QuickActionCard(
                    icon: Icons.shopping_cart_outlined,
                    label: 'Shopping',
                    subtitle: 'Coming soon',
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ]),
          ),
        ),
      ],
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  const _QuickActionCard({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Theme.of(context).colorScheme.primary),
              const SizedBox(height: 8),
              Text(label,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.w600)),
              Text(subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: 0.6),
                      )),
            ],
          ),
        ),
      ),
    );
  }
}
