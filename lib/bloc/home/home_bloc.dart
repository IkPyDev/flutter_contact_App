import 'package:bloc/bloc.dart';
import 'package:contact_app_gita/data/UserData.dart';
import 'package:meta/meta.dart';

import '../../data/Firebase_manager.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {

      emit(HomeLoading());
      try {
        final contacts = await FirebaseManager().getContacts().first;
        emit(HomeSuccess(contacts));
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    });

    on<LoadContacts>((event, emit) async {
      emit(HomeLoading());
      try {
        final contacts = await FirebaseManager().getContacts().first;
        emit(HomeSuccess(contacts));
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    });

    on<DeleteButtonPressed>((event, emit) async {
      print(" name delete ${event.id}");
      try {
        print(" name delete ${event.id}");
        await FirebaseManager().deleteContact(event.id);
        emit(DeleteSuccess());
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    });

    on<LogOut>((event, emit) async {

      try {
        await FirebaseManager().logout();
        emit(LogOutState());
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    });

    on<UnRegister>((event, emit) async {
      emit(UnRegisterState());
      try {
        await FirebaseManager().clearAll();
        emit(UnRegisterState());
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    });



  }
}
