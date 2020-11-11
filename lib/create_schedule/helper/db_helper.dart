import 'package:sqflite/sqflite.dart';

import '../models/schedule_model.dart';

class DBHelper {
  static Database _db;
  static final int _version = 1;
  static final String _tableName = 'notes';

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'note.db';
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version) {
          return db.execute(
            "CREATE TABLE $_tableName(id INTEGER PRIMARY KEY,isScheduled int , title STRING,momentOfReminding STRING,focusNode STRING,dateTime STRING, note TEXT)",
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insert(ScheduleModel scheduleModel) async {
    return await _db.insert(_tableName, scheduleModel.toJson());
  }

  static Future<int> delete(ScheduleModel scheduleModel) async {
    return await _db.delete(_tableName, where: 'id = ?', whereArgs: [scheduleModel.id]);
  }

  static Future<int> update(ScheduleModel scheduleModel) async {
    return await _db.update(_tableName,scheduleModel.toJson(),where: 'id = ?',whereArgs: [scheduleModel.title]);
  }


  static Future<List<Map<String, dynamic>>> query() async {
    return _db.query(_tableName);
  }

}