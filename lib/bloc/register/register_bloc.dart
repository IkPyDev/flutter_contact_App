import 'package:bloc/bloc.dart';
import 'package:contact_app_gita/data/db_manager.dart';
import 'package:meta/meta.dart';

import '../../data/Firebase_manager.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterButtonPressed>((event, emit) async {


      bool isLogins =  await DbManager().addUser(event.email, event.password);
      if(isLogins) {
        print("login success $isLogins");
        emit(RegisterSuccess());
      } else {
        print("login error $isLogins");

        emit(RegisterError("Error"));
      }
      // try {
      //   await FirebaseManager().register(event.email, event.password);
      //   emit(RegisterSuccess());
      // } catch (e) {
      //   emit(RegisterError(e.toString()));
      // }
        });
  }
}
