import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter_smallworld/page/passport/SplashPage.dart';
import 'package:flutter_smallworld/page/passport/LoginPage.dart';
import 'package:flutter_smallworld/page/passport/MainPage.dart';
import 'package:flutter_smallworld/common/redux/MainStore.dart';
import 'package:flutter_smallworld/common/redux/UserStore.dart';

void main() {
  runApp(FlutterReduxApp());
}

class FlutterReduxApp extends StatelessWidget {
  final store = new Store<MainStore>(
      appReducer,
      initialState: MainStore(
        userStore: UserStore.initStore(),
      )
  );


  FlutterReduxApp({Key key}) : super(key: key);

//
  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
        store: store,
        child: new StoreBuilder<MainStore>(builder: (context, store) {
          return MaterialApp(
            routes: {
              SplashPage.sName: (context) => SplashPage(),
              LoginPage.sName: (context) => LoginPage(),
              MainPage.sName: (context) => MainPage(),
            },

          );
        })

    );
  }

}


