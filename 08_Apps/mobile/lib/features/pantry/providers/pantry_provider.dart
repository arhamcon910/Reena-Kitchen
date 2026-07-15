import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../household/providers/household_provider.dart';
import '../data/pantry_repository.dart';
import '../domain/pantry_item.dart';

final pantryItemsProvider =
    FutureProvider.autoDispose<List<PantryItem>>((ref) async {
  final householdId = await ref.watch(householdIdProvider.future);
  if (householdId.isEmpty) return [];
  return ref.read(pantryRepositoryProvider).getItems(householdId);
});
