/// Authentication status.
enum AuthStatus { loading, authenticated, unauthenticated }

/// Immutable auth state.
class AuthState {
  const AuthState._({
    required this.status,
    this.token,
    this.email,
    this.name,
    this.error,
  });

  final AuthStatus status;
  final String? token;
  final String? email;
  final String? name;
  final String? error;

  bool get isLoading => status == AuthStatus.loading;
  bool get isAuthenticated => status == AuthStatus.authenticated;

  factory AuthState.loading() =>
      const AuthState._(status: AuthStatus.loading);

  factory AuthState.authenticated({
    required String token,
    String? email,
    String? name,
  }) =>
      AuthState._(
        status: AuthStatus.authenticated,
        token: token,
        email: email,
        name: name,
      );

  factory AuthState.unauthenticated({String? error}) =>
      AuthState._(status: AuthStatus.unauthenticated, error: error);
}
