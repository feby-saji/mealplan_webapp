part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class LoadingState extends HomeState {}

final class ErrorState extends HomeState {
  String err;
  ErrorState({required this.err});
}

final class UsersFamilysDetailsLoaded extends HomeState {
  final List<UserModel> users;
  final List<FamilyModel> familys;

  UsersFamilysDetailsLoaded({required this.users, required this.familys});
}
