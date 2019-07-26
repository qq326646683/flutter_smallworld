import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/page/index.dart';
import 'package:flutter_smallworld/widget/index.dart';
import 'package:video_player/video_player.dart';

class DebugPage extends StatefulWidget {
  static final String sName = "debug";

  @override
  _DebugPageState createState() => _DebugPageState();
}

class _DebugPageState extends State<DebugPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SMColors.grayLineColor,
      body: Stack(
        children: <Widget>[
          SMCacheVideoWidget(
            width: ScreenUtil.getInstance().screenWidth,
            height: 300,
            url: 'http://img.ksbbs.com/asset/Mon_1703/05cacb4e02f9d9e.mp4',
            placeImgUrl: 'https://www.baidu.com/img/bd_logo1.png?where=super',
            autoPlay: true,
          ),
        ],
      ),
    );
  }
}
