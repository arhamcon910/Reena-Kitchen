import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../household/providers/household_provider.dart';
import '../data/shopping_repository.dart';
import '../domain/shopping_models.dart';

class ShoppingListScreen extends ConsumerStatefulWidget {
  const ShoppingListScreen({super.key, required this.shoppingList});
  final ShoppingList shoppingList;

  @override
  ConsumerState<ShoppingListScreen> createState() =>
      _ShoppingListScreenState();
}

class _ShoppingListScreenState extends ConsumerState<ShoppingListScreen> {
  late ShoppingList _list;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _list = widget.shoppingList;
  }

  Future<void> _refresh() async {
    try {
      final householdId = await ref.read(householdIdProvider.future);
      final updated = await ref
          .read(shoppingRepositoryProvider)
          .getList(householdId, _list.id);
      setState(() => _list = updated);
    } catch (_) {}
  }

  Future<void> _toggleItem(ShoppingItem item) async {
    try {
      final householdId = await ref.read(householdIdProvider.future);
      await ref.read(shoppingRepositoryProvider).toggleItem(
            householdId, _list.id, item.id, !item.isPurchased);
      await _refresh();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  Future<void> _removeItem(ShoppingItem item) async {
    try {
      final householdId = await ref.read(householdIdProvider.future);
      await ref
          .read(shoppingRepositoryProvider)
          .removeItem(householdId, _list.id, item.id);
      await _refresh();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  Future<void> _addItem() async {
    final nameCtrl = TextEditingController();
    final qtyCtrl  = TextEditingController();
    final unitCtrl = TextEditingController();

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                  labelText: 'Item name *', border: OutlineInputBorder()),
              textCapitalization: TextCapitalization.words,
              autofocus: true,
            ),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(
                child: TextField(
                  controller: qtyCtrl,
                  decoration: const InputDecoration(
                      labelText: 'Qty', border: OutlineInputBorder()),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: unitCtrl,
                  decoration: const InputDecoration(
                      labelText: 'Unit', hintText: 'kg, L',
                      border: OutlineInputBorder()),
                ),
              ),
            ]),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              if (nameCtrl.text.trim().isEmpty) return;
              Navigator.pop(context, {
                'name': nameCtrl.text.trim(),
                if (qtyCtrl.text.isNotEmpty)
                  'quantity': double.tryParse(qtyCtrl.text) ?? 1.0,
                if (unitCtrl.text.isNotEmpty) 'unit': unitCtrl.text.trim(),
              });
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );

    if (result == null) return;
    try {
      final householdId = await ref.read(householdIdProvider.future);
      await ref
          .read(shoppingRepositoryProvider)
          .addItem(householdId, _list.id, result);
      await _refresh();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  Future<void> _completeList() async {
    setState(() => _saving = true);
    try {
      final householdId = await ref.read(householdIdProvider.future);
      final updated = await ref
          .read(shoppingRepositoryProvider)
          .completeList(householdId, _list.id);
      setState(() { _list = updated; _saving = false; });
    } catch (e) {
      setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final unpurchased = _list.items.where((i) => !i.isPurchased).toList();
    final purchased   = _list.items.where((i) => i.isPurchased).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(_list.name),
        centerTitle: false,
        actions: [
          if (!_list.isCompleted && _list.totalItems > 0)
            TextButton.icon(
              onPressed: _saving ? null : _completeList,
              icon: const Icon(Icons.check_circle_outline),
              label: const Text('Done'),
            ),
          IconButton(
            tooltip: 'Add item',
            icon: const Icon(Icons.add),
            onPressed: _addItem,
          ),
        ],
        bottom: _list.totalItems > 0
            ? PreferredSize(
                preferredSize: const Size.fromHeight(6),
                child: LinearProgressIndicator(
                  value: _list.progress,
                  backgroundColor:
                      Theme.of(context).colorScheme.surfaceContainerHighest,
                ),
              )
            : null,
      ),
      body: _list.items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_basket_outlined,
                      size: 64,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.3)),
                  const SizedBox(height: 16),
                  const Text('List is empty'),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: _addItem,
                    child: const Text('Add an item'),
                  ),
                ],
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (unpurchased.isNotEmpty) ...[
                  Text('To buy (${unpurchased.length})',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          )),
                  const SizedBox(height: 8),
                  ...unpurchased.map((item) => _ItemTile(
                        item: item,
                        onToggle: () => _toggleItem(item),
                        onDelete: () => _removeItem(item),
                      )),
                  const SizedBox(height: 16),
                ],
                if (purchased.isNotEmpty) ...[
                  Text('Purchased (${purchased.length})',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withValues(alpha: 0.5),
                            fontWeight: FontWeight.bold,
                          )),
                  const SizedBox(height: 8),
                  ...purchased.map((item) => _ItemTile(
                        item: item,
                        onToggle: () => _toggleItem(item),
                        onDelete: () => _removeItem(item),
                      )),
                ],
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        tooltip: 'Add item',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ItemTile extends StatelessWidget {
  const _ItemTile({
    required this.item,
    required this.onToggle,
    required this.onDelete,
  });
  final ShoppingItem item;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(item.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.errorContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(Icons.delete_outline,
            color: Theme.of(context).colorScheme.onErrorContainer),
      ),
      onDismissed: (_) => onDelete(),
      child: Card(
        margin: const EdgeInsets.only(bottom: 6),
        child: ListTile(
          leading: Checkbox(
            value: item.isPurchased,
            onChanged: (_) => onToggle(),
            shape: const CircleBorder(),
          ),
          title: Text(
            item.name,
            style: TextStyle(
              decoration:
                  item.isPurchased ? TextDecoration.lineThrough : null,
              color: item.isPurchased
                  ? Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.5)
                  : null,
            ),
          ),
          subtitle: item.quantity != null
              ? Text(
                  '${item.quantity!.toStringAsFixed(item.quantity! % 1 == 0 ? 0 : 1)} ${item.unit ?? ''} · ${item.category}',
                  style: Theme.of(context).textTheme.bodySmall,
                )
              : Text(item.category,
                  style: Theme.of(context).textTheme.bodySmall),
          onTap: onToggle,
        ),
      ),
    );
  }
}
