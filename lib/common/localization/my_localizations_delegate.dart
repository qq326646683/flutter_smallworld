import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/localization/my_localization.dart';

class MyLocalizationsDelegate extends LocalizationsDelegate<MyLocalization> {
  ///全局静态的代理
  static MyLocalizationsDelegate delegate = new MyLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<MyLocalization> load(Locale locale) {
    return SynchronousFuture<MyLocalization>(new MyLocalization(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<MyLocalization> old) {
    return false;
  }


}