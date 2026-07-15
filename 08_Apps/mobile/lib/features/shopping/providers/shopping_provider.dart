import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../household/providers/household_provider.dart';
import '../data/shopping_repository.dart';
import '../domain/shopping_models.dart';

final shoppingListsProvider =
    FutureProvider.autoDispose<List<ShoppingList>>((ref) async {
  final householdId = await ref.watch(householdIdProvider.future);
  if (householdId.isEmpty) return [];
  return ref.read(shoppingRepositoryProvider).getLists(householdId);
});
