import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/widget/index.dart';
import 'home_tab/home_tab.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  static final String sName = "_HomePageState";

  TabController _tabController;
  int currentIndex = 0;
  AnimationController animationController;
  Animation<double> animation;
  double offsetX = 0.0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  _onHorizontalDragStart(_) {
    animationController?.stop();
  }

  _onHorizontalDragUpdate(DragUpdateDetails details) {
    if (offsetX + details.delta.dx >= ScreenUtil.getInstance().screenWidth) {
      offsetX = ScreenUtil.getInstance().screenWidth;
    } else if (offsetX + details.delta.dx <=
        -ScreenUtil.getInstance().screenWidth) {
      offsetX = -ScreenUtil.getInstance().screenWidth;
      ;
    } else {
      offsetX += details.delta.dx;
    }
    this.setState(() {});
  }

  _onHorizontalDragEnd(DragEndDetails details) {
    if (offsetX.abs() < ScreenUtil.getInstance().screenWidth / 2) {
      animateTo(0.0);
    } else if (offsetX > 0) {
      animateTo(ScreenUtil.getInstance().screenWidth);
    } else {
      animateTo(-ScreenUtil.getInstance().screenWidth);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: _onHorizontalDragStart,
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      onHorizontalDragEnd: _onHorizontalDragEnd,
      child: Container(
        color: SMColors.black,
        child: Stack(
          children: <Widget>[
            _buildLeft(),
            _buildMiddle(),
            _buildRight(),
          ],
        ),
      ),
    );
  }

  _buildLeft() {
    double scale =
        0.88 + 0.12 * offsetX / ScreenUtil.getInstance().screenWidth < 0.88
            ? 0.88
            : 0.88 + 0.12 * offsetX / ScreenUtil.getInstance().screenWidth;
    return Transform.scale(
      scale: scale,
      child: Container(
        foregroundDecoration: BoxDecoration(
            color: Color.fromRGBO(
                0, 0, 0, 1 - (offsetX / ScreenUtil.getInstance().screenWidth))),
        child: Image.asset(
          SMIcons.SPLASH_BG,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  _buildRight() {
    return Transform.translate(
      offset: Offset(max(0, offsetX + ScreenUtil.getInstance().screenWidth), 0),
      child: Container(
        color:Colors.pink,
        width: ScreenUtil.getInstance().screenWidth,
        height: ScreenUtil.getInstance().screenHeight,
      ),
    );
  }

  _buildMiddle() {
    return Transform.translate(
      offset: Offset(offsetX > 0 ? offsetX : offsetX / 5, 0),
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [
                HomeTab(
                  tab: HomeTabType.tab_near,
                ),
                HomeTab(
                  tab: HomeTabType.tab_recent,
                ),
                HomeTab(
                  tab: HomeTabType.tab_new,
                ),
              ]),
          Positioned(
            top: ScreenUtil.getInstance().statusBarHeight,
            child: SMTabBarWidget(
              width: _Style.tabbarContainW,
              controller: _tabController,
              tabs: [
                Padding(
                  padding: EdgeInsets.only(
                    top: ScreenUtil.getInstance().statusBarHeight,
                    bottom: _Style.tabbarBottom,
                  ),
                  child: Text(
                    '附近',
                    style: currentIndex == 0
                        ? SMTxtStyle.normalTextGolden
                        : SMTxtStyle.normalTextWhite,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: ScreenUtil.getInstance().statusBarHeight,
                    bottom: _Style.tabbarBottom,
                  ),
                  child: Text(
                    '活跃',
                    style: currentIndex == 1
                        ? SMTxtStyle.normalTextGolden
                        : SMTxtStyle.normalTextWhite,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: ScreenUtil.getInstance().statusBarHeight,
                    bottom: _Style.tabbarBottom,
                  ),
                  child: Text(
                    '最新',
                    style: currentIndex == 2
                        ? SMTxtStyle.normalTextGolden
                        : SMTxtStyle.normalTextWhite,
                  ),
                ),
              ],
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: SMColors.lightGolden,
              onTap: (int index) {
                this.setState(() {
                  currentIndex = index;
                });
              },
            ),
          )
        ],
      ),
    );
  }

  void animateTo(double targetOffsetX) {
    animationController =
        AnimationController(duration: Duration(milliseconds: offsetX.abs() * 1000 ~/ 500), vsync: this);
    final curve = CurvedAnimation(
        parent: animationController, curve: Curves.easeOutCubic);
    animation = Tween(begin: offsetX, end: targetOffsetX).animate(curve)
      ..addListener(() {
        LogUtil.i(sName,'animation.value');
        LogUtil.i(sName,animation.value);
        setState(() {
          offsetX = animation.value;
        });
      });
    animationController.forward();
  }
}

class _Style {
  static double tabbarContainW = ScreenUtil.getInstance().getWidth(220);
  static double tabbarBottom = ScreenUtil.getInstance().getWidth(5);
}
