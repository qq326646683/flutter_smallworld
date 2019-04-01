import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/model/index.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/page/index.dart';
import 'package:flutter_smallworld/common/config/Config.dart';
import 'package:flutter_smallworld/common/dao/index.dart';
import 'package:flutter_smallworld/common/redux/MainStore.dart';

class SplashPage extends StatefulWidget {
  static final String sName = "/";

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async{
    super.didChangeDependencies();
    NavigatorUtils.getInstance().setContext(context);

    String token = await StorageUtil.get(Config.TOKEN_KEY);
    if (token != null) {
      _getUserInfo();
    } else {
      Future.delayed(Duration(seconds: 2), () {
        NavigatorUtils.getInstance().pushReplacementNamed(context, LoginPage.sName);
      });
    }
  }

  _getUserInfo() async {
    Store<MainStore> store = StoreProvider.of(context);
    // 取网络
    var res = await UserDao.getUserInfo(store);
    if (res != null && res.result) {
      NavigatorUtils.getInstance().pushReplacementNamed(context, MainPage.sName);
    } else {
      // 网络取不到，取本地
      DataResult dataResult = await UserDao.getUserInfoLocal(store: store);
      if (dataResult != null && dataResult.result) {
        NavigatorUtils.getInstance().pushReplacementNamed(context, MainPage.sName);
      } else {
        Future.delayed(Duration(seconds: 2), () {
          NavigatorUtils.getInstance().pushReplacementNamed(context, LoginPage.sName);
        });
      }
    }
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
              width: ScreenUtil().getWidth(156.0),
              height: ScreenUtil().getWidth(70.0),
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
