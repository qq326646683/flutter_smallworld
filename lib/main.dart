import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_smallworld/common/dao/index.dart';
import 'package:redux/redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_smallworld/page/index.dart';
import 'package:flutter_smallworld/common/redux/index.dart';
import 'package:flutter_smallworld/common/net/code.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/common/net/http_manager.dart';

void main() {
  runApp(FlutterReduxApp());
}

class FlutterReduxApp extends StatefulWidget {
  @override
  _FlutterReduxAppState createState() => _FlutterReduxAppState();
}

class _FlutterReduxAppState extends State<FlutterReduxApp>{
  StreamSubscription stream;


  final store = new Store<MainStore>(appReducer,
      initialState: MainStore(
        userStore: UserStore.initStore(),
        taskHallStore: TaskhallStore.initStore(),
        smPhotoStore: SmPhotoStore.initStore(),
        homeTabStore: HomeTabStore.initStore(),
      ));

  @override
  void initState() {
    super.initState();
    stream = Code.eventBus.on().listen((event) {
      errorHandleFunction(event.code, event.message);
    });
  }


  @override
  void dispose() {
    super.dispose();
    if(stream != null) {
      stream.cancel();
      stream = null;
    }
  }


  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
        store: store,
        child: MaterialApp(
          navigatorObservers: [
            NavigatorUtils.getInstance(),
          ],
          routes: NavigatorUtils.configRoutes,
        )
    );
  }

  errorHandleFunction(int code, message) {
    switch (code) {
      case Code.NETWORK_ERROR:
        ToastUtil.showRed('网络错误');
        break;
      case 401:
        ToastUtil.showRed('[401错误可能: 未授权 \\ 授权登录失败 \\ 登录过期]');
        UserDao.clearAll(store);
        NavigatorUtils.getInstance().pushNamedAndRemoveUntil(NavigatorUtils.getInstance().getContext(), LoginPage.sName);
        break;
      case 403:
        ToastUtil.showRed('403权限错误');
        break;
      case 404:
        break;
      case Code.NETWORK_TIMEOUT:
        ToastUtil.showRed('404错误');
        break;
      default:
        ToastUtil.showRed('其他异常');
        break;
    }
  }

}
