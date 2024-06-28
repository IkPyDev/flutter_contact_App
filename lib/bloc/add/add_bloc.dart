import 'package:bloc/bloc.dart';
import 'package:contact_app_gita/data/db_manager.dart';
import 'package:contact_app_gita/data/hive/hive_manager.dart';
import 'package:meta/meta.dart';

import '../../data/Firebase_manager.dart';

part 'add_event.dart';
part 'add_state.dart';

class AddBloc extends Bloc<AddEvent, AddState> {
  AddBloc() : super(AddInitial()) {
    on<AddEvent>((event, emit) async {
      if (event is AddContact) {
        emit(AddLoading());
        try {
          await HiveManager().addContact(event.name, event.phone);
          emit(AddSuccess());
        } catch (e) {
          emit(AddError(e.toString()));
        }
      }
    });
  }
}
