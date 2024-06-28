import 'package:bloc/bloc.dart';
import 'package:contact_app_gita/data/hive/contact_model_hive.dart';
import 'package:contact_app_gita/data/hive/hive_manager.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      emit(HomeLoading());
      try {
        final contacts = await HiveManager().getContacts();
        emit(HomeSuccess(contacts));
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    });

    on<LoadContactsEvent>((event, emit) async {
      emit(HomeLoading());
      try {
        print('call load contacts event in bloc');
        final contacts = await HiveManager().getContacts();
        emit(HomeSuccess(contacts));
        print('emit success in bloc');
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    });

    on<DeleteButtonPressed>((event, emit) async {
      print(" name delete ${event.id}");
      try {
        print(" name delete ${event.id}");
        await HiveManager().deleteContact(event.id);
        emit(DeleteSuccess());
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    });

    on<LogOut>((event, emit) async {
      try {
        emit(LogOutState());
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    });

    on<UnRegister>((event, emit) async {
      emit(UnRegisterState());
      try {
        await HiveManager().deleteAll();
        emit(UnRegisterState());
      } catch (e) {
        emit(HomeError(e.toString()));
      }
    });
  }
}
