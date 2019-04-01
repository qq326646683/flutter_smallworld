import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/config/Config.dart';
import 'package:flutter_smallworld/common/model/index.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/common/db/index.dart';

class HomeTabItem extends StatefulWidget {
  final HomeTabModel homeTabModel;

  HomeTabItem({this.homeTabModel});

  @override
  _HomeTabItemState createState() => new _HomeTabItemState();
}

class _HomeTabItemState extends State<HomeTabItem> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    HomeTabModel homeTabModel = widget.homeTabModel;
    String imgUrl = homeTabModel.avatar + ThumbImgSize.homeItemImgScaleSize_414_414;
    return Container(
      color: SMColors.black,
      child: Stack(
        children: <Widget>[
          /// 视频
          /// 图片
          Center(
            child: GestureDetector(
              onTap: () async {
//                CacheFile cacheFile = await CacheFileUtil.setCacheFile(CacheFileType.IMAGE, imgUrl, cacheType: CacheType.COMMON);
//                print(cacheFile.toJson());
                DbManager.initDb();
              },
              child: Image.network(
                  imgUrl,
                  width: ScreenUtil.getInstance().screenWidth,
                  fit: BoxFit.contain
              ),
            ),
          ),
          /// 用户信息
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
