import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_smallworld/common/redux/MainStore.dart';

class MainPage extends StatefulWidget {
  static final String sName = "main";

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<MainStore>(builder: (context, store) {
      return Container(
        child: Text(
          store.state.userStore.userInfo != null ? store.state.userStore.userInfo.toJson().toString() : 'deffff',
          style: TextStyle(color: Colors.white, fontSize: 14.0),
        ),
      );
    });
  }
}
