part of 'register_bloc.dart';

abstract class RegisterEvent {}

class RegisterButtonPressed extends RegisterEvent {
  final String email;
  final String password;

  RegisterButtonPressed(this.email, this.password);
}
