part of 'update_bloc.dart';

@immutable
sealed class UpdateEvent {}

class UpdateButtonPressed extends UpdateEvent {
  final String id;
  final String name;
  final String phone;

  UpdateButtonPressed( this.id, this.name, this.phone);
}
