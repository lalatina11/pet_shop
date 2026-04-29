sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthLoggedIn extends AuthState {}

final class AuthError extends AuthState {
  String message;
  AuthError(this.message);
}
