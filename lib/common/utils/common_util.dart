import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_smallworld/common/localization/my_localization.dart';
import 'package:flutter_smallworld/common/localization/zh.dart';
import 'package:flutter_smallworld/common/redux/index.dart';
import 'package:redux/redux.dart';

class CommonUtils {
  /// 获取当前语言的字符串对象
  static Zh getLocaleStr(BuildContext context) {
    return MyLocalization.of(context).strValues;
  }

  // getStore
  static Store<MainStore> _store;

  static Store<MainStore> get store => _store;

  static setStore(Store<MainStore> s) {
    _store = s;
  }


  // 防抖函数: eg:输入框连续输入，用户停止操作300ms才执行访问接口
  static const deFaultDurationTime = 300;
  static Timer timer;

  static antiShake(Function doSomething, {durationTime = deFaultDurationTime}) {
    timer?.cancel();
    timer = new Timer(Duration(milliseconds: durationTime), () {
      doSomething?.call();
      timer = null;
    });
  }

  // 节流函数: eg:300ms内，只会触发一次
  static int startTime = 0;

  static throttle(Function doSomething, {durationTime = deFaultDurationTime}) {
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    if (currentTime - startTime > durationTime) {
      doSomething?.call();
      startTime = DateTime.now().millisecondsSinceEpoch;
    }
  }
}
