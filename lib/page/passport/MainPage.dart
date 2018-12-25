import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_smallworld/common/redux/MainStore.dart';
import 'package:flutter_smallworld/widget/index.dart';

class MainPage extends StatefulWidget {
  static final String sName = "main";

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Icon> icons = [
    Icon(Icons.aspect_ratio),
    Icon(Icons.headset_mic),
    Icon(Icons.offline_bolt),
  ];
  List<Widget> _tabItems = new List<Widget>();

  @override
  void initState() {
    super.initState();
    for (Icon icon in icons) {
      _tabItems.add(
          new Tab(
            child: icon,
          )
      );
    }
  }

/*  Container(
  child: Text(
  store.state.userStore.userInfo != null ? store.state.userStore.userInfo.toJson().toString() : 'deffff',
  style: TextStyle(color: Colors.white, fontSize: 14.0),
  ),
  )*/

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<MainStore>(builder: (context, store) {
      return SMTabBarWidget(SMTabBarWidget.BOTTOM_TAB, [
        Container(color: Colors.pink),
        Container(color: Colors.blue),
        Container(color: Colors.green),
      ], _tabItems);
    });
  }
}
