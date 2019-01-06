import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/utils/index.dart';

class TaskhallPageStyle {
  static double itemContainerHeight = ScreenUtil().getWidth(170.0);
  static double itemContainerPaddingVertical = ScreenUtil().getWidth(7.0);
  static final vipText = TextStyle(
    color: Color(SMColors.white),
    fontSize: ScreenUtil().getSp(10.0)
  );
  static double itemVipContainerPaddingHorizontal = ScreenUtil().getWidth(3.0);
  static double itemVipContainerRadius = ScreenUtil().getWidth(8.0);
  static double itemVipContainerBorder = ScreenUtil().getWidth(1.5);
  static double itemVipContainerBottom = ScreenUtil().getWidth(0.0);
  static double itemVipContainerRight = ScreenUtil().getWidth(-10.0);
  static double itemNicknamePaddingLeft = ScreenUtil().getWidth(15.0);
  static final nicknameText = TextStyle(
    color: Color(SMColors.white),
    fontSize: ScreenUtil().getSp(14.0),
  );
}
