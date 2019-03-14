import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/utils/index.dart';

enum TabType {
  tab_near,
  tab_recent,
  tab_new,
}

class HomeTab extends StatefulWidget {
  final TabType tab;

  HomeTab({@required this.tab});

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
//      debugPrint(_scrollController.position.pixels.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTapDown: (TapDownDetails details) {
          debugPrint(details.globalPosition.toString());
        },
        onTapUp: (TapUpDetails details) {
          debugPrint(details.globalPosition.toString());
        },
        child: ListView.builder(
          controller: _scrollController,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: ScreenUtil
                  .getInstance()
                  .screenHeight,
              child: Text('跳转到 $index'),
            );
          },
        )
    );
  }
//  child: GestureDetector(
//  onTap: () {
//  _scrollController.jumpTo(index * ScreenUtil
//      .getInstance()
//      .screenHeight);
//  },
//  child: Text('跳转到 $index'),
//  ),


  @override
  bool get wantKeepAlive => true;
}
