import 'package:flutter/material.dart';
import 'package:flutter_bugly/flutter_bugly.dart';
import 'package:flutter_smallworld/common/model/index.dart';
import 'package:flutter_smallworld/common/net/index.dart';
import 'package:flutter_smallworld/common/redux/index.dart';
import 'package:package_info/package_info.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/page/index.dart';
import 'package:flutter_smallworld/common/config/config.dart';
import 'package:flutter_smallworld/common/dao/index.dart';
import 'package:flutter_smallworld/common/redux/main_store.dart';

class SplashPage extends StatefulWidget {
  static final String sName = "/";

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String tip = '';

  @override
  void initState() {
    super.initState();

    _init();
  }

  _init() async {
    // 文件保存路径
    if (CacheFileUtil.appDirection == null) {
      CacheFileUtil.initDirection();
    }
    // 初始化bugly
    FlutterBugly.init(
      androidAppId: "8e7f2e25d8",
      iOSAppId: "f3afb5c50c",
    );
    ///////////////  需要依赖redux store   //////////////////
    // 获取包信息
    await _setPackageInfo();
    // 初始化jpush
//    JpushUtil.init();
    String token = await StorageManager.getInstance().get(Config.TOKEN_KEY);
    if (!token.isEmpty) {
      _getUserInfo();
    } else {
      _jumpPage(LoginPage.sName);
    }
  }

  @override
  void didChangeDependencies() async{
    super.didChangeDependencies();
    // 初始化store
    CommonUtils.setStore(StoreProvider.of<MainStore>(context));
    NavigatorUtils.getInstance().setContext(context);
    // 初始化屏幕信息
    ScreenUtil.getInstance().init(context);
  }

//  _getUserInfo() async {
//    Store<MainStore> store = StoreProvider.of(context);
//    // 取网络
//    var res = await UserDao.getUserInfo(store);
//    if (res != null && res.result) {
//      NavigatorUtils.getInstance().pushReplacementNamed(context, MainPage.sName);
//    } else if (!(res.data == 'Http status error [401]')){
//      // 网络取不到，取本地
//      DataResult dataResult = await UserDao.getUserInfoLocal(store: store);
//      if (dataResult != null && dataResult.result) {
//        NavigatorUtils.getInstance().pushReplacementNamed(context, MainPage.sName);
//      } else {
//        Future.delayed(Duration(seconds: 2), () {
//          NavigatorUtils.getInstance().pushReplacementNamed(context, LoginPage.sName);
//        });
//      }
//    }
//  }
  _getUserInfo() async {
    Store<MainStore> store = CommonUtils.store;
    // 取网络
    _setTipStr("1.获取用户信息...");
    ResponseResult<UserInfo> response = await UserDao.getUserInfo(store);
    if (response.isSuccess) {
      _setTipStr("2.获取成功，初始化...");
      InitUtils.onUserLogin(response.data);
      _jumpPage(MainPage.sName);
    } else {
      // 如果token失效，交给main.dart处理
      if (response.statusCode == Code.STATUS_CODE_ERROR_401) return;
      // 网络取不到，取本地
      _setTipStr("3.获取网络失败，从本地取...");
      UserInfo userInfo = await UserDao.getUserInfoLocal(store: store);
      LogUtil.i(SplashPage.sName, 'userInfo:' + userInfo.toJson().toString());
      if (userInfo != null) {
        _setTipStr("4.获取本地成功，初始化...");
        InitUtils.onUserLogin(userInfo);
        _setTipStr("5.初始化成功");
        _jumpPage(MainPage.sName);
      } else {
        _jumpPage(LoginPage.sName);
      }
    }
  }

  _jumpPage(String pageName) async {
    _setTipStr("6.准备页面跳转");
    Future.delayed(Duration(milliseconds: 1500), () async {
      _setTipStr("7.正在跳转");
      NavigatorUtils.getInstance().pushReplacementNamed(context, pageName);
    });
  }

  _setTipStr(String tipStr) {
    LogUtil.i(SplashPage.sName, tipStr);
    this.setState(() {
      tip = tip + '\n' + tipStr;
    });
  }

  Future<void> _setPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    if (packageInfo == null) return null;
    return CommonUtils.store.dispatch(UpdatePackageInfoAction(packageInfo));
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(SMIcons.SPLASH_BG), fit: BoxFit.cover)),
      child: Padding(
        padding: EdgeInsets.only(top: 140.0),
        child: Column(
          children: <Widget>[
            Image.asset(
              SMIcons.HOT_TIP,
              width: ScreenUtil.getInstance().getWidth(156.0),
              height: ScreenUtil.getInstance().getWidth(70.0),
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
