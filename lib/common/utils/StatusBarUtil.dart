import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_smallworld/page/index.dart';


class StatusBarUtil {
  static List<String> lightRouteNameList = [
    SplashPage.sName,
    LoginPage.sName,
    MainPage.sName
  ];
  static List

  static String currentColor = 'light';
  static setupStatusBar(Route currentRoute) {
    TaskhallPage.sName
  }

  /**
   * 黑底白字
   */
  static setLight() {
//    FlutterStatusbarcolor.setStatusBarColor(Color(SMColors.black));
    if (currentColor != 'light') {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    }
  }

  /**
   * 白底黑字
   */
  static setDart() {
//    FlutterStatusbarcolor.setStatusBarColor(Color(SMColors.white));
    if (currentColor != 'dart') {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    }
  }

}
