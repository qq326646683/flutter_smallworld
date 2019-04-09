import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_smallworld/widget/index.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/widget/index.dart';
import 'package:flutter_smallworld/page/index.dart';
import 'package:flutter_smallworld/common/redux/index.dart';
import 'main_page_style.dart';

class MainPage extends StatefulWidget {
  static final String sName = "main";

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<TabItem> _tabItems = new List<TabItem>();
  int index = 0;

  @override
  void initState() {
    super.initState();
    NavigatorUtils.getInstance().setContext(context);
  }

  List<TabItem> _renderTabItems() {
    return [
      new TabItem(
          icon: _renderImgBtn(SMIcons.TAB_HOME, false),
          activeIcon: _renderImgBtn(SMIcons.TAB_HOME_ACTIVE, false)),
      new TabItem(
          icon: _renderImgBtn(SMIcons.TAB_CHAT, true),
          activeIcon: _renderImgBtn(SMIcons.TAB_CHAT_ACTIVE, true)),
      new TabItem(
          icon: SMTabBarBtnWidget(
            icon: Image.asset(SMIcons.TAB_CLUB_ACTIVE,
                width: MainPageStyle.tabBarClubWidth,
                height: MainPageStyle.tabBarClubWidth),
            showDot: true,
          ),
          activeIcon: SMTabBarBtnWidget(
            icon: Image.asset(SMIcons.TAB_CLUB_ACTIVE,
                width: MainPageStyle.tabBarClubWidth,
                height: MainPageStyle.tabBarClubWidth),
            showDot: true,
          )),
      new TabItem(
          icon: _renderImgBtn(SMIcons.TAB_DISCOVER, true),
          activeIcon: _renderImgBtn(SMIcons.TAB_DISCOVER_ACTIVE, true)),
      new TabItem(
          icon: _renderImgBtn(SMIcons.TAB_PROFILE, false),
          activeIcon: _renderImgBtn(SMIcons.TAB_PROFILE_ACTIVE, false)),
    ];
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
    _tabItems = _renderTabItems();
    print('render:MainPage');
    return StoreBuilder<MainStore>(builder: (context, store) {
      return PageView(
        controller: StoreProvider.of<MainStore>(context).state.homeTabStore.homeToDetailController,
        physics: this.index == 0 ? AlwaysScrollableScrollPhysics() : NeverScrollableScrollPhysics(),
        children: <Widget>[
          SMTabBarWidget(
            type: SMTabBarWidget.BOTTOM_TAB,
            tabViews: <Widget>[
              HomePage(),
              ChatPage(),
              ClubPage(),
              DiscoverPage(),
              ProfilePage()
            ],
            tabItems: _tabItems,
            backgroundColor: SMColors.primaryDarkValue,
            onPageChanged: (int index) {
              this.setState(() {
                this.index = index;
              });
            },
          ),
          Container(
            color: Colors.pink,
            child: FlatButton(onPressed: () {
            }, child: Text('clickclickclick')),
          ),
        ],
      );
    });
  }
}

