import 'package:flutter/material.dart';
import 'package:flutter_smallworld/widget/index.dart';
import 'package:flutter_smallworld/common/dao/TaskhallDao.dart';

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
  bool get isRefreshFirst => false;

  @override
  bool get needHeader => false;

  @override
  requestRefresh() async{
    await TaskhallDao.getTaskhallInfo(page: this.page);
    return null; //await askData();
  }

  @override
  requestLoadMore() async{
    return null; // await askData();
  }

  askData() {
    return Future.delayed(Duration(seconds: 2), () {
      var data = [];
      if (page <= 3) {
        for (int i = 0; i < 10; i++) {
          data.add(i);
        }
      } else {
        for (int i = 0; i < 5; i++) {
          data.add(i);
        }
      }

      return data;
    });
  }

  _renderItem(index) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        border: Border.all()
      ),
      child: Text('index:' + index.toString()),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return new Scaffold(
      backgroundColor: Colors.brown,
      appBar: null,
      body: SMPullLoadWidget(
        pullLoadWidgetControl,
            (BuildContext context, int index) => _renderItem(index),
            handleRefresh,
            onLoadMore,
        refreshKey: refreshIndicatorKey,
      ),
    );
  }

}
