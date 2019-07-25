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
      body: SMCacheVideoWidget(
        width: ScreenUtil.getInstance().screenWidth,
        height: ScreenUtil.getInstance().screenHeight,
        url: 'http://new-mini-world.ufile.ucloud.cn/27-certify-video-721-test-998?UCloudPublicKey=1NMunmNq9U%2FcYhPqRA019BFz8Tw2VflW%2BEuEnJdTDZ6KWFPh3snwlA%3D%3D&Signature=zsKtleVEgwNYtbSIQCnT32MLmo4%3D',
        placeImgUrl: 'https://www.baidu.com/img/bd_logo1.png?where=super',
        loop: true,
        autoPlay: true,
      ),
    );
  }
}
