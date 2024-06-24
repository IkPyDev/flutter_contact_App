part of 'add_bloc.dart';

sealed class AddState {}

final class AddInitial extends AddState {}

final class AddLoading extends AddState {}

final class AddSuccess extends AddState {}
final class AddError extends AddState {
  final String error;

  AddError(this.error);
}
