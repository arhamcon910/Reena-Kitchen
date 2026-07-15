import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>(
  (_) => throw UnimplementedError('Override in ProviderScope'),
);

class AuthStorage {
  const AuthStorage(this.prefs);
  final SharedPreferences prefs;

  Future<bool> saveToken(String token) =>
      prefs.setString(AppConstants.keyAccessToken, token);
  String? getToken() => prefs.getString(AppConstants.keyAccessToken);
  Future<bool> clearToken() => prefs.remove(AppConstants.keyAccessToken);

  Future<bool> saveUser({required String email, String? name}) async {
    await prefs.setString(AppConstants.keyUserEmail, email);
    if (name != null) await prefs.setString(AppConstants.keyUserName, name);
    return true;
  }

  String? getUserEmail() => prefs.getString(AppConstants.keyUserEmail);
  String? getUserName()  => prefs.getString(AppConstants.keyUserName);

  bool get isOnboardingDone =>
      prefs.getBool(AppConstants.keyOnboardingDone) ?? false;
  Future<bool> setOnboardingDone() =>
      prefs.setBool(AppConstants.keyOnboardingDone, true);
}

final authStorageProvider = Provider<AuthStorage>((ref) {
  final p = ref.watch(sharedPreferencesProvider);
  return AuthStorage(p);
});
