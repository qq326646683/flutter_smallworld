import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_smallworld/common/redux/MainStore.dart';
import 'package:flutter_smallworld/widget/index.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/widget/index.dart';
import 'MainPageStyle.dart';

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
      _tabItems.add(new Tab(
        child: icon,
      ));
    }
  }

  Widget _renderImgBtn(String name, bool showDot) {
    return SMTabBarBtnWidget(
      icon: Image.asset(name,
          width: MainPageStyle.tabBarBtnWidth,
          height: MainPageStyle.tabBarBtnWidth),
      showDot: showDot,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<MainStore>(builder: (context, store) {
      return SMTabBarWidget(
        type: SMTabBarWidget.BOTTOM_TAB,
        tabViews: <Widget>[
          Container(color: Colors.pink),
          Container(color: Colors.blue),
          Container(color: Colors.yellow),
          Container(color: Colors.deepOrange),
          Container(
            color: Colors.green,
            child: Text(
              store.state.userStore.userInfo != null
                  ? store.state.userStore.userInfo.toJson().toString()
                  : 'deffff',
              style: TextStyle(color: Colors.white, fontSize: 14.0),
            ),
          ),
        ],
        tabItems: [
          new TabItem(
              icon: _renderImgBtn(SMIcons.TAB_HOME, false),
              activeIcon: _renderImgBtn(SMIcons.TAB_HOME_ACTIVE, false)),
          new TabItem(
              icon: _renderImgBtn(SMIcons.TAB_CHAT, true),
              activeIcon: _renderImgBtn(SMIcons.TAB_CHAT_ACTIVE, true)),
          new TabItem(
              icon: _renderImgBtn(SMIcons.TAB_CLUB_ACTIVE, true),
              activeIcon: _renderImgBtn(SMIcons.TAB_CLUB_ACTIVE, true)),
          new TabItem(
              icon: _renderImgBtn(SMIcons.TAB_DISCOVER, true),
              activeIcon: _renderImgBtn(SMIcons.TAB_DISCOVER_ACTIVE, true)),
          new TabItem(
              icon: _renderImgBtn(SMIcons.TAB_PROFILE, false),
              activeIcon: _renderImgBtn(SMIcons.TAB_PROFILE_ACTIVE, false)),
        ],
        backgroundColor: Color(SMColors.primaryDarkValue),
        onPageChanged: (int index) {
          print('currentIndex::' + index.toString());
        },
      );
    });
  }
}
