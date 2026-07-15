import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';

/// Handles auth API calls.
class AuthRepository {
  const AuthRepository(this._client);
  final ApiClient _client;

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await _client.post('/auth/login', {
      'email': email,
      'password': password,
    });
    return response;
  }

  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    String? name,
  }) async {
    final response = await _client.post('/auth/register', {
      'email': email,
      'password': password,
      if (name != null && name.isNotEmpty) 'name': name,
    });
    return response;
  }

  Future<Map<String, dynamic>> getMe({required String token}) async {
    final response = await _client.get('/auth/me', token: token);
    return response as Map<String, dynamic>;
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ApiClient());
});
