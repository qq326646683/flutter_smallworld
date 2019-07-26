import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_smallworld/common/config/config.dart';
import 'package:flutter_smallworld/common/model/index.dart';
import 'package:flutter_smallworld/common/redux/index.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/widget/index.dart';
import 'package:video_player/video_player.dart';

class HomeTabItem extends StatefulWidget {
  final HomeTabModel homeTabModel;

  HomeTabItem({this.homeTabModel});

  @override
  _HomeTabItemState createState() => new _HomeTabItemState();
}

class _HomeTabItemState extends State<HomeTabItem> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HomeTabModel homeTabModel = widget.homeTabModel;
    String imgUrl = homeTabModel.avatar; // + ThumbImgSize.homeItemImgScaleSize_414_414;
    return Container(
      color: SMColors.black,
      child: Stack(
        children: <Widget>[
          /// 视频
          homeTabModel.certifyVideo != null
              ? SMCacheVideoWidget(
                  width: ScreenUtil.getInstance().screenWidth,
                  height: ScreenUtil.getInstance().screenHeight,
                  url: homeTabModel.certifyVideo.video,
                  placeImgUrl: imgUrl,
                  loop: true,
                  autoPlay: true,
                  isClickPause: true,
                  showCover: false,
                  progressWidget: (VideoPlayerController controller) => Positioned(
                    bottom: ScreenUtil.getInstance().bottomBarHeight + 49,
                    child: Container(
                      width: ScreenUtil.getInstance().screenWidth,
                      child: VideoProgressIndicator(controller, allowScrubbing: false, colors: VideoProgressColors(bufferedColor: SMColors.transparent, playedColor: SMColors.lightGolden, backgroundColor: SMColors.transparent),),
                    ),
                  ),
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
