import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_smallworld/page/index.dart';
import 'package:flutter_smallworld/common/redux/MainStore.dart';
import 'package:flutter_smallworld/common/redux/UserRedux.dart';
import 'package:flutter_smallworld/common/redux/TaskhallRedux.dart';
import 'package:flutter_smallworld/common/net/Code.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/common/net/HttpManager.dart';

void main() {
  runApp(FlutterReduxApp());
}

class FlutterReduxApp extends StatefulWidget {
  @override
  _FlutterReduxAppState createState() => _FlutterReduxAppState();
}

class _FlutterReduxAppState extends State<FlutterReduxApp> {
  StreamSubscription stream;

  final store = new Store<MainStore>(appReducer,
      initialState: MainStore(
        userStore: UserStore.initStore(),
        taskHallStore: TaskhallStore.initStore(),
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

  errorHandleFunction(int code, message) {
    switch (code) {
      case Code.NETWORK_ERROR:
        ToastUtil.showRed('网络错误');
        break;
      case 401:
        ToastUtil.showRed('[401错误可能: 未授权 \\ 授权登录失败 \\ 登录过期]');
        HttpManager.clearToken();
        NavigatorUtils.getInstance().pushReplacementNamed(LoginPage.sName);
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


  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
        store: store,
        child: MaterialApp(
          routes: {
            SplashPage.sName: (context) => SplashPage(),
            LoginPage.sName: (context) => LoginPage(),
            MainPage.sName: (context) => MainPage(),
            TaskhallPage.sName: (context) => TaskhallPage(),
          },
        )
    );
  }
}
