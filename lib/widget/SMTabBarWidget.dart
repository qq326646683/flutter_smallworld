import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/utils/index.dart';

class SMTabBarWidget extends StatefulWidget {
  ///底部模式type
  static const int BOTTOM_TAB = 1;

  ///顶部模式type
  static const int TOP_TAB = 2;

  int type;

  List<Widget> tabViews;

  List<TabItem> tabItems;

  ValueChanged<int> onPageChanged;

  Color backgroundColor;

  SMTabBarWidget(
      {Key key, this.type, this.tabViews, this.tabItems, this.onPageChanged, this.backgroundColor})
      : super(key: key);

  @override
  _SMTabBarWidgetState createState() => new _SMTabBarWidgetState();
}

class _SMTabBarWidgetState extends State<SMTabBarWidget>
    with TickerProviderStateMixin {
  PageController _pageController;
  List<BottomNavigationBarItem> _bottomNavigationBarItems =
  new List<BottomNavigationBarItem>();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = new PageController(initialPage: 0);

    for (int i = 0; i < widget.tabItems.length; i++) {
      TabItem currentTabItem = widget.tabItems[i];
      _bottomNavigationBarItems.add(BottomNavigationBarItem(
          icon: currentTabItem.icon,
          activeIcon: currentTabItem.activeIcon,
          title: Container(),
          backgroundColor: Color(0x00000000)));
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == SMTabBarWidget.BOTTOM_TAB) {
      return Material(
        child: Stack(
          children: <Widget>[
            PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: widget.tabViews,
              onPageChanged: (index) {
                this.setState(() {
                  _currentIndex = index;
                });
                widget.onPageChanged?.call(index);
              },
            ),
            Positioned(
              bottom: 0,
              child: Container(
                color: SMColors.opacity60Cover,
                width: ScreenUtil.getInstance().screenWidth,
                child: BottomNavigationBar(
                  items: _bottomNavigationBarItems,
                  currentIndex: _currentIndex,
                  type: BottomNavigationBarType.fixed,
                  onTap: (int index) {
                    this.setState(() {
                      _currentIndex = index;
                    });
                    _pageController.animateToPage(_currentIndex,
                        duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
                  },
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}

class TabItem {
  Widget icon;
  Widget activeIcon;
  String title;

  TabItem({
    this.title,
    this.icon,
    this.activeIcon,
  });
}
