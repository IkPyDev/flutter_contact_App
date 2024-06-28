
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

import 'contact_model_hive.dart';

class HiveManager {
  final String contactBoxName = 'contactsBox';
  final String userBoxName = 'userBox';

  //
  // Future<void> initHive() async {
  //   final appDocumentDir = await getApplicationDocumentsDirectory();
  //    Hive.init(appDocumentDir.path);
  //   Hive.registerAdapter(ContactModelHiveAdapter());
  //   await Hive.openBox<ContactModelHive>(contactBoxName);
  //   await Hive.openBox(userBoxName);
  // }

  Future<void> addContact(String name,String number) async {
    final box = Hive.box<ContactModelHive>(contactBoxName);
    var con = ContactModelHive(name: name, number:number,id:DateTime.now().millisecondsSinceEpoch & 0xFFFFFFFF,  );
     box.add(con);
  }

  Future<void> updateContact(ContactModelHive contact) async {
    final box = Hive.box<ContactModelHive>(contactBoxName);
    final Map<dynamic, ContactModelHive> deliveriesMap = box.toMap();
    dynamic desiredKey;
    deliveriesMap.forEach((key, value){
      if (value.id == contact.id) {
        desiredKey = key;
      }
    });
     box.put(desiredKey, contact);
  }

  Future<void> deleteContact(int id) async {
    // print("delete $id  bolmoqda "  );
    final box = Hive.box<ContactModelHive>(contactBoxName);
    // print("all keys ${box.keys.toList()} " );
    //  box.delete(box.values.firstWhere((element) => element.id == id));
    final Map<dynamic, ContactModelHive> contacts = box.toMap();
    dynamic desiredKey;
    contacts.forEach((key, value){
      if (value.id == id) {
        desiredKey = key;
      }
    });
    box.delete(desiredKey);
  }

  Future<List<ContactModelHive>> getContacts() async {
    final box = Hive.box<ContactModelHive>(contactBoxName);
    print(box.keys.toList());
    var a = List.generate(box.length, (index) => box.getAt(index)!);
    print("get contacts $a");
    return a;
  }

  Future<void> close() async {
     Hive.close();
  }

  Future<void> deleteAll() async {
    final boxContact = Hive.box<ContactModelHive>(contactBoxName);
    final boxUser = Hive.box(userBoxName);
    boxContact.deleteFromDisk();
     boxUser.deleteFromDisk();

  }

  Future<bool> isLogin() async {
    final box = Hive.box(userBoxName);
    return box.isNotEmpty;
  }

  Future<bool> addUser(String login, String password) async {
    final box = Hive.box(userBoxName);
    var a =  box.add({'login': login, 'password': password});
    // print("add $a user $login $password");
    return true;
  }

  Future<void> deleteAllUser() async {
    final box = Hive.box(userBoxName);
     box.clear();
  }

  Future<bool> checkUser(String login, String password) async {
    final box = Hive.box(userBoxName);
    var map = box.values.where((element) => element['login'] == login && element['password'] == password);
    print("check user $map"  );
    return map.isNotEmpty;
  }


}