part of 'update_bloc.dart';

@immutable
sealed class UpdateState {}

final class UpdateInitial extends UpdateState {


}

final class UpdateLoading extends UpdateState {}

final class UpdateSuccess extends UpdateState {}

final class UpdateError extends UpdateState {
  final String error;

  UpdateError(this.error);
}
