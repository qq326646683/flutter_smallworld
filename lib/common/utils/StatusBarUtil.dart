import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class StatusBarUtil {

  /**
   * 黑底白字
   */
  static setLight() {
//    FlutterStatusbarcolor.setStatusBarColor(Color(SMColors.black));
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
  }

  /**
   * 白底黑字
   */
  static setDart() {
//    FlutterStatusbarcolor.setStatusBarColor(Color(SMColors.white));
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);

  }
}