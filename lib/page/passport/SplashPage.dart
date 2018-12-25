import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/page/index.dart';

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies');
    SMSize.initScreenWidth(context);
    SMSize.initStatusBarHeight(context);


    Future.delayed(Duration(seconds: 2), () {
      NavigatorUtils.pushReplacementNamed(context, LoginPage.sName);
    });
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
              width: SMSize.suit(156.0),
              height: SMSize.suit(70.0),
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
