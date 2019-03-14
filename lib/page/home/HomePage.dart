import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/utils/index.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(text: '附近'),
    Tab(text: '活跃'),
    Tab(text: '新人'),
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
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        TabBarView(
            controller: _tabController,
            children: [
              Container(color: Colors.pinkAccent,),
              Container(color: Colors.brown,),
              Container(color: Colors.purple,)
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
