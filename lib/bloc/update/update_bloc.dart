import 'package:bloc/bloc.dart';
import 'package:contact_app_gita/data/contact_model.dart';
import 'package:contact_app_gita/data/db_manager.dart';
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
          var contact = ContactModel(id: event.id,name: event.name, number: event.phone);
          await DbManager().updateContact(contact);
          emit(UpdateSuccess());
        } catch (e) {
          emit(UpdateError(e.toString()));
        }
      }
    });
  }
}
