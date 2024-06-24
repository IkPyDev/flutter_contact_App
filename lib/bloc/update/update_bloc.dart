import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/Firebase_manager.dart';

part 'update_event.dart';
part 'update_state.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  UpdateBloc() : super(UpdateInitial()) {
    on<UpdateEvent>((event, emit) async {
      if (event is UpdateButtonPressed) {
        emit(UpdateLoading());
        try {
          await FirebaseManager().updateContact(event.id, event.name, event.phone);
          emit(UpdateSuccess());
        } catch (e) {
          emit(UpdateError(e.toString()));
        }
      }
    });
  }
}
