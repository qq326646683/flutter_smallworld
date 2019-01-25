import 'package:flutter/material.dart';
import 'package:flutter_smallworld/widget/index.dart';

class SMColors {
  static const String primaryValueString = "#24292E";
  static const String primaryLightValueString = "#42464b";
  static const String primaryDarkValueString = "#121917";
  static const String miWhiteString = "#ececec";
  static const String actionBlueString = "#267aff";
  static const String webDraculaBackgroundColorString = "#282a36";
  static const String textPlaceHolderWhiteString = "#999999";

  static const Color primaryValue = Color(0xFF24292E);
  static const Color primaryLightValue = Color(0xFF42464b);
  static const Color primaryDarkValue = Color(0xFF121917);

  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color miWhite = Color(0xffececec);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color actionBlue = Color(0xff267aff);
  static const Color subTextColor = Color(0xff959595);
  static const Color subLightTextColor = Color(0xffc4c4c4);
  static const Color textPlaceHolderWhite = Color(0xff999999);

  //yellow
  static const Color lightGolden = Color(0xffECC752);
  static const Color darkGolden = Color(0xffB18B3E);

  static const Color mainBackgroundColor = miWhite;

  static const Color mainTextColor = primaryDarkValue;
  static const Color textColorWhite = white;

  static const Color grayLineColor = Color(0xff707070);

  static const Color opacity60Cover = Color(0x96000000);

  static const Color opacity75Cover = Color(0xcc000000);

  static const Color opacity60CoverWhite = Color(0x96ffffff);

  static const Color opacity75CoverWhite = Color(0xccffffff);

  // 消息提示点颜色
  static const Color msgTipColor = Color(0xFFF44336);
}

class SMCommonStyle {
  static BorderRadius borderRadius5 = BorderRadius.all(Radius.circular(5.0));
  static EdgeInsets padding5 = EdgeInsets.all(5.0);
  static EdgeInsets btnPadding =
      EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0);
  static Border border05White = Border.all(width: 0.5, color: SMColors.white);
  static Border borderBottom03Gray =
      Border(bottom: BorderSide(width: 0.3, color: SMColors.grayLineColor));
}

// 文本样式
class SMTxtStyle {
  static const lagerTextSize = 30.0;
  static const bigTextSize = 23.0;
  static const normalTextSize = 18.0;
  static const middleTextWhiteSize = 16.0;
  static const smallTextSize = 14.0;
  static const minTextSize = 12.0;

  static const minText = SMTextStyle(
    color: SMColors.subLightTextColor,
    fontSize: minTextSize,
  );

  static const minTextWhite = SMTextStyle(
    color: SMColors.textColorWhite,
    fontSize: minTextSize,
  );

  static const smallTextWhite = SMTextStyle(
    color: SMColors.textColorWhite,
    fontSize: smallTextSize,
  );

  static const smallText = SMTextStyle(
    color: SMColors.mainTextColor,
    fontSize: smallTextSize,
  );

  static const smallTextBold = SMTextStyle(
    color: SMColors.mainTextColor,
    fontSize: smallTextSize,
    fontWeight: FontWeight.bold,
  );

  static const smallSubLightText = SMTextStyle(
    color: SMColors.subLightTextColor,
    fontSize: smallTextSize,
  );

  static const smallActionLightText = SMTextStyle(
    color: SMColors.actionBlue,
    fontSize: smallTextSize,
  );

  static const smallMiLightText = SMTextStyle(
    color: SMColors.miWhite,
    fontSize: smallTextSize,
  );

  static const smallSubText = SMTextStyle(
    color: SMColors.subTextColor,
    fontSize: smallTextSize,
  );

  static const middleText = SMTextStyle(
    color: SMColors.mainTextColor,
    fontSize: middleTextWhiteSize,
  );

  static const middleTextWhite = SMTextStyle(
    color: SMColors.textColorWhite,
    fontSize: middleTextWhiteSize,
  );

  static const middleSubText = SMTextStyle(
    color: SMColors.subTextColor,
    fontSize: middleTextWhiteSize,
  );

  static const middleSubLightText = SMTextStyle(
    color: SMColors.subLightTextColor,
    fontSize: middleTextWhiteSize,
  );

  static const middleTextBold = SMTextStyle(
    color: SMColors.mainTextColor,
    fontSize: middleTextWhiteSize,
    fontWeight: FontWeight.bold,
  );

  static const middleTextWhiteBold = SMTextStyle(
    color: SMColors.textColorWhite,
    fontSize: middleTextWhiteSize,
    fontWeight: FontWeight.bold,
  );

  static const middleSubTextBold = SMTextStyle(
    color: SMColors.subTextColor,
    fontSize: middleTextWhiteSize,
    fontWeight: FontWeight.bold,
  );

