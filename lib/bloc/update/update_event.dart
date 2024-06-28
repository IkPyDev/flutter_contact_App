part of 'update_bloc.dart';

@immutable
sealed class UpdateEvent {}

class UpdateButtonPressed extends UpdateEvent {
  final int id;
  final String name;
  final String phone;
  final ContactModelHive h;
  UpdateButtonPressed( this.id, this.name, this.phone , this.h);
}
