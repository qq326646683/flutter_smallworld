import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/utils/index.dart';

class SMPullLoadWidget extends StatefulWidget {
  final Key refreshKey;

  final IndexedWidgetBuilder itemBuilder;

  final RefreshCallback onRefresh;

  final RefreshCallback onLoadMore;

  final SMPullLoadWidgetControl control;

  SMPullLoadWidget(
      this.control, this.itemBuilder, this.onRefresh, this.onLoadMore,
      {this.refreshKey});

  @override
  _SMPullLoadWidgetState createState() => _SMPullLoadWidgetState();
}

class _SMPullLoadWidgetState extends State<SMPullLoadWidget> {
  final ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    // 是否要加载更多
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (widget.control.needLoadMore) {
        widget.onLoadMore?.call();
      }
    }
    super.initState();
  }

  _getListCount() {
    // 是否需要头部
    if (widget.control.needHeader) {
      // 如果需要头部，用Item 0 的 Widget 作为ListView的头部
      // 列表数量大于0时，因为头部和底部加载更多选项，需要对列表数据总数+2
      return widget.control.dataList.length > 0
          ? widget.control.dataList.length + 2
          : widget.control.dataList.length + 1;
    } else {
      if (widget.control.dataList.length == 0) {
        // 如果不需要头部，在没有数据时，固定返回数量1用于空页面呈现
        return 1;
      }
      // 如果有数据,因为部加载更多选项，需要对列表数据总数+1
      return widget.control.dataList.length > 0
          ? widget.control.dataList.length + 1
          : widget.control.dataList.length;
    }
  }

  _getItem(int index) {
    if (!widget.control.needLoadMore &&
        index == widget.control.dataList.length &&
        widget.control.dataList.length != 0) {
      // 如果不需要头部，并且数据不为0，当index等于数据长度时，渲染加载更多Item（因为index是从0开始）
      return _buildProgressIndicator();
    } else if (widget.control.needHeader &&
        index == _getListCount() - 1 &&
        widget.control.dataList.length != 0) {
      // 如果需要头部，并且数据不为0，当index等于实际渲染长度 - 1时，渲染加载更多Item（因为index是从0开始）
      return _buildProgressIndicator();
    } else if (!widget.control.needHeader &&
        widget.control.dataList.length == 0) {
      // 如果不需要头部，并且数据为0，渲染空页面
      return _buildEmpty();
    } else {
      return widget.itemBuilder(context, index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new RefreshIndicator(
        // GlobalKey 用户外部获取RefreshIndicator的State，做显示刷新
        key: widget.refreshKey,
        // 下拉刷新，返回Future
        onRefresh: widget.onRefresh,
        child: ListView.builder(
          // 保持ListView任何情况都能滚动，解决在RefreshIndicator的兼容问题
          physics: AlwaysScrollableScrollPhysics(),

          // 根据状态返回子控件
          itemBuilder: (context, index) {
            return _getItem(index);
          },

          // 根据状态返回数量
          itemCount: _getListCount(),

          // 滑动监听
          controller: _scrollController,
        ));
  }

  // 上拉加载更多
  Widget _buildProgressIndicator() {
    Widget bottomWidget = widget.control.needLoadMore ? Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(width: ScreenUtil().getWidth(5.0)),
        Text('加载中...', style: SMTxtStyle.normalText,)
      ],
    ) : Container();
    return Padding(
        padding: EdgeInsets.all(ScreenUtil().getWidth(20.0)),
        child: Center(
          child: bottomWidget,
        ));
  }

  // 空页面
  Widget _buildEmpty() {
    return Container(
      height: ScreenUtil().screenHeight - ScreenUtil().getHeight(100.0),
      child: Column(
        children: <Widget>[
          FlatButton(onPressed: () {}, child: Image.asset(SMIcons.HOT_TIP)),
          Container(
            child: Text(
              "暂无数据",
              style: SMTxtStyle.normalText,
            ),
          )
        ],
      ),
    );
  }
}

class SMPullLoadWidgetControl {
  // 数据，对齐增减，不能替换
  List dataList = new List();

  // 是否需要加载更多
  bool needLoadMore = true;

  // 是否需要头部
  bool needHeader = false;
}
