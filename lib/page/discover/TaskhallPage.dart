import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_smallworld/widget/index.dart';
import 'package:flutter_smallworld/common/dao/TaskhallDao.dart';
import 'package:flutter_smallworld/common/redux/index.dart';
import 'package:flutter_smallworld/common/config/Config.dart';
import 'package:flutter_smallworld/common/model/index.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'TaskhallPageStyle.dart';
import 'TaskhallItem.dart';

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
  void initState() {
    super.initState();
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

  _renderItem(Taskhall item) {
    return TaskhallItem(taskhall: item,);
  }

  Store<MainStore> _getStore() {
    return StoreProvider.of<MainStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    StatusBarUtil.setLight();
    super.build(context);
    return Scaffold(
      appBar: null,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(SMIcons.TASKHALL_BG), fit: BoxFit.fill),
        ),
        child: Stack(
          children: <Widget>[
            /*蒙层*/
            Container(
              width: ScreenUtil().screenWidth,
              height: ScreenUtil().screenHeight,
              color: Color(SMColors.opacity75Cover),
            ),
            SMPullLoadWidget(
              pullLoadWidgetControl,
                  (BuildContext context, int index) =>
                  _renderItem(pullLoadWidgetControl.dataList[index]),
              handleRefresh,
              onLoadMore,
              refreshKey: refreshIndicatorKey,
            ),
          ],
        ),
      ),
    );
  }
}
