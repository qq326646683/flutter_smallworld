import 'dart:math' as Math;
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
  double startY;
  int startTime;
  double endY;
  int endTime;
  bool isCheck;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
//      debugPrint(_scrollController.position.pixels.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (ScrollNotification note) {
        print(note);
        switch (note.runtimeType) {
          case ScrollStartNotification:
            if ((note as ScrollStartNotification).dragDetails != null) {
              this.isCheck = true;
//              print((note as ScrollStartNotification)
//                  .dragDetails
//                  .globalPosition
//                  .dy);
              this.startY = (note as ScrollStartNotification)
                  .dragDetails
                  .globalPosition
                  .dy;
              this.startTime = DateTime.now().millisecondsSinceEpoch;
            }
            break;
          case ScrollUpdateNotification:
            if ((note as ScrollUpdateNotification).dragDetails != null) {
//              print((note as ScrollUpdateNotification)
//                  .dragDetails
//                  .globalPosition.dy);
              this.endY = (note as ScrollUpdateNotification)
                  .dragDetails
                  .globalPosition
                  .dy;
            } else {
              if (isCheck) {
                print('dragDetails:isnull:' + 'isCheck:' + isCheck.toString());
                // 滑动
                this.isCheck = false;
                autoScroll();
              }
//              print(DateTime.now().millisecondsSinceEpoch);
            }
            break;
          case ScrollEndNotification:
            if (isCheck) {
              autoScroll();
            }
            break;
        }
      },
      child: ListView.builder(
        controller: _scrollController,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(border: SMCommonStyle.borderBottom03Gray),
            height: ScreenUtil.getInstance().screenHeight,
            child: GestureDetector(
              onTap: (){
                _scrollController
                    .animateTo(2 * ScreenUtil.getInstance().screenHeight, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
              },
              child: Text('跳转到 $index'),
            ),
          );
        },
      ),
    );
  }

  autoScroll() {
    double dy = startY - endY;
    this.endTime = DateTime.now().millisecondsSinceEpoch;
    double v = dy.abs() / (this.endTime - this.startTime);

    if (dy.abs() > ScreenUtil.getInstance().screenHeight / 3 || v > 0.5) {
      print('移动');
      if (dy > 0) {
        currentIndex = currentIndex + 1;
        _scrollController
            .animateTo(currentIndex * ScreenUtil.getInstance().screenHeight, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      } else {
        currentIndex = currentIndex - 1;
        if (currentIndex < 0) {
          currentIndex = 0;
        }
        _scrollController
            .animateTo(currentIndex * ScreenUtil.getInstance().screenHeight, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    } else {
      print('归位');
      _scrollController
          .animateTo(0 * ScreenUtil.getInstance().screenHeight, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    }


  }

  @override
  bool get wantKeepAlive => true;
}
