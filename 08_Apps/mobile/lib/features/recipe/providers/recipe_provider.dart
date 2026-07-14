import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/recipe_repository.dart';
import '../domain/recipe.dart';

final selectedCategoryProvider = StateProvider<String>((ref) => 'ALL');
final searchQueryProvider      = StateProvider<String>((ref) => '');

final recipesProvider = FutureProvider.autoDispose<List<Recipe>>((ref) async {
  final category = ref.watch(selectedCategoryProvider);
  final q        = ref.watch(searchQueryProvider);
  return ref.read(recipeRepositoryProvider).getAll(
        category: category == 'ALL' ? null : category,
        q: q.isEmpty ? null : q,
      );
});
