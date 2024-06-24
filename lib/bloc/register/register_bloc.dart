import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/Firebase_manager.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) async {
      if (event is RegisterButtonPressed) {
        emit(RegisterLoading());
        try {
          await FirebaseManager().register(event.email, event.password);
          emit(RegisterSuccess());
        } catch (e) {
          emit(RegisterError(e.toString()));
        }
      }
    });
  }
}
