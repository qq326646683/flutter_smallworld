import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/config/config.dart';
import 'package:flutter_smallworld/common/service/index.dart';

class LogUtil {
  static const paddingSize = 15;
  static const firstLineSymbol = "-->";

  static i(String tagName, [Object o, Object o1, Object o2, Object o3]) {
    StringBuffer buffer = StringBuffer();

    buffer.write(firstLineSymbol);

    for (int i = 0; i < paddingSize - tagName.length; i++) {
      buffer.write(" ");
    }

    buffer.write(tagName);

    [o, o1, o2, o3].forEach((o) {
      if (o != null) buffer.write(" - ${o.toString()}");
    });


    debugPrint(buffer.toString());
    if (Config.DEBUG_ENTER) {
      PrintLogService.getInstance().saveToSP(buffer.toString());
    }
  }
}