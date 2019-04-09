import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_smallworld/common/config/config.dart';
import 'package:flutter_smallworld/common/dao/index.dart';
import 'package:flutter_smallworld/common/model/index.dart';
import 'package:flutter_smallworld/common/redux/index.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/page/discover/taskhall_item.dart';
import 'package:flutter_smallworld/page/home/home_tab_item/home_tab_item.dart';
import 'package:flutter_smallworld/widget/index.dart';
import 'package:redux/redux.dart';

enum HomeTabType {
  tab_near,
  tab_recent,
  tab_new,
}

class HomeTab extends StatefulWidget {
  final HomeTabType tab;

  HomeTab({@required this.tab});

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab>
    with SMListState<HomeTab>, AutomaticKeepAliveClientMixin {
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

    var res = await HomeTabDao.getHomeTabList(_getStore(), widget.tab, page: this.page);
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
    var res = await HomeTabDao.getHomeTabList(_getStore(), widget.tab, page: this.page);
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
        _getStore().state.homeTabStore.homeTabDataMap[widget.tab].homeTabList;
    if (pullLoadWidgetControl.dataList.length == 0) {
      showRefreshLoading();
    }
    super.didChangeDependencies();
  }

  _renderItem(HomeTabModel item) {
    return HomeTabItem(homeTabModel: item);
  }

  Store<MainStore> _getStore() {
    return StoreProvider.of<MainStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return SMPullLoadWidget(
      new PageController(),
      pullLoadWidgetControl,
          (BuildContext context, int index) =>
          _renderItem(pullLoadWidgetControl.dataList[index]),
      handleRefresh,
      onLoadMore,
      refreshKey: refreshIndicatorKey,
    );
  }

}
