import 'package:flutter/material.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_smallworld/common/config/config.dart';
import 'package:flutter_smallworld/common/model/index.dart';
import 'package:flutter_smallworld/common/redux/index.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/widget/index.dart';

class HomeTabItem extends StatefulWidget {
  final HomeTabModel homeTabModel;

  HomeTabItem({this.homeTabModel});

  @override
  _HomeTabItemState createState() => new _HomeTabItemState();
}

class _HomeTabItemState extends State<HomeTabItem> {
  IjkMediaController mediaController;

  @override
  void initState() {
    super.initState();
    mediaController = IjkMediaController();
  }

  @override
  Widget build(BuildContext context) {
    HomeTabModel homeTabModel = widget.homeTabModel;
    String imgUrl =
        homeTabModel.avatar + ThumbImgSize.homeItemImgScaleSize_414_414;
    return Container(
      color: SMColors.black,
      child: Stack(
        children: <Widget>[
          /// 视频
          homeTabModel.certifyVideo != null
              ? SMCacheVideoWidget(
                  width: ScreenUtil.getInstance().screenWidth,
                  height: ScreenUtil.getInstance().screenHeight,
                  mediaController: mediaController,
                  url: homeTabModel.certifyVideo.video,
                  placeImgUrl: imgUrl,
                  verticalGesture: false,
                  horizontalGesture: false,
                  showFullScreenButton: false,
                  showBottomBar: false,
                  loop: true,
                )
              :
              /// 图片
              Center(
                  child: SMCacheImageWidget(imgUrl,
                      width: ScreenUtil.getInstance().screenWidth,
                      fit: BoxFit.contain),
                ),
//          Text(homeTabModel.avatar, style: SMTxtStyle.normalTextWhite,)
          /// 用户信息
        ],
      ),
    );
  }
}
