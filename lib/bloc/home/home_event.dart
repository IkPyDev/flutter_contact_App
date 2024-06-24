part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}


class DeleteButtonPressed extends HomeEvent {
  final String id;

  DeleteButtonPressed( this.id);
}

class LoadContacts extends HomeEvent {}
class LogOut extends HomeEvent {}
class UnRegister extends HomeEvent {}

