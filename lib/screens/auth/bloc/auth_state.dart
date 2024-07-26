part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthLogIn extends AuthState {}

final class AuthSignUp extends AuthState {}

final class UserHasLoggedIn extends AuthState {}

final class LoadingAuth extends AuthState {}

final class AuthLoggedOut extends AuthState {}

final class ErrorState extends AuthState {
  final String err;
  ErrorState({required this.err});
}
