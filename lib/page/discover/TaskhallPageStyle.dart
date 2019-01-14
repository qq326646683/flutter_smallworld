import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/widget/index.dart';

class TaskhallPageStyle {
  static double itemContainerHeight = ScreenUtil().getWidth(170.0);
  static double itemContainerPaddingVertical = ScreenUtil().getWidth(7.0);
  static final vipText = SMTextStyle(
      color: Color(SMColors.white), fontSize: ScreenUtil().getSp(10.0));
  static double itemVipContainerPaddingHorizontal = ScreenUtil().getWidth(3.0);
  static double itemVipContainerRadius = ScreenUtil().getWidth(8.0);
  static double itemVipContainerBorder = ScreenUtil().getWidth(1.5);
  static double itemVipContainerBottom = ScreenUtil().getWidth(0.0);
  static double itemVipContainerRight = ScreenUtil().getWidth(-10.0);
  static double itemNicknamePaddingLeft = ScreenUtil().getWidth(15.0);
  static final nicknameText = SMTextStyle(
    color: Color(SMColors.white),
    fontSize: ScreenUtil().getSp(14.0),
  );
  static double itemBorderRadius = ScreenUtil().getWidth(10.0);

  static double itemLeftImgPicWid = ScreenUtil().getWidth(75.0);
  static double itemLeftImgPicHei = ScreenUtil().getWidth(75.0);
  static double itemLeftImgVideoWid = ScreenUtil().getWidth(75.0);
  static double itemLeftImgVideoHei = ScreenUtil().getWidth(69.0);

  static double itemRightButtonH = ScreenUtil().getWidth(32.0);
  static const toCompleteText = SMTextStyle(
    color: Color(SMColors.darkGolden),
    fontSize: SMTxtStyle.smallTextSize,
  );
  static EdgeInsetsGeometry buttonPadding = EdgeInsets.symmetric(
      horizontal: ScreenUtil().getWidth(10.0),
      vertical: ScreenUtil().getWidth(5.0));

  static final microTextStyle = SMTextStyle(
    color: Color(SMColors.white),
    fontSize: ScreenUtil().getSp(9.0),
  );

  static final contextTextStyle = SMTextStyle(
      color: Color(SMColors.textColorWhite),
      fontSize: SMTxtStyle.smallTextSize,
  );
}

