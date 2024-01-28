import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

//import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static const String tableName = "giftMemo_table";

  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();

    return sql.openDatabase(
      path.join(dbPath, 'giftmemo.db'),
      version: 1,
      onCreate: (db, version) => db.execute(
          'CREATE TABLE $tableName(id Text PRIMARY KEY, Name Text, giftAmount INTEGER, moneyAmount REAL, gender Text, date Text)'),
    );
  }

  static Future<void> insert(
      String tableName, Map<String, dynamic> data) async {
    final db = await DBHelper.database();

    db.insert(tableName, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String tablename) async {
    final db = await DBHelper.database();

    return db.query(tablename);
  }

  static Future<void> updateData(
      String tablename,
      Map<String, dynamic> updateData,
      String? fieldName,
      dynamic fieldVal) async {
    final db = await DBHelper.database();
    (fieldName == null || fieldVal == null)
        ? db.update(tablename, updateData)
        : db.update(tablename, updateData,
            where: '$fieldName=?', whereArgs: [fieldVal]);
  }

  static Future<void> deleteData(String tableName, String id) async {
    final db = await DBHelper.database();
    try {
      await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
    } catch (err) {}
  }

  static Future<void> delete() async {
    final dbPath = await sql.getDatabasesPath();
    sql.deleteDatabase('$dbPath/expense.db');
  }
}
