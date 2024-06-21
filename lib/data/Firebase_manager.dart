import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'UserData.dart';


class FirebaseManager {
  static var collectionName = "contacts";

  final CollectionReference _contactsCollection =
  FirebaseFirestore.instance.collection(FirebaseManager.collectionName);

  Future<void> addContact(String name, String phone) {
    return _contactsCollection.add({'name': name, 'phone': phone});
  }

  Future<void> deleteContact(String id) {
    return _contactsCollection.doc(id).delete();
  }

  Stream<List<UserData>> getContacts() {
    return _contactsCollection.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) {
          if (doc.exists) {
            // print(doc.data());
            return UserData.fromJson(
                doc.id, doc.data() as Map<String, dynamic>);
          } else {
            throw Exception('Document does not exist');
          }
        }).toList());
  }

  Future<void> updateContact(String id, String name, String phone) {
    return _contactsCollection.doc(id).update({'name': name, 'phone': phone});
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();

  }

  Future<void> clearAll() async {
    // Clear all implementation
    // FirebaseFirestore.instance.co
    _contactsCollection.get().then((snapshot) {
      for (DocumentSnapshot contact in snapshot.docs) {
        contact.reference.delete();
      }
    });
    await FirebaseAuth.instance.signOut();
  }
}

