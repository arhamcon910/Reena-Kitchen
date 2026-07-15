import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/network/api_client.dart';
import '../domain/recipe.dart';

class RecipeRepository {
  RecipeRepository()
      : _client = ApiClient(baseUrl: AppConstants.recipeServiceUrl);
  final ApiClient _client;

  Future<List<Recipe>> getAll({String? category, String? q}) async {
    final params = <String, String>{};
    if (category != null && category != 'ALL') params['category'] = category;
    if (q != null && q.isNotEmpty) params['q'] = q;
    final query =
        params.entries.map((e) => '${e.key}=${e.value}').join('&');
    final path = query.isEmpty ? '/recipes' : '/recipes?$query';
    final res = await _client.get(path);
    return (res as List<dynamic>)
        .map((e) => Recipe.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<Recipe> getById(String id) async {
    final res = await _client.get('/recipes/$id');
    return Recipe.fromJson(res as Map<String, dynamic>);
  }
}

final recipeRepositoryProvider =
    Provider<RecipeRepository>((_) => RecipeRepository());
