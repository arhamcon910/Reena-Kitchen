import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../household/providers/household_provider.dart';
import '../../meal_planner/providers/meal_plan_provider.dart';
import '../../pantry/data/pantry_repository.dart';
import '../../recipe/data/recipe_repository.dart';
import '../data/shopping_repository.dart';
import '../domain/shopping_models.dart';
import '../providers/shopping_provider.dart';
import 'shopping_list_screen.dart';

class ShoppingScreen extends ConsumerWidget {
  const ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listsAsync = ref.watch(shoppingListsProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar.large(
            title: Text('Shopping'),
            centerTitle: false,
          ),
          listsAsync.when(
            loading: () => const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator())),
            error: (e, _) => SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48),
                    const SizedBox(height: 16),
                    Text('Could not load lists',
                        style: Theme.of(context).textTheme.titleMedium),
                    TextButton(
                      onPressed: () => ref.invalidate(shoppingListsProvider),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
            data: (lists) => lists.isEmpty
                ? SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_cart_outlined,
                              size: 64,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withValues(alpha: 0.3)),
                          const SizedBox(height: 16),
                          Text('No shopping lists yet',
                              style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(height: 8),
                          Text('Tap + to create one',
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ),
                  )
                : SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (_, i) => _ShoppingListCard(list: lists[i]),
                        childCount: lists.length,
                      ),
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.small(
            heroTag: 'generate',
            tooltip: 'Generate from today\'s meals',
            onPressed: () => _generateFromMeals(context, ref),
            child: const Icon(Icons.auto_awesome),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'create',
            tooltip: 'Create list',
            onPressed: () => _createList(context, ref),
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  Future<void> _createList(BuildContext context, WidgetRef ref) async {
    final ctrl = TextEditingController(text: 'Weekly Groceries');
    final name = await showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('New Shopping List'),
        content: TextField(
          controller: ctrl,
          decoration: const InputDecoration(
              labelText: 'List name', border: OutlineInputBorder()),
          autofocus: true,
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          FilledButton(
              onPressed: () => Navigator.pop(context, ctrl.text.trim()),
              child: const Text('Create')),
        ],
      ),
    );
    if (name == null || name.isEmpty) return;

    try {
      final householdId = await ref.read(householdIdProvider.future);
      await ref.read(shoppingRepositoryProvider).createList(householdId, name);
      ref.invalidate(shoppingListsProvider);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  Future<void> _generateFromMeals(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);

    try {
      // Get today's meal plan
      final plan = await ref.read(mealPlanProvider.future);
      final today = plan.today;
      if (today == null || today.slots.isEmpty) {
        messenger.showSnackBar(
            const SnackBar(content: Text('No meal plan for today')));
        return;
      }

      // Show loading
      messenger.showSnackBar(
        const SnackBar(
          content: Row(children: [
            SizedBox(width: 20, height: 20,
                child: CircularProgressIndicator(strokeWidth: 2)),
            SizedBox(width: 12),
            Text('Gathering ingredients...'),
          ]),
          duration: Duration(seconds: 5),
        ),
      );

      // Collect all ingredients from today's recipes
      final ingredients = <String>[];
      for (final slot in today.slots) {
        if (slot.recipeId == null) continue;
        try {
          final recipe = await ref
              .read(recipeRepositoryProvider)
              .getById(slot.recipeId!);
          ingredients.addAll(recipe.ingredients);
        } catch (_) {}
      }

      if (ingredients.isEmpty) {
        messenger.clearSnackBars();
        messenger.showSnackBar(
            const SnackBar(content: Text('No ingredients found')));
        return;
      }

      // Get pantry items to exclude
      final householdId = await ref.read(householdIdProvider.future);
      final pantryItems = await ref
          .read(pantryRepositoryProvider)
          .getItems(householdId);
      final pantryNames =
          pantryItems.where((p) => p.inStock).map((p) => p.name).toList();

      // Generate the list
      final result = await ref.read(shoppingRepositoryProvider).generateList(
            householdId,
            name: "Today's Meals — ${today.dayName}",
            ingredients: ingredients.toSet().toList(),
            pantryItems: pantryNames,
          );

      messenger.clearSnackBars();
      ref.invalidate(shoppingListsProvider);

      final skipped = (result['skipped'] as List?)?.length ?? 0;
      final count = result['message'] as String? ?? 'List generated';
      messenger.showSnackBar(
        SnackBar(
          content: Text('$count ($skipped already in pantry)'),
          backgroundColor: const Color(0xFF4CAF50),
        ),
      );
    } catch (e) {
      messenger.clearSnackBars();
      messenger.showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }
}

class _ShoppingListCard extends ConsumerWidget {
  const _ShoppingListCard({required this.list});
  final ShoppingList list;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: Key(list.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.errorContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(Icons.delete_outline,
            color: Theme.of(context).colorScheme.onErrorContainer),
      ),
      onDismissed: (_) async {
        final householdId = await ref.read(householdIdProvider.future);
        await ref
            .read(shoppingRepositoryProvider)
            .deleteList(householdId, list.id);
        ref.invalidate(shoppingListsProvider);
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ShoppingListScreen(shoppingList: list),
            ),
          ).then((_) => ref.invalidate(shoppingListsProvider)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(list.name,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold)),
                    ),
                    if (list.isCompleted)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4CAF50).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text('DONE',
                            style: TextStyle(
                                color: Color(0xFF4CAF50),
                                fontSize: 11,
                                fontWeight: FontWeight.bold)),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                if (list.totalItems > 0) ...[
                  Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value: list.progress,
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text('${list.purchasedItems}/${list.totalItems}',
                          style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ] else
                  Text('Empty list',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withValues(alpha: 0.5),
                          )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}