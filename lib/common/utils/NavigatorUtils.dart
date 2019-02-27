import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_smallworld/page/index.dart';

class NavigatorUtils extends NavigatorObserver {
  /*配置routes*/
  static Map<String, WidgetBuilder> configRoutes = {
//    SplashPage.sName: (context) => SplashPage(),
    LoginPage.sName: (context) => LoginPage(),
    MainPage.sName: (context) => MainPage(),
    TaskhallPage.sName: (context) => TaskhallPage(),
    SPHomePage.sName: (context) => SPHomePage(),

  };
  static NavigatorUtils navigatorUtils;
  BuildContext mContext;
  static List<Route> _mRoutes;

  setContext(BuildContext context) {
    mContext = context;
  }

  static NavigatorUtils getInstance() {
    if (navigatorUtils == null) {
      navigatorUtils = new NavigatorUtils();
    }

    return navigatorUtils;
  }

  BuildContext getContext() {
    return mContext;
  }

  // replace 页面
  pushReplacementNamed(String routeName) {
    Navigator.pushReplacementNamed(mContext, routeName);
  }

  // push 页面
  pushNamed(String routeName, [WidgetBuilder builder]) {
    Navigator.push(
        mContext,
        CupertinoPageRoute(
          builder: builder ?? configRoutes[routeName],
          settings: RouteSettings(name: routeName),
        ));
  }

  // pop 页面
  pop() {
    Navigator.pop(mContext);
  }

  @override
  void didPush(Route route, Route previousRoute) {
    // 当调用Navigator.push时回调
    super.didPush(route, previousRoute);
    //可通过route.settings获取路由相关内容
    //route.currentResult获取返回内容
    //....等等
    if (_mRoutes == null) {
      _mRoutes = new List<Route>();
    }
    if(route is CupertinoPageRoute || route is MaterialPageRoute) {
      print('^^^^routePush');
      print(route.settings.name);
      _mRoutes.add(route);
      routeObserver();
    }
  }

  @override
  void didReplace({Route newRoute, Route oldRoute}) {
    super.didReplace();
    if(newRoute is CupertinoPageRoute || newRoute is MaterialPageRoute) {
      print('^^^^routeReplace');
      print(newRoute.settings.name);
      _mRoutes.remove(oldRoute);
      _mRoutes.add(newRoute);
      routeObserver();
    }
  }

  @override
  void didPop(Route route, Route previousRoute) {
    super.didPop(route, previousRoute);
    if(route is CupertinoPageRoute || route is MaterialPageRoute) {
      print('^^^^routePop');
      print(route.settings.name);
      _mRoutes.remove(route);
      routeObserver();
    }
  }

  void routeObserver() {
    print('&&routes&&');
    print(_mRoutes);
    print('&&currentRoute&&');
    print(_mRoutes[_mRoutes.length - 1]);
    StatusBarUtil.setupStatusBar(_mRoutes[_mRoutes.length - 1]);
  }
}
