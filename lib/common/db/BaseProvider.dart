import 'package:flutter_smallworld/common/db/index.dart';
import 'package:sqflite/sqflite.dart';

abstract class BaseProvider {
  bool isTableExits = false;

  tableSqlString();

  tableName();

  tableBaseString(String name, String columnId) {
    return '''
        create table $name (
        $columnId integer primary key autoincrement,
    ''';
  }

  Future<Database> getDatabase() async {
    return await open();
  }

  open() async {
    if (!isTableExits) {
      isTableExits = await DbManager.isTableExist(tableName());
      if (!isTableExits) {
        Database db = await DbManager.getCurrentDatabase();
        await db.execute(tableSqlString());
      }
    }
    return await DbManager.getCurrentDatabase();
  }
}