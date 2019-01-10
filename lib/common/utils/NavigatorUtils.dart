import 'package:flutter/material.dart';

class NavigatorUtils extends NavigatorObserver{
  static NavigatorUtils navigatorUtils;
  BuildContext mContext;
  static List<Route> _mRoutes;


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


  @override
  void didPush(Route route, Route previousRoute) {
    // 当调用Navigator.push时回调
    super.didPush(route, previousRoute);
    //可通过route.settings获取路由相关内容
    //route.currentResult获取返回内容
    //....等等
    print('^^^^routePush');
    print(route.settings.name);
    if (_mRoutes == null) {
      _mRoutes = new List<Route>();
    }
    _mRoutes.add(route);
    routeObserver();
  }

  @override
  void didReplace({Route newRoute, Route oldRoute}) {
    super.didReplace();
    print('^^^^routeReplace');
    print(newRoute.settings.name);
    _mRoutes.remove(oldRoute);
    _mRoutes.add(newRoute);
    routeObserver();
  }

  @override
  void didPop(Route route, Route previousRoute) {
    super.didPop(route, previousRoute);
    print('^^^^routePop');
    print(route.settings.name);
    _mRoutes.remove(route);
    routeObserver();
  }

  void routeObserver() {
    print('&&routes&&');
    print(_mRoutes);
    print('&&currentRoute&&');
    print(_mRoutes[_mRoutes.length - 1]);
  }
}
