import 'package:flutter/material.dart';

class NavigatorUtils {
  static NavigatorUtils navigatorUtils;
  BuildContext mContext;

  static NavigatorUtils getInstance() {
    if (navigatorUtils == null) {
      navigatorUtils = new NavigatorUtils();
    }

    return navigatorUtils;
  }

  setContext(BuildContext context) {
    mContext = context;
  }

  BuildContext getContext() {
    return mContext;
  }

  // replace 页面
  pushReplacementNamed(String routeName) {
    Navigator.pushReplacementNamed(mContext, routeName);
  }

  // push 页面
  pushNamed(String routeName) {
    Navigator.pushNamed(mContext, routeName);
  }
}