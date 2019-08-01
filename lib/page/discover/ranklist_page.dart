import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/model/test/rank_item_bean.dart';
import 'package:flutter_smallworld/common/model/test/rank_list_result.dart';
import 'package:flutter_smallworld/common/service/ranklist_service.dart';
import 'package:flutter_smallworld/page/discover/rank_item_info_page.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_smallworld/widget/index.dart';
import 'package:flutter_smallworld/common/redux/index.dart';
import 'package:flutter_smallworld/common/config/config.dart';
import 'package:flutter_smallworld/common/model/index.dart';
import 'package:flutter_smallworld/common/utils/index.dart';

class RankListPage extends StatefulWidget {
  static final String sName = "RankList";

  @override
  _RankListPageState createState() => _RankListPageState();
}

class _RankListPageState extends State<RankListPage>
    with
        SMListState<RankListPage>,
        AutomaticKeepAliveClientMixin<RankListPage> {
  String testType = "3";

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

    ResponseResult<RankListResult> res = await RankListService.getInstance()
        .fetchRankList(testType, page: this.page);
    pullLoadWidgetControl.dataList.clear();
    pullLoadWidgetControl.dataList.addAll(res.data.list);
    setState(() {
      pullLoadWidgetControl.needLoadMore =
          (res != null && res.data.list.length == Config.PAGE_SIZE);
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
    ResponseResult<RankListResult> res = await RankListService.getInstance()
        .fetchRankList(testType, page: this.page);
    pullLoadWidgetControl.dataList.addAll(res.data.list);
    setState(() {
      pullLoadWidgetControl.needLoadMore =
          (res != null && res.data.list.length == Config.PAGE_SIZE);
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
    pullLoadWidgetControl.dataList = _getStore().state.rankState.rankItems;
    if (pullLoadWidgetControl.dataList.length == 0) {
      showRefreshLoading();
    }
    super.didChangeDependencies();
  }

  _renderItem(RankItem item) {
    return GestureDetector(
      child: Container(
        height: ScreenUtil.getInstance().getWidth(100),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(ScreenUtil.getInstance().getWidth(10)),
                child: SMCacheImageWidget(item.avatar + ThumbImgSize.avatarImgScaleSize_100_100),
              ),
              flex: 1,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(ScreenUtil.getInstance().getWidth(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(item.nickname ?? ""),
                    Text(item.amount == null ? "" : item.amount.toString()),
                    Text(item.rank_change == null
                        ? ""
                        : item.rank_change.toString()),
                  ],
                ),
              ),
              flex: 2,
            ),
          ],
        ),
      ),
      onTap: () {
        NavigatorUtils.getInstance().pushNamed(context, RankInfoPage.sName, (context) => RankInfoPage(pullLoadWidgetControl.dataList.indexOf(item)));
//        Navigator.push(
//          context,
//          CupertinoPageRoute(
//            builder: (context) =>
//                RankInfoPage(pullLoadWidgetControl.dataList.indexOf(item)),
//          ),
//        );
      },
    );
  }

  Store<MainStore> _getStore() {
    return StoreProvider.of<MainStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: SMTitleBarWidget(
        isDefault: false,
        title: '榜单表',
        backIconColor: SMColors.lightGolden,
      ),
      body: SMPullLoadWidget(
        new ScrollController(),
        pullLoadWidgetControl,
        (BuildContext context, int index) =>
            _renderItem(pullLoadWidgetControl.dataList[index]),
        handleRefresh,
        onLoadMore,
        refreshKey: refreshIndicatorKey,
      ),
    );
  }
}
