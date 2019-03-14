import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'home_tab/HomeTab.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(text: '附近'),
    Tab(text: '活跃活跃活跃'),
    Tab(text: '新人新人'),
  ];
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
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
      children: <Widget>[
        TabBarView(
            controller: _tabController,
            children: [
              HomeTab(tab: TabType.tab_near,),
              HomeTab(tab: TabType.tab_recent,),
              HomeTab(tab: TabType.tab_new,),
            ]
        ),
        TabBar(
          controller: _tabController,
          tabs: myTabs,
          indicatorSize: TabBarIndicatorSize.label,
          labelPadding: EdgeInsets.only(top: 30),
          labelColor: SMColors.lightGolden,
          labelStyle: SMTxtStyle.smallTextLightGolden,
          unselectedLabelColor: SMColors.miWhite,
          indicatorColor: SMColors.lightGolden,
        )
      ],
    );
  }

}
