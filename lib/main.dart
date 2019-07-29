import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_smallworld/common/config/config.dart';
import 'package:flutter_smallworld/common/dao/index.dart';
import 'package:flutter_smallworld/common/event/event.dart';
import 'package:flutter_smallworld/common/localization/my_localization.dart';
import 'package:flutter_smallworld/common/localization/my_localizations_delegate.dart';
import 'package:flutter_smallworld/common/model/index.dart';
import 'package:flutter_smallworld/common/net/index.dart';
import 'package:flutter_smallworld/widget/index.dart';
import 'package:oktoast/oktoast.dart';
import 'package:redux/redux.dart';
import 'package:flutter_smallworld/page/index.dart';
import 'package:flutter_smallworld/common/redux/index.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'common/redux/config_state.dart';

void main() {
  runApp(FlutterReduxApp());
}

class FlutterReduxApp extends StatefulWidget {
  @override
  _FlutterReduxAppState createState() => _FlutterReduxAppState();
}

class _FlutterReduxAppState extends State<FlutterReduxApp> {
  StreamSubscription stream;
  BuildContext mContext;

  final store = new Store<MainStore>(appReducer,
      initialState: MainStore(
        userState: UserState.initStore(),
        taskHallState: TaskhallState.initStore(),
        smPhotoState: SmPhotoState.initStore(),
        homeTabState: HomeTabState.initStore(),
        configState: ConfigState.initStore(),
      ));

  @override
  void initState() {
    super.initState();
    stream =
        EventBusHelper.getEventTypeStream<HttpErrorEvent>().listen((event) {
      errorHandleFunction(event.code, event.message, event.noTip);
    });
    EntityCreatorFactory.registerAllCreator();
  }

  @override
  void dispose() {
    super.dispose();
    if (stream != null) {
      stream.cancel();
      stream = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: OKToast(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorObservers: [
              NavigatorUtils.getInstance(),
            ],

            ///多语言实现代理
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              MyLocalizationsDelegate.delegate,
            ],
            supportedLocales: MyLocalization.getSupportedLanguages(),
            routes: NavigatorUtils.configRoutes,
            builder: (BuildContext context, Widget child) {
              mContext = context;
              return Listener(
                onPointerDown: (PointerDownEvent event) {
                  DragDebugWidget.myController.lookAt(event.position);
                },
                child: Container(
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      child,
                      DragDebugWidget(),
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }

  errorHandleFunction(int code, message, noTip) {
    switch (code) {
      /////////////一定提示//////////////
      case 401:
        ToastUtil.showRed(CommonUtils.getLocaleStr(mContext).network_error_401);
        UserDao.clearAll();
        NavigatorUtils.getInstance()
            .pushNamedAndRemoveUntil(mContext, LoginPage.sName);
        break;
      case Code.STATUS_CODE_UPLOAD_FAILURE:
        //上传失败
        ToastUtil.showRed(
            CommonUtils.getLocaleStr(mContext).network_upload_error);
        break;

      ////////////////线上不提示Dio报错///////////
      case Code.STATUS_CODE_DIO_ERROR:
        if (Config.API_SETTING != APIType.PRODUCTION)
          ToastUtil.showRed(
              CommonUtils.getLocaleStr(mContext).network_error_dio);
        break;

      /////////////按需提示//////////////
      case Code.STATUS_CODE_NETWORK_ERROR:
        if (!noTip)
          ToastUtil.showRed(CommonUtils.getLocaleStr(mContext).network_error);
        break;
      case 403:
        if (!noTip)
          ToastUtil.showRed(
              CommonUtils.getLocaleStr(mContext).network_error_403);
        break;
      case 404:
        if (!noTip)
          ToastUtil.showRed(
              CommonUtils.getLocaleStr(mContext).network_error_404);
        break;
      case Code.STATUS_CODE_NETWORK_TIMEOUT:
        //超时
        if (!noTip)
          ToastUtil.showRed(
              CommonUtils.getLocaleStr(mContext).network_error_timeout);
        break;
      default:
        if (!noTip)
          ToastUtil.showRed(
              CommonUtils.getLocaleStr(mContext).network_error_unknown +
                  " " +
                  message);
        break;
    }
  }
}
