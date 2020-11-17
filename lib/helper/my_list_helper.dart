import 'package:remender_new/home/model/list_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class MLDBHelper {
  static Database _db;
  static final int _version = 1;
  static final String _tableName = '_listDB';

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String path = await getDatabasesPath();
      String path1 = p.join(path,'_listDB.db');
      _db = await openDatabase(
        path1,
        version: _version,
        onCreate: (db, version) {
          return db.execute(
            "CREATE TABLE $_tableName(id INTEGER PRIMARY KEY,color STRING,title STRING,count INTERGER)",
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insert(ListModel listModel) async {
    return await _db.insert(_tableName, listModel.toMap());
  }

  static Future<int> delete(ListModel listModel) async {
    return await _db
        .delete(_tableName, where: 'id = ?', whereArgs: [listModel.id]);
  }

  static Future<int> update(ListModel listModel) async {
    return await _db.update(_tableName, listModel.toMap(),
        where: 'id = ?', whereArgs: [listModel.id]);
  }

  static Future<List<Map<String, dynamic>>> query() async {
    return _db.query(_tableName);
  }
}
