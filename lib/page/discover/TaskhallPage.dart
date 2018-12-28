import 'package:flutter/material.dart';
import 'package:flutter_smallworld/widget/index.dart';

class TaskhallPage extends StatefulWidget {
  static final String sName = "taskhall";

  @override
  _TaskhallPageState createState() => _TaskhallPageState();
}

class _TaskhallPageState extends State<TaskhallPage>
    with
        SMListState<TaskhallPage>,
        AutomaticKeepAliveClientMixin<TaskhallPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  bool get isRefreshFirst => true;

  @override
  bool get needHeader => false;

  @override
  requestRefresh() {
    return askData();
  }

  @override
  requestLoadMore() {
    return askData();
  }

  askData() {
//    Future.delayed(Duration(seconds: 2), () {
//      var data = [];
//      for (int i = 0; i < 10; i++) {
//        data.add(i);
//      }
//      return data;
//    });
  }

  _renderItem(index) {
    return Container(
      child: Text('index:' + index.toString()),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return new Scaffold(
      backgroundColor: Colors.brown,
      appBar: new AppBar(
        backgroundColor: Colors.pinkAccent,
        leading: new Container(),
        elevation: 0.0,
      ),
      body: WillPopScope(
        onWillPop: () {
//          return _dialogExitApp(context);
        },
        child: SMPullLoadWidget(
          pullLoadWidgetControl,
              (BuildContext context, int index) => _renderItem(index),
          handleRefresh,
          onLoadMore,
          refreshKey: refreshIndicatorKey,
        ),
      ),
    );

  }

}
