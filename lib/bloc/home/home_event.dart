part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}


class DeleteButtonPressed extends HomeEvent {
  final int id;

  DeleteButtonPressed( this.id);
}

class LoadContactsEvent extends HomeEvent {}
class LogOut extends HomeEvent {}
class UnRegister extends HomeEvent {}

