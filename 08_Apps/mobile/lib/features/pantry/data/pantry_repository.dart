import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/network/api_client.dart';
import '../domain/pantry_item.dart';

class PantryRepository {
  PantryRepository() : _client = ApiClient(baseUrl: AppConstants.pantryServiceUrl);
  final ApiClient _client;

  Future<List<PantryItem>> getItems(String householdId) async {
    final res = await _client.get('/pantry/$householdId/items');
    final list = res as List<dynamic>;
    return list.map((e) => PantryItem.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<PantryItem> addItem(String householdId, Map<String, dynamic> data) async {
    final res = await _client.post('/pantry/$householdId/items', data);
    return PantryItem.fromJson(res);
  }

  Future<PantryItem> updateItem(
      String householdId, String itemId, Map<String, dynamic> data) async {
    final res = await _client.patch('/pantry/$householdId/items/$itemId', data);
    return PantryItem.fromJson(res);
  }

  Future<void> deleteItem(String householdId, String itemId) async {
    await _client.delete('/pantry/$householdId/items/$itemId');
  }
}

final pantryRepositoryProvider = Provider<PantryRepository>(
  (_) => PantryRepository(),
);
