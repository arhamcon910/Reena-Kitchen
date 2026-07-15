import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/network/api_client.dart';
import '../domain/shopping_models.dart';

class ShoppingRepository {
  ShoppingRepository()
      : _client = ApiClient(baseUrl: AppConstants.shoppingServiceUrl);
  final ApiClient _client;

  Future<List<ShoppingList>> getLists(String householdId) async {
    final res = await _client.get('/shopping/$householdId/lists');
    return (res as List<dynamic>)
        .map((e) => ShoppingList.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<ShoppingList> createList(String householdId, String name) async {
    final res = await _client.post(
        '/shopping/$householdId/lists', {'name': name});
    return ShoppingList.fromJson(res);
  }

  Future<Map<String, dynamic>> generateList(
    String householdId, {
    required String name,
    required List<String> ingredients,
    List<String> pantryItems = const [],
  }) async {
    final res = await _client.post(
      '/shopping/$householdId/lists/generate',
      {
        'name': name,
        'ingredients': ingredients,
        'pantryItems': pantryItems,
      },
    );
    return res;
  }

  Future<ShoppingList> getList(String householdId, String listId) async {
    final res =
        await _client.get('/shopping/$householdId/lists/$listId');
    return ShoppingList.fromJson(res as Map<String, dynamic>);
  }

  Future<ShoppingItem> addItem(
    String householdId,
    String listId,
    Map<String, dynamic> data,
  ) async {
    final res = await _client.post(
        '/shopping/$householdId/lists/$listId/items', data);
    return ShoppingItem.fromJson(res);
  }

  Future<ShoppingItem> toggleItem(
    String householdId,
    String listId,
    String itemId,
    bool isPurchased,
  ) async {
    final res = await _client.patch(
      '/shopping/$householdId/lists/$listId/items/$itemId',
      {'isPurchased': isPurchased},
    );
    return ShoppingItem.fromJson(res);
  }

  Future<void> removeItem(
      String householdId, String listId, String itemId) async {
    await _client
        .delete('/shopping/$householdId/lists/$listId/items/$itemId');
  }

  Future<ShoppingList> completeList(
      String householdId, String listId) async {
    final res = await _client.patch(
        '/shopping/$householdId/lists/$listId/complete', {});
    return ShoppingList.fromJson(res);
  }

  Future<void> deleteList(String householdId, String listId) async {
    await _client.delete('/shopping/$householdId/lists/$listId');
  }
}

final shoppingRepositoryProvider =
    Provider<ShoppingRepository>((_) => ShoppingRepository());
