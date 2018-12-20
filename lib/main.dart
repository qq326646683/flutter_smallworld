import 'package:flutter/material.dart';
import 'package:flutter_smallworld/page/passport/SplashPage.dart';
import 'package:flutter_smallworld/page/passport/LoginPage.dart';
import 'package:flutter_smallworld/page/passport/MainPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        SplashPage.sName: (context) => SplashPage(),
        LoginPage.sName: (context) => LoginPage(),
        MainPage.sName: (context) => MainPage(),
      },
    );
  }
}
