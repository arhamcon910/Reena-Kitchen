import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../data/recipe_repository.dart';
import '../domain/recipe.dart';

class RecipeDetailScreen extends ConsumerWidget {
  const RecipeDetailScreen({super.key, required this.recipeId});
  final String recipeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipeAsync = ref.watch(_recipeDetailProvider(recipeId));

    return Scaffold(
      body: recipeAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (recipe) => CustomScrollView(
          slivers: [
            SliverAppBar.large(
              title: Text(recipe.name),
              centerTitle: false,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilledButton.icon(
                    onPressed: () =>
                        context.push('/cooking/${recipe.id}'),
                    icon: const Icon(Icons.restaurant),
                    label: const Text('Cook'),
                  ),
                ),
              ],
            ),
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // ── Badges ──────────────────────────────────────────
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _Badge(recipe.cuisine,
                          color: Theme.of(context).colorScheme.primary),
                      _Badge(recipe.category,
                          color: Theme.of(context).colorScheme.secondary),
                      _Badge(recipe.spiceLevel,
                          color: Color(Recipe.spiceColors[recipe.spiceLevel] ??
                              0xFFFF9800)),
                      if (recipe.isVegetarian)
                        const _Badge('VEG 🌿',
                            color: Color(0xFF4CAF50)),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // ── Description ──────────────────────────────────────
                  if (recipe.description != null) ...[
                    Text(recipe.description!,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(height: 1.6)),
                    const SizedBox(height: 20),
                  ],

                  // ── Stats grid ───────────────────────────────────────
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _StatItem(Icons.timer_outlined,
                              '${recipe.prepMinutes + recipe.cookMinutes}',
                              'min total'),
                          _Divider(),
                          _StatItem(Icons.people_outline,
                              '${recipe.servings}', 'servings'),
                          if (recipe.calories != null) ...[
                            _Divider(),
                            _StatItem(
                                Icons.local_fire_department_outlined,
                                '${recipe.calories}',
                                'kcal'),
                          ],
                          if (recipe.costInr != null) ...[
                            _Divider(),
                            _StatItem(Icons.currency_rupee,
                                '${recipe.costInr}', 'cost'),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ── Time breakdown ───────────────────────────────────
                  if (recipe.prepMinutes > 0) ...[
                    const _Section('Time Breakdown'),
                    const SizedBox(height: 12),
                    Row(children: [
                      _TimeBar('Prep', recipe.prepMinutes,
                          recipe.prepMinutes + recipe.cookMinutes, context),
                      const SizedBox(width: 12),
                      _TimeBar('Cook', recipe.cookMinutes,
                          recipe.prepMinutes + recipe.cookMinutes, context),
                    ]),
                    const SizedBox(height: 20),
                  ],

                  // ── Ingredients ──────────────────────────────────────
                  if (recipe.ingredients.isNotEmpty) ...[
                    const _Section('Ingredients'),
                    const SizedBox(height: 12),
                    ...recipe.ingredients.map((i) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            children: [
                              Icon(Icons.circle,
                                  size: 8,
                                  color: Theme.of(context).colorScheme.primary),
                              const SizedBox(width: 12),
                              Expanded(
                                  child: Text(i,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium)),
                            ],
                          ),
                        )),
                    const SizedBox(height: 20),
                  ],

                  // ── Nutrition ────────────────────────────────────────
                  if (recipe.calories != null ||
                      recipe.proteinG != null) ...[
                    const _Section('Nutrition (per serving)'),
                    const SizedBox(height: 12),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            if (recipe.calories != null)
                              _NutritionRow(
                                  'Calories', '${recipe.calories} kcal'),
                            if (recipe.proteinG != null)
                              _NutritionRow('Protein',
                                  '${recipe.proteinG!.toStringAsFixed(1)}g'),
                            if (recipe.fibreG != null)
                              _NutritionRow('Fibre',
                                  '${recipe.fibreG!.toStringAsFixed(1)}g'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],

                  // ── Festivals ────────────────────────────────────────
                  if (recipe.festivals.isNotEmpty) ...[
                    const _Section('Festivals'),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      children: recipe.festivals
                          .map((f) => Chip(
                                avatar: const Icon(Icons.celebration,
                                    size: 16),
                                label: Text(f),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 20),
                  ],

                  // ── Tags ─────────────────────────────────────────────
                  if (recipe.tags.isNotEmpty) ...[
                    const _Section('Tags'),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      children: recipe.tags
                          .map((t) => Chip(label: Text(t)))
                          .toList(),
                    ),
                    const SizedBox(height: 32),
                  ],

                  // ── Start cooking CTA ─────────────────────────────────
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: FilledButton.icon(
                      onPressed: () =>
                          context.push('/cooking/${recipe.id}'),
                      icon: const Icon(Icons.restaurant),
                      label: const Text('Start Cooking',
                          style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  const SizedBox(height: 32),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Helpers ─────────────────────────────────────────────────────────────────

final _recipeDetailProvider =
    FutureProvider.autoDispose.family<Recipe, String>((ref, id) async {
  final repo = ref.read(recipeRepositoryProvider);
  return repo.getById(id);
});

class _Section extends StatelessWidget {
  const _Section(this.title);
  final String title;
  @override
  Widget build(BuildContext context) => Text(title,
      style: Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(fontWeight: FontWeight.bold));
}

class _Badge extends StatelessWidget {
  const _Badge(this.label, {required this.color});
  final String label;
  final Color color;
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20)),
        child: Text(label,
            style: TextStyle(color: color, fontWeight: FontWeight.w600)),
      );
}

class _StatItem extends StatelessWidget {
  const _StatItem(this.icon, this.value, this.label);
  final IconData icon;
  final String value;
  final String label;
  @override
  Widget build(BuildContext context) => Column(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 4),
          Text(value,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
          Text(label, style: Theme.of(context).textTheme.bodySmall),
        ],
      );
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Container(height: 40, width: 1,
          color: Theme.of(context).colorScheme.outlineVariant);
}

class _TimeBar extends StatelessWidget {
  const _TimeBar(this.label, this.minutes, this.total, this.context);
  final String label;
  final int minutes;
  final int total;
  final BuildContext context;
  @override
  Widget build(BuildContext ctx) => Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('$label: ${minutes}min',
              style: Theme.of(ctx).textTheme.bodySmall),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: total > 0 ? minutes / total : 0,
            backgroundColor:
                Theme.of(ctx).colorScheme.surfaceContainerHighest,
          ),
        ]),
      );
}

class _NutritionRow extends StatelessWidget {
  const _NutritionRow(this.label, this.value);
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: Theme.of(context).textTheme.bodyMedium),
            Text(value,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
      );
}
