part of 'add_bloc.dart';

@immutable
sealed class AddEvent {}


class AddContact extends AddEvent {
  final String name;
  final String phone;

  AddContact(this.name, this.phone);
}

