import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/config/Config.dart';
import 'package:flutter_smallworld/common/model/index.dart';
import 'package:flutter_smallworld/common/utils/index.dart';

class HomeTabItem extends StatefulWidget {
  final HomeTabModel homeTabModel;

  HomeTabItem({this.homeTabModel});

  @override
  _HomeTabItemState createState() => new _HomeTabItemState();
}

class _HomeTabItemState extends State<HomeTabItem> {
  @override
  Widget build(BuildContext context) {
    HomeTabModel homeTabModel = widget.homeTabModel;
    return Container(
      color: SMColors.black,
      child: Stack(
        children: <Widget>[
          /// 视频
          /// 图片
          Center(
            child: Image.network(
                homeTabModel.avatar + ThumbImgSize.homeItemImgScaleSize_414_414,
                width: ScreenUtil.getInstance().screenWidth,
                fit: BoxFit.contain
            ),
          ),
          /// 用户信息
        ],
      ),
    );
  }
}
