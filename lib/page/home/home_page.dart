import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import '../../widget/index.dart';
import 'home_tab/home_tab.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;
  int currentIndex;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: [
              HomeTab(tab: HomeTabType.tab_near,),
              HomeTab(tab: HomeTabType.tab_recent,),
              HomeTab(tab: HomeTabType.tab_new,),
            ]
        ),
        Positioned(
          top: ScreenUtil.getInstance().statusBarHeight,
          child: SMTabBarWidget(
            width: _Style.tabbarContainW,
            controller: _tabController,
            tabs: [
              _buildHeaderItem(CommonUtils.getLocaleStr(context).home_page_header_title1, 0),
              _buildHeaderItem(CommonUtils.getLocaleStr(context).home_page_header_title2, 1),
              _buildHeaderItem(CommonUtils.getLocaleStr(context).home_page_header_title3, 2),
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
    );
  }

  Widget _buildHeaderItem(String title, index) {
    return Padding(
      padding: EdgeInsets.only(
        top: ScreenUtil.getInstance().statusBarHeight,
        bottom: _Style.tabbarBottom,
      ),
      child: Text(
        title,
        style: currentIndex == index ? SMTxtStyle.normalTextGolden : SMTxtStyle.normalTextWhite,
      ),
    );
  }

}

class _Style {
  static double tabbarContainW = ScreenUtil.getInstance().getWidth(220);
  static double tabbarBottom = ScreenUtil.getInstance().getWidth(5);
}
