import 'dart:convert';

import 'package:flutter_smallworld/common/config/config.dart';
import 'package:flutter_smallworld/common/utils/index.dart';

class PrintLogService {
  static PrintLogService _PrintLogService;

  static PrintLogService getInstance() {
    if (_PrintLogService == null) {
      _PrintLogService = new PrintLogService();
    }
    return _PrintLogService;
  }

  saveToSP(dynamic logStr) async{
    String printLogListTxt = await StorageManager.getInstance().get(Config.PRINTLOG_KEY);
    if (printLogListTxt.isNotEmpty) {
      List<dynamic> printLogList = json.decode(printLogListTxt);
      printLogList.add(logStr);
      StorageManager.getInstance().save(Config.PRINTLOG_KEY, json.encode(printLogList));
    } else {
      StorageManager.getInstance().save(Config.PRINTLOG_KEY, json.encode([logStr]));
    }

  }

  Future<List<dynamic>> getFromSP() async {
    String printLogListTxt = await StorageManager.getInstance().get(Config.PRINTLOG_KEY);
    List<dynamic> printLogList = [];
    if (printLogListTxt.isNotEmpty) {
      printLogList = json.decode(printLogListTxt);
    }
    return printLogList;
  }



}