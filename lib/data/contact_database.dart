import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'contact.dart';

class ContactDatabase {
  ContactDatabase._();

  static const _table = 'contacts';

  /// Opened once, cached, and reused by every call.
  static Future<Database>? _db;
  static Future<Database> get database => _db ??= _open();

  static Future<Database> _open() async {
    final path = join(await getDatabasesPath(), 'pocket_notes.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) => db.execute('''
        CREATE TABLE $_table (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          phone TEXT NOT NULL
        )
      '''),
    );
  }

  static Future<List<Contact>> all() async {
    final db = await database;
    final rows = await db.query(_table, orderBy: 'name COLLATE NOCASE');
    return rows.map(Contact.fromMap).toList();
  }

  static Future<int> insert(Contact contact) async {
    final db = await database;
    return db.insert(_table, contact.toMap());
  }

  static Future<int> update(Contact contact) async {
    final db = await database;
    return db.update(
      _table,
      contact.toMap(),
      where: 'id = ?',
      whereArgs: [contact.id],
    );
  }

  static Future<int> delete(int id) async {
    final db = await database;
    return db.delete(_table, where: 'id = ?', whereArgs: [id]);
  }
}
