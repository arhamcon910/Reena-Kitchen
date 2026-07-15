import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/storage/auth_storage.dart';
import '../../recipe/data/recipe_repository.dart';
import '../../recipe/domain/recipe.dart';
import '../domain/meal_plan.dart';

final mealPlanProvider = FutureProvider.autoDispose<MealPlan>((ref) async {
  final prefs = ref.read(sharedPreferencesProvider);
  final stored = prefs.getString(AppConstants.keyMealPlan);

  if (stored != null) {
    try {
      final plan = MealPlan.fromJsonString(stored);
      if (!plan.isExpired) return plan;
    } catch (_) {}
  }

  final recipes = await ref.read(recipeRepositoryProvider).getAll();
  final plan = generateWeeklyPlan(recipes);
  await prefs.setString(AppConstants.keyMealPlan, plan.toJsonString());
  return plan;
});

Recipe pickRecipe(List<Recipe> pool, List<Recipe> fallback, int index) {
  final list = pool.isNotEmpty ? pool : fallback;
  return list[index % list.length];
}

MealPlan generateWeeklyPlan(List<Recipe> recipes) {
  if (recipes.isEmpty) {
    return MealPlan(days: [], generatedAt: DateTime.now());
  }

  final breakfasts = recipes.where((r) => r.category == 'BREAKFAST').toList();
  final lunches    = recipes.where((r) => r.category == 'LUNCH').toList();
  final dinners    = recipes.where((r) => r.category == 'DINNER').toList();
  final all        = List<Recipe>.from(recipes)..shuffle();

  final now    = DateTime.now();
  final monday = now.subtract(Duration(days: now.weekday - 1));

  final days = List.generate(7, (i) {
    final date = monday.add(Duration(days: i));
    final b = pickRecipe(breakfasts, all, i);
    final l = pickRecipe(lunches, all, i + 1);
    final d = pickRecipe(dinners, all, i + 2);
    return DayPlan(
      date: DateTime(date.year, date.month, date.day),
      slots: [
        MealSlot(mealType: 'BREAKFAST', recipeId: b.id, recipeName: b.name),
        MealSlot(mealType: 'LUNCH',     recipeId: l.id, recipeName: l.name),
        MealSlot(mealType: 'DINNER',    recipeId: d.id, recipeName: d.name),
      ],
    );
  });

  return MealPlan(days: days, generatedAt: DateTime.now());
}
