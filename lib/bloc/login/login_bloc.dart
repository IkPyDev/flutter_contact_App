import 'package:bloc/bloc.dart';
import 'package:contact_app_gita/data/db_manager.dart';
import 'package:meta/meta.dart';

import '../../data/Firebase_manager.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
        // await FirebaseManager().login(event.email, event.password);
        bool isLogin = await DbManager().checkUser(event.email, event.password);
        print("login $isLogin");
        if(isLogin) {
          print("login success $isLogin");
          emit(LoginSuccess());
        } else {
          print("login error $isLogin");
          emit(LoginError('Invalid email or password'));
        }
        });
  }
}
