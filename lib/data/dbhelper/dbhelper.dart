import 'package:flutter/foundation.dart';
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

    try {
      db.insert(tableName, data, conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (err) {
      print("Data Insert Error: ${err.toString()}");
    }
  }

  static Future<List<Map<String, dynamic>>> getData(String tablename) async {
    final db = await DBHelper.database();
    try {
      return db.query(tablename);
    } catch (err) {}
  }

  static Future<void> updateData(
      String tablename,
      Map<String, dynamic> updateData,
      String? fieldName,
      dynamic fieldVal) async {
    final db = await DBHelper.database();
    try {
      (fieldName == null || fieldVal == null)
          ? db.update(tablename, updateData)
          : db.update(tablename, updateData,
              where: '$fieldName=?', whereArgs: [fieldVal]);
    } catch (err) {
      print("Update Data Error: ${err.toString()}");
    }
  }

  static Future<void> deleteData(String tableName, String id) async {
    final db = await DBHelper.database();
    try {
      await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
    } catch (err) {
      print("Delete Datafield Error: ${err.toString()}");
    }
  }

  static Future<void> delete() async {
    try {
      final dbPath = await sql.getDatabasesPath();
      sql.deleteDatabase('$dbPath/expense.db');
    } catch (err) {
      print("Delete DataBase Error: ${err.toString()}");
    }
  }
}
