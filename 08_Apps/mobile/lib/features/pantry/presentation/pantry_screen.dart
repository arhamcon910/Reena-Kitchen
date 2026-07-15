import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../household/providers/household_provider.dart';
import '../data/pantry_repository.dart';
import '../domain/pantry_item.dart';
import '../providers/pantry_provider.dart';
import 'add_item_dialog.dart';

class PantryScreen extends ConsumerWidget {
  const PantryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(pantryItemsProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar.large(
            title: Text('Pantry'),
            centerTitle: false,
          ),
          itemsAsync.when(
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
                    Text('Could not load pantry',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () => ref.invalidate(pantryItemsProvider),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
            data: (items) => items.isEmpty
                ? SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.kitchen_outlined,
                              size: 64,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withValues(alpha: 0.3)),
                          const SizedBox(height: 16),
                          Text('Your pantry is empty',
                              style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(height: 8),
                          Text('Tap + to add ingredients',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withValues(alpha: 0.5),
                                  )),
                        ],
                      ),
                    ),
                  )
                : SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) =>
                            _PantryItemTile(item: items[index]),
                        childCount: items.length,
                      ),
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add item',
        onPressed: () => _addItem(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _addItem(BuildContext context, WidgetRef ref) async {
    final data = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (_) => const AddItemDialog(),
    );
    if (data == null) return;

    final householdId = await ref.read(householdIdProvider.future);
    if (householdId.isEmpty) return;
    try {
      await ref.read(pantryRepositoryProvider).addItem(householdId, data);
      ref.invalidate(pantryItemsProvider);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add item: $e')),
        );
      }
    }
  }
}

class _PantryItemTile extends ConsumerWidget {
  const _PantryItemTile({required this.item});
  final PantryItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: Key(item.id),
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
      onDismissed: (_) => _delete(context, ref),
      child: Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: item.inStock
                ? Theme.of(context).colorScheme.primaryContainer
                : Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Text(
              item.name[0].toUpperCase(),
              style: TextStyle(
                color: item.inStock
                    ? Theme.of(context).colorScheme.onPrimaryContainer
                    : Theme.of(context).colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(item.name,
              style: TextStyle(
                decoration:
                    item.inStock ? null : TextDecoration.lineThrough,
              )),
          subtitle: Text(
            [
              if (item.quantity != null)
                '${item.quantity!.toStringAsFixed(item.quantity! % 1 == 0 ? 0 : 1)} ${item.unit ?? ''}',
              item.category,
            ].join(' · '),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          trailing: Switch(
            value: item.inStock,
            onChanged: (_) => _toggleStock(context, ref),
          ),
        ),
      ),
    );
  }

  Future<void> _toggleStock(BuildContext context, WidgetRef ref) async {
    try {
      final householdId = await ref.read(householdIdProvider.future);
      await ref.read(pantryRepositoryProvider).updateItem(
            householdId, item.id, {'inStock': !item.inStock});
      ref.invalidate(pantryItemsProvider);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    try {
      final householdId = await ref.read(householdIdProvider.future);
      await ref.read(pantryRepositoryProvider).deleteItem(householdId, item.id);
      ref.invalidate(pantryItemsProvider);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }
}
