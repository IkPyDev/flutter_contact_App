import 'package:bloc/bloc.dart';
import 'package:contact_app_gita/data/db_manager.dart';
import 'package:contact_app_gita/data/hive/hive_manager.dart';
import 'package:meta/meta.dart';

import '../../data/Firebase_manager.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
        // await FirebaseManager().login(event.email, event.password);
        emit(LoginLoading());
        bool isLogin = await HiveManager().checkUser(event.email, event.password);

        if(isLogin) {
          // print("login success $isLogin");
          await Future.delayed( Duration(seconds: 3));
          emit(LoginSuccess());
        } else {
          await Future.delayed( Duration(seconds: 4));
          // print("login error $isLogin");
          emit(LoginError('Invalid email or password'));
        }
        });
  }
}
