import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/localization/zh.dart';
import 'package:flutter_smallworld/common/localization/en.dart';

///自定义多语言实现
class MyLocalization {
  static Iterable<Locale> getSupportedLanguages() {
    return <Locale>[Locale('en'), Locale('zh')];
  }

  final Locale locale;
  Zh _strValues;

  MyLocalization(this.locale) {
    switch (locale.languageCode) {
      case 'en':
        _strValues = new En();
        break;
      default:
        _strValues = new Zh();
        break;
    }
  }

  Zh get strValues {
    return _strValues;
  }

  ///通过 Localizations 加载当前的 OALocalizations
  ///获取对应的 StringBase
  static MyLocalization of(BuildContext context) {
    return Localizations.of(context, MyLocalization);
  }
}
