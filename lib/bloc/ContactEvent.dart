// import 'dart:async';
// import 'package:bloc/bloc.dart';
// import '../data/Firebase_manager.dart';
// import '../data/UserData.dart';
//
// abstract class ContactEvent {}
//
// class LoadContacts extends ContactEvent {}
//
// class AddContact extends ContactEvent {
//   final String name;
//   final String phone;
//
//   AddContact(this.name, this.phone);
// }
//
// class DeleteContact extends ContactEvent {
//   final String id;
//
//   DeleteContact(this.id);
// }
//
// class UpdateContact extends ContactEvent {
//   final String id;
//   final String name;
//   final String phone;
//
//   UpdateContact(this.id, this.name, this.phone);
// }
//
// abstract class ContactState {}
//
// class ContactsLoading extends ContactState {}
//
// class ContactsLoaded extends ContactState {
//   final List<UserData> contacts;
//
//   ContactsLoaded(this.contacts);
// }
//
// class ContactsNotLoaded extends ContactState {}
//
// class ContactBloc extends Bloc<ContactEvent, ContactState> {
//   final FirebaseManager firebaseManager = FirebaseManager();
//
//   ContactBloc(super.initialState);
//
//   @override
//   ContactState get initialState => ContactsLoading();
//
//   @override
//   Stream<ContactState> mapEventToState(ContactEvent event) async* {
//     if (event is LoadContacts) {
//       try {
//         final contacts = firebaseManager.getContacts();
//         yield ContactsLoaded(contacts);
//       } catch (_) {
//         yield ContactsNotLoaded();
//       }
//     } else if (event is AddContact) {
//       await firebaseManager.addContact(event.name, event.phone);
//       final contacts = firebaseManager.getContacts();
//       yield ContactsLoaded(contacts);
//     } else if (event is DeleteContact) {
//       await firebaseManager.deleteContact(event.id);
//       final contacts = firebaseManager.getContacts();
//       yield ContactsLoaded(contacts);
//     } else if (event is UpdateContact) {
//       await firebaseManager.updateContact(event.id, event.name, event.phone);
//       final contacts = firebaseManager.getContacts();
//       yield ContactsLoaded(contacts);
//     }
//   }
// }