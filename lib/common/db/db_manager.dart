import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_smallworld/common/dao/index.dart';
import 'package:flutter_smallworld/common/model/index.dart';
import 'package:flutter_smallworld/common/redux/index.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_smallworld/common/config/config.dart';

class DbManager {
  static final String sName = "DbManager";

  static const _VERSION = 1;

  static Database _database;

  static initDb() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String databasesPath = appDocDir.path + '/file/db/';
    String databaseName = Config.DB_NAME;
    //创建文件夹
    await new Directory(databasesPath).create(recursive: true);

    // 数据库名
    var res = await UserDao.getUserInfoLocal();
    if (res != null && res.result) {
      UserInfo userInfo = res.data;
      LogUtil.i(sName, userInfo.toJson());
      databaseName = userInfo.id + databaseName;
    }

    _database = await openDatabase(databasesPath + databaseName, version: _VERSION);

  }

  static Future<Database> getCurrentDatabase() async {
    if (_database == null) {
      await initDb();
    }
    return _database;
  }

  static isTableExist(String tableName) async {
    await getCurrentDatabase();
    var res = await _database.rawQuery("select * from Sqlite_master where type = 'table' and name = '$tableName'");
    return res != null && res.length > 0;

  }

  static close() {
    _database?.close();
    _database = null;
  }

}