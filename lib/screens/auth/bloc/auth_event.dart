part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class SignUpEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  BuildContext context;

  SignUpEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.context,
  });
}

class LogInEvent extends AuthEvent {
  final String email;
  final String password;
  BuildContext context;

  LogInEvent({
    required this.email,
    required this.password,
    required this.context,
  });
}

class ToggleSignUpAndLogIn extends AuthEvent {
  final bool signUp;
  ToggleSignUpAndLogIn({required this.signUp});
}

class UserLogOutEvent extends AuthEvent {
  BuildContext context;
  UserLogOutEvent({required this.context});
}

class CheckUserLoggedIn extends AuthEvent {}
