import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/widget/index.dart';

class TaskhallPageStyle {
  static double itemContainerHeight = ScreenUtil.getInstance().getWidth(170.0);
  static double itemContainerPaddingVertical = ScreenUtil.getInstance().getWidth(7.0);
  static final vipText = SMTextStyle(
      color: SMColors.white, fontSize: ScreenUtil.getInstance().getSp(10.0));
  static double itemVipContainerPaddingHorizontal = ScreenUtil.getInstance().getWidth(3.0);
  static double itemVipContainerRadius = ScreenUtil.getInstance().getWidth(8.0);
  static double itemVipContainerBorder = ScreenUtil.getInstance().getWidth(1.5);
  static double itemVipContainerBottom = ScreenUtil.getInstance().getWidth(0.0);
  static double itemVipContainerRight = ScreenUtil.getInstance().getWidth(-10.0);
  static double itemNicknamePaddingLeft = ScreenUtil.getInstance().getWidth(15.0);
  static final nicknameText = SMTextStyle(
    color: SMColors.white,
    fontSize: ScreenUtil.getInstance().getSp(14.0),
  );
  static double itemBorderRadius = ScreenUtil.getInstance().getWidth(10.0);

  static double itemLeftImgPicWid = ScreenUtil.getInstance().getWidth(75.0);
  static double itemLeftImgPicHei = ScreenUtil.getInstance().getWidth(75.0);
  static double itemLeftImgVideoWid = ScreenUtil.getInstance().getWidth(75.0);
  static double itemLeftImgVideoHei = ScreenUtil.getInstance().getWidth(69.0);

  static double itemRightButtonH = ScreenUtil.getInstance().getWidth(32.0);
  static const toCompleteText = SMTextStyle(
    color: SMColors.darkGolden,
    fontSize: SMTxtStyle.smallTextSize,
  );

  static final microTextStyle = SMTextStyle(
    color: SMColors.white,
    fontSize: ScreenUtil.getInstance().getSp(9.0),
  );

  static final contextTextStyle = SMTextStyle(
      color: SMColors.textColorWhite,
      fontSize: SMTxtStyle.smallTextSize,
  );
}

