import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/storage/auth_storage.dart';
import '../data/auth_repository.dart';
import '../domain/auth_state.dart';

/// ChangeNotifier used as a listenable for GoRouter refresh.
class AuthRouterNotifier extends ChangeNotifier {
  AuthRouterNotifier(this._ref) {
    _ref.listen<AuthState>(authProvider, (_, __) => notifyListeners());
  }
  final Ref _ref;
}

final authRouterNotifierProvider =
    ChangeNotifierProvider<AuthRouterNotifier>((ref) {
  return AuthRouterNotifier(ref);
});

/// Auth state notifier.
class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(this._storage, this._repository)
      : super(AuthState.loading()) {
    _init();
  }

  final AuthStorage _storage;
  final AuthRepository _repository;

  Future<void> _init() async {
    final token = _storage.getToken();
    if (token != null && token.isNotEmpty) {
      state = AuthState.authenticated(
        token: token,
        email: _storage.getUserEmail(),
        name: _storage.getUserName(),
      );
    } else {
      state = AuthState.unauthenticated();
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = AuthState.loading();
    try {
      final data =
          await _repository.login(email: email, password: password);
      final token = data['accessToken'] as String;
      final user = data['user'] as Map<String, dynamic>?;
      await _storage.saveToken(token);
      await _storage.saveUser(
        email: user?['email'] as String? ?? email,
        name: user?['name'] as String?,
      );
      state = AuthState.authenticated(
        token: token,
        email: user?['email'] as String? ?? email,
        name: user?['name'] as String?,
      );
    } catch (e) {
      state = AuthState.unauthenticated(error: _friendlyError(e));
    }
  }

  Future<void> register({
    required String email,
    required String password,
    String? name,
  }) async {
    state = AuthState.loading();
    try {
      final data = await _repository.register(
        email: email,
        password: password,
        name: name,
      );
      final token = data['accessToken'] as String;
      final user = data['user'] as Map<String, dynamic>?;
      await _storage.saveToken(token);
      await _storage.saveUser(
        email: user?['email'] as String? ?? email,
        name: user?['name'] as String? ?? name,
      );
      state = AuthState.authenticated(
        token: token,
        email: user?['email'] as String? ?? email,
        name: user?['name'] as String? ?? name,
      );
    } catch (e) {
      state = AuthState.unauthenticated(error: _friendlyError(e));
    }
  }

  Future<void> logout() async {
    await _storage.clearToken();
    state = AuthState.unauthenticated();
  }

  String _friendlyError(Object e) {
    final msg = e.toString();
    if (msg.contains('401') || msg.contains('Invalid')) {
      return 'Invalid email or password.';
    }
    if (msg.contains('409') || msg.contains('already')) {
      return 'Email already registered.';
    }
    if (msg.contains('SocketException') || msg.contains('Connection')) {
      return 'Cannot reach server. Check your connection.';
    }
    return 'Something went wrong. Please try again.';
  }
}

final authProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    ref.watch(authStorageProvider),
    ref.watch(authRepositoryProvider),
  );
});