  static const normalText = SMTextStyle(
    color: SMColors.mainTextColor,
    fontSize: normalTextSize,
  );

  static const normalTextBold = SMTextStyle(
    color: SMColors.mainTextColor,
    fontSize: normalTextSize,
    fontWeight: FontWeight.bold,
  );

  static const normalSubText = SMTextStyle(
    color: SMColors.subTextColor,
    fontSize: normalTextSize,
  );

  static const normalTextWhite = SMTextStyle(
    color: SMColors.textColorWhite,
    fontSize: normalTextSize,
  );

  static const normalTextGolden = SMTextStyle(
    color: SMColors.lightGolden,
    fontSize: normalTextSize,
  );

  static const normalTextBoldWhite = SMTextStyle(
    color: SMColors.textColorWhite,
    fontSize: normalTextSize,
    fontWeight: FontWeight.bold,
  );

  static const normalTextMitWhiteBold = SMTextStyle(
    color: SMColors.miWhite,
    fontSize: normalTextSize,
    fontWeight: FontWeight.bold,
  );

  static const normalTextActionWhiteBold = SMTextStyle(
    color: SMColors.actionBlue,
    fontSize: normalTextSize,
    fontWeight: FontWeight.bold,
  );

  static const normalTextLight = SMTextStyle(
    color: SMColors.primaryLightValue,
    fontSize: normalTextSize,
  );

  static const largeText = SMTextStyle(
    color: SMColors.mainTextColor,
    fontSize: bigTextSize,
  );

  static const largeTextSubLight = SMTextStyle(
    color: SMColors.subLightTextColor,
    fontSize: bigTextSize,
  );

  static const largeTextBold = SMTextStyle(
    color: SMColors.mainTextColor,
    fontSize: bigTextSize,
    fontWeight: FontWeight.bold,
  );

  static const largeTextWhite = SMTextStyle(
    color: SMColors.textColorWhite,
    fontSize: bigTextSize,
  );

  static const largeTextWhiteBold = SMTextStyle(
    color: SMColors.textColorWhite,
    fontSize: bigTextSize,
    fontWeight: FontWeight.bold,
  );

  static const largeTextGoldenBold = SMTextStyle(
    color: SMColors.lightGolden,
    fontSize: bigTextSize,
    fontWeight: FontWeight.bold,
  );

  static const largeLargeTextWhite = SMTextStyle(
    color: SMColors.textColorWhite,
    fontSize: lagerTextSize,
    fontWeight: FontWeight.bold,
  );

  static const largeLargeText = SMTextStyle(
    color: SMColors.primaryValue,
    fontSize: lagerTextSize,
    fontWeight: FontWeight.bold,
  );

  static const largeTextHolderWhite = SMTextStyle(
    color: SMColors.textPlaceHolderWhite,
    fontSize: bigTextSize,
  );

  static const normalTextHolderWhite = SMTextStyle(
    color: SMColors.textPlaceHolderWhite,
    fontSize: normalTextSize,
  );

  static const smallTextGray = SMTextStyle(
    color: SMColors.grayLineColor,
    fontSize: smallTextSize
  );
}

class SMIcons {
  static const String SPLASH_BG = 'static/images/passport/splash_bg.jpg';
  static const String HOT_TIP = 'static/images/passport/hot_tip.png';
  static const String LOGIN_BG_MP4 = 'static/images/passport/login_bg.mp4';
  static const String TAB_HOME = 'static/images/tabs/home.png';
  static const String TAB_HOME_ACTIVE = 'static/images/tabs/home_active.png';
  static const String TAB_CLUB_ACTIVE = 'static/images/tabs/club_active.png';
  static const String TAB_CHAT = 'static/images/tabs/chat.png';
  static const String TAB_CHAT_ACTIVE = 'static/images/tabs/chat_active.png';
  static const String TAB_DISCOVER = 'static/images/tabs/discover.png';
  static const String TAB_DISCOVER_ACTIVE =
      'static/images/tabs/discover_active.png';
  static const String TAB_PROFILE = 'static/images/tabs/profile.png';
  static const String TAB_PROFILE_ACTIVE =
      'static/images/tabs/profile_active.png';
  static const String TASKHALL_BG =
      'static/images/discover/taskhall/task_bg.jpg';
  static const String TASKHALL_ITEM_BG =
      'static/images/discover/taskhall/task_item_bg.png';
  static const String TASK_RECT =
      'static/images/discover/taskhall/rectangle_yellow.png';
  static const String TASK_PICTURE =
      'static/images/discover/taskhall/task_picture.png';
  static const String TASK_VIDEO =
      'static/images/discover/taskhall/task_video.png';
  static const String COMMON_BACK = 'static/images/common/icon_back.png';
  static const String COMMON_RIGHT = 'static/images/common/icon_right.png';
  static const String PLACE_NODATA = 'static/images/common/place_nodata.png';
}
