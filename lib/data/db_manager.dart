import 'package:contact_app_gita/data/contact_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbManager {
  final int version = 1;
  final String dbName = 'contacts.db';
  final String table = "contact";
  final String user = "user";

  Future<Database> _getDb() async {
    return await openDatabase(join(await getDatabasesPath(), dbName),
      version: version,
      singleInstance: true,
      onCreate: (db, version) {
        db.execute("CREATE TABLE $table(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT NOT NULL, number TEXT NOT NULL)");
        db.execute("CREATE TABLE $user(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, login TEXT NOT NULL, password TEXT NOT NULL)");
      },
    );
  }

  Future<void> addContact(String name, String number) async {
    final db = await _getDb();
    await db.insert(table, {'name': name, 'number': number});
  }

  Future<void> updateContact(ContactModel contact) async {
    final db = await _getDb();
    await db.update(table, contact.toJson(), where: 'id = ?', whereArgs: [contact.id]);
  }

  Future<void> deleteContact(int id) async {
    final db = await _getDb();
    await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<ContactModel>> getContacts() async {
    final db = await _getDb();
    final List<Map<String, dynamic>> maps = await db.query(table);
    return List.generate(maps.length, (index) => ContactModel.fromJson(maps[index]));
  }

  Future<void> close() async {
    final db = await _getDb();
    await db.close();
  }

  Future<void> deleteAll() async {
    final db = await _getDb();
    await db.delete(table);
  }

  Future<bool> isLogin() async {
    final db = await _getDb();
    final List<Map<String, dynamic>> map = await db.query(table);
    return map.isNotEmpty;
  }

  Future<bool> addUser(String login, String password) async {
    final db = await _getDb();
    var a = await db.insert(user, {'login': login, 'password': password});
    print("add $a user $login $password");
    return a > 0;
  }

  Future<bool> checkUser(String login, String password) async {
    final db = await _getDb();
    final List<Map<String, dynamic>> map = await db.query(user, where: 'login = ? AND password = ?', whereArgs: [login, password]);
    print("check user $map"  );
    return map.isNotEmpty;
  }
}
