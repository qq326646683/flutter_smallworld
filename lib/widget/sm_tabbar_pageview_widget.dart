import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/utils/index.dart';

class SMTabBarPageViewWidget extends StatefulWidget {
  ///底部模式type
  static const int BOTTOM_TAB = 1;

  static const int TOP_TAB = 2;

  int type;

  List<Widget> tabViews;

  List<TabItem> tabItems;

  List<Widget> topTabItems;

  ValueChanged<int> onPageChanged;

  Color backgroundColor;

  TabController tabController;

  RenderTabBarHeader headerWidget;

  final ScrollPhysics physics;

  SMTabBarPageViewWidget({
    Key key,
    this.type,
    this.tabViews,
    this.tabItems,
    this.topTabItems,
    this.onPageChanged,
    this.backgroundColor,
    this.tabController,
    this.headerWidget,
    this.physics,
  }) : super(key: key);

  @override
  _SMTabBarPageViewWidgetState createState() =>
      new _SMTabBarPageViewWidgetState();
}

class _SMTabBarPageViewWidgetState extends State<SMTabBarPageViewWidget>
    with TickerProviderStateMixin {
  List<BottomNavigationBarItem> _bottomNavigationBarItems =
  new List<BottomNavigationBarItem>();
  int _currentIndex = 0;
  TabController _tabController;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    if (widget.type == SMTabBarPageViewWidget.BOTTOM_TAB) {
      _pageController = new PageController(initialPage: 0);
      for (int i = 0; i < widget.tabItems.length; i++) {
        TabItem currentTabItem = widget.tabItems[i];
        _bottomNavigationBarItems.add(BottomNavigationBarItem(
            icon: currentTabItem.icon,
            activeIcon: currentTabItem.activeIcon,
            title: Container(),
            backgroundColor: Color(0x00000000)));
      }
    } else {
      _tabController = widget.tabController ??
          new TabController(vsync: this, length: widget.tabViews.length);
      _tabController.addListener(() {
        CommonUtils.throttle(() {
          widget.onPageChanged?.call(_tabController.index);
        });
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    if (_tabController != null) _tabController.dispose();
    if (_pageController != null) _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == SMTabBarPageViewWidget.BOTTOM_TAB) {
      return Material(
        child: Stack(
          children: <Widget>[
            PageView(
              physics: widget.physics,
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
                    _pageController.jumpToPage(_currentIndex);
                  },
                ),
              ),
            ),
          ],
        ),
      );
    } else if (widget.type == SMTabBarPageViewWidget.TOP_TAB) {
      return Material(
        color: SMColors.white,
        child: Column(
          children: <Widget>[
            (widget.headerWidget != null) ? widget.headerWidget(
              tabController: _tabController,
              tabs: widget.topTabItems,
            ) : SizedBox(),
            Expanded(
              child: TabBarView(
                physics: widget.physics,
                controller: _tabController,
                children: widget.tabViews,
              ),
            )
          ],
        ),
      );
    }
  }
}

typedef RenderTabBarHeader = Widget Function({TabController tabController, List<
    Widget> tabs});


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
