import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/Firebase_manager.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginButtonPressed) {
        emit(LoginLoading());
        try {
          await FirebaseManager().login(event.email, event.password);
          emit(LoginSuccess());
        } catch (e) {
          emit(LoginError(e.toString()));
        }
      }
    });
  }
}
