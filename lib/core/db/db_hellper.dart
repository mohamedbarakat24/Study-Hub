// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:developer';

import 'package:sqflite/sqflite.dart';

import '../Model/task_model.dart';

class DbHelper {
  static Database? _db;
  static const int _version = 1;
  static const _tableName = 'tasks';

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    } else {
      try {
        String _path = '${await getDatabasesPath()}task.db';
        _db = await openDatabase(_path, version: _version,
            onCreate: (Database db, int version) async {
          await db.execute(
              'CREATE TABLE $_tableName (id INTEGER PRIMARY KEY AUTOINCREMENT,title STRING, note TEXT , date STRING, startTime STRING, endTime STRING, remind INTEGER, repeat STRING, color INTEGER, isCompleted INTEGER )');
        });
      } catch (e) {
        log(e.toString());
      }
    }
  }

  static Future<int> insert(Task task) async {
    log('inserting to data base');
    return await _db!.insert(_tableName, task.toMap());
  }

  static Future<int> delete(Task task) async {
    log('delete to data base');
    return await _db!.delete(_tableName, where: 'id = ?', whereArgs: [task.id]);
  }

  static Future<int> deleteAll() async {
    log('delete all data base');
    return await _db!.delete(
      _tableName,
    );
  }

  static Future<List<Map<String, dynamic>>> query() async {
    log('query to data base');
    return await _db!.query(_tableName);
  }

  static Future<int> update(int taskId) async {
    log('update to data base');
    return await _db!.rawUpdate('''
UPDATE $_tableName 
SET isCompleted = ?
WHERE id = ?
''', [1, taskId]);
  }
}
