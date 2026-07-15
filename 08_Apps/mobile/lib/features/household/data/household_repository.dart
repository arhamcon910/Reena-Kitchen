import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/network/api_client.dart';

class HouseholdRepository {
  HouseholdRepository()
      : _client = ApiClient(baseUrl: AppConstants.householdServiceUrl);
  final ApiClient _client;

  Future<Map<String, dynamic>> create({required String name}) async {
    return _client.post('/households', {
      'name': name,
      'timezone': 'Asia/Kolkata',
    });
  }

  Future<Map<String, dynamic>> findById(String id) async {
    final res = await _client.get('/households/$id');
    return res as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> addMember({
    required String householdId,
    required String name,
    String role = 'ADULT',
  }) async {
    return _client.post(
      '/households/$householdId/members',
      {'name': name, 'role': role},
    );
  }
}

final householdRepositoryProvider =
    Provider<HouseholdRepository>((_) => HouseholdRepository());
