part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}


final class HomeSuccess extends HomeState {
  final List<UserData> contacts;

  HomeSuccess(this.contacts);
}


final class DeleteSuccess extends HomeState {}

final class HomeError extends HomeState {
  final String error;

  HomeError(this.error);
}

final class LogOutState extends HomeState {}
final class UnRegisterState extends HomeState {}
