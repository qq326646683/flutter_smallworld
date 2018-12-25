import 'package:flutter/material.dart';

class SMTabBarWidget extends StatefulWidget {
  ///底部模式type
  static const int BOTTOM_TAB = 1;

  ///顶部模式type
  static const int TOP_TAB = 2;

  int _type;

  List<Widget> _tabViews;

  List<Widget> _tabItems;


  SMTabBarWidget(this._type, this._tabViews,
      this._tabItems) : super() {
  }


  @override
  _SMTabBarWidgetState createState() => new _SMTabBarWidgetState();
}

class _SMTabBarWidgetState extends State<SMTabBarWidget>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
    new TabController(length: widget._tabItems.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget._type == SMTabBarWidget.BOTTOM_TAB) {
      return Scaffold(
        body: TabBarView(
            controller: _tabController, children: widget._tabViews),
        bottomNavigationBar: Material(
          color: Color(0x995566ee),
          child: TabBar(
            controller: _tabController,
            tabs: widget._tabItems,
            indicator: BoxDecoration()),
        ),
      );
    }
  }
}

