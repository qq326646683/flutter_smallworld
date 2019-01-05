import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_smallworld/widget/index.dart';
import 'package:flutter_smallworld/common/dao/TaskhallDao.dart';
import 'package:flutter_smallworld/common/redux/index.dart';
import 'package:flutter_smallworld/common/config/Config.dart';

class TaskhallPage extends StatefulWidget {
  static final String sName = "taskhall";

  @override
  _TaskhallPageState createState() => _TaskhallPageState();
}

class _TaskhallPageState extends State<TaskhallPage>
    with
        SMListState<TaskhallPage>,
        AutomaticKeepAliveClientMixin<TaskhallPage>,
        WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    debugPrint("========");
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    debugPrint("====dispose====");
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }



  @override
  bool get wantKeepAlive => true;

  @override
  bool get isRefreshFirst => false;

  @override
  bool get needHeader => false;

  @override
  Future<Null> handleRefresh() async {
    if (isLoading) {
      return null;
    }
    isLoading = true;
    page = 1;

    var res = await TaskhallDao.getTaskhallInfo(
        StoreProvider.of<MainStore>(context),
        page: this.page);
    setState(() {
      pullLoadWidgetControl.needLoadMore =
          (res != null && res.length == Config.PAGE_SIZE);
    });
    isLoading = false;
    return null;
  }

  @override
  Future<Null> onLoadMore() async {
    if (isLoading) {
      return null;
    }
    isLoading = true;
    page++;
    var res = await TaskhallDao.getTaskhallInfo(_getStore(), page: this.page);
    setState(() {
      pullLoadWidgetControl.needLoadMore = (res != null);
    });
    isLoading = false;
    return null;
  }

  @override
  requestRefresh() {}

  @override
  requestLoadMore() {}

  @override
  void didChangeDependencies() {
    pullLoadWidgetControl.dataList =
        _getStore().state.taskHallStore.taskhallList;
    if (pullLoadWidgetControl.dataList.length == 0) {
      showRefreshLoading();
    }
    super.didChangeDependencies();
  }

  _renderItem(index) {
    return Container(
      height: 100,
      decoration: BoxDecoration(border: Border.all()),
      child: Text('index:' + index.toString()),
    );
  }


  @override
  Future<bool> didPopRoute() {
    // TODO: implement didPopRoute
    debugPrint("pop----");
    return super.didPopRoute();
  }

  @override
  Future<bool> didPushRoute(String route) {
    // TODO: implement didPushRoute
    debugPrint("push----");
    return super.didPushRoute(route);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('=====555=======');
    print(state);
  }

  Store<MainStore> _getStore() {
    return StoreProvider.of<MainStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return new StoreBuilder<MainStore>(builder: (context, store) {
      return Scaffold(
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
    });
  }
}
