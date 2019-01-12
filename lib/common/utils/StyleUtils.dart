import 'package:flutter/material.dart';

class SMColors {
  static const String primaryValueString = "#24292E";
  static const String primaryLightValueString = "#42464b";
  static const String primaryDarkValueString = "#121917";
  static const String miWhiteString = "#ececec";
  static const String actionBlueString = "#267aff";
  static const String webDraculaBackgroundColorString = "#282a36";
  static const String textPlaceHolderWhiteString = "#999999";

  static const int primaryValue = 0xFF24292E;
  static const int primaryLightValue = 0xFF42464b;
  static const int primaryDarkValue = 0xFF121917;

  static const int cardWhite = 0xFFFFFFFF;
  static const int textWhite = 0xFFFFFFFF;
  static const int miWhite = 0xffececec;
  static const int white = 0xFFFFFFFF;
  static const int black = 0xFF000000;
  static const int actionBlue = 0xff267aff;
  static const int subTextColor = 0xff959595;
  static const int subLightTextColor = 0xffc4c4c4;
  static const int textPlaceHolderWhite = 0xff999999;


  //yellow
  static const int lightGolden = 0xffECC752;
  static const int darkGolden = 0xffB18B3E;

  static const int mainBackgroundColor = miWhite;

  static const int mainTextColor = primaryDarkValue;
  static const int textColorWhite = white;


  static const int opacity60Cover = 0x96000000;

  static const int opacity75Cover = 0xcc000000;

  // 消息提示点颜色
  static const int msgTipColor = 0xFFF44336;
}

// 文本样式
class SMTxtStyle {
  static const lagerTextSize = 30.0;
  static const bigTextSize = 23.0;
  static const normalTextSize = 18.0;
  static const middleTextWhiteSize = 16.0;
  static const smallTextSize = 14.0;
  static const minTextSize = 12.0;

  static const minText = TextStyle(
    color: Color(SMColors.subLightTextColor),
    fontSize: minTextSize,
  );

  static const smallTextWhite = TextStyle(
    color: Color(SMColors.textColorWhite),
    fontSize: smallTextSize,
  );

  static const smallText = TextStyle(
    color: Color(SMColors.mainTextColor),
    fontSize: smallTextSize,
  );

  static const smallTextBold = TextStyle(
    color: Color(SMColors.mainTextColor),
    fontSize: smallTextSize,
    fontWeight: FontWeight.bold,
  );

  static const smallSubLightText = TextStyle(
    color: Color(SMColors.subLightTextColor),
    fontSize: smallTextSize,
  );

  static const smallActionLightText = TextStyle(
    color: Color(SMColors.actionBlue),
    fontSize: smallTextSize,
  );

  static const smallMiLightText = TextStyle(
    color: Color(SMColors.miWhite),
    fontSize: smallTextSize,
  );

  static const smallSubText = TextStyle(
    color: Color(SMColors.subTextColor),
    fontSize: smallTextSize,
  );

  static const middleText = TextStyle(
    color: Color(SMColors.mainTextColor),
    fontSize: middleTextWhiteSize,
  );

  static const middleTextWhite = TextStyle(
    color: Color(SMColors.textColorWhite),
    fontSize: middleTextWhiteSize,
  );

  static const middleSubText = TextStyle(
    color: Color(SMColors.subTextColor),
    fontSize: middleTextWhiteSize,
  );

  static const middleSubLightText = TextStyle(
    color: Color(SMColors.subLightTextColor),
    fontSize: middleTextWhiteSize,
  );

  static const middleTextBold = TextStyle(
    color: Color(SMColors.mainTextColor),
    fontSize: middleTextWhiteSize,
    fontWeight: FontWeight.bold,
  );

  static const middleTextWhiteBold = TextStyle(
    color: Color(SMColors.textColorWhite),
    fontSize: middleTextWhiteSize,
    fontWeight: FontWeight.bold,
  );

  static const middleSubTextBold = TextStyle(
    color: Color(SMColors.subTextColor),
    fontSize: middleTextWhiteSize,
    fontWeight: FontWeight.bold,
  );

  static const normalText = TextStyle(
    color: Color(SMColors.mainTextColor),
    fontSize: normalTextSize,
  );

  static const normalTextBold = TextStyle(
    color: Color(SMColors.mainTextColor),
    fontSize: normalTextSize,
    fontWeight: FontWeight.bold,
  );

  static const normalSubText = TextStyle(
    color: Color(SMColors.subTextColor),
    fontSize: normalTextSize,
  );

  static const normalTextWhite = TextStyle(
    color: Color(SMColors.textColorWhite),
    fontSize: normalTextSize,
  );

  static const normalTextMitWhiteBold = TextStyle(
    color: Color(SMColors.miWhite),
    fontSize: normalTextSize,
    fontWeight: FontWeight.bold,
  );

  static const normalTextActionWhiteBold = TextStyle(
    color: Color(SMColors.actionBlue),
    fontSize: normalTextSize,
    fontWeight: FontWeight.bold,
  );

  static const normalTextLight = TextStyle(
    color: Color(SMColors.primaryLightValue),
    fontSize: normalTextSize,
  );

  static const largeText = TextStyle(
    color: Color(SMColors.mainTextColor),
    fontSize: bigTextSize,
  );

  static const largeTextSubLight = TextStyle(
    color: Color(SMColors.subLightTextColor),
    fontSize: bigTextSize,
  );

  static const largeTextBold = TextStyle(
    color: Color(SMColors.mainTextColor),
    fontSize: bigTextSize,
    fontWeight: FontWeight.bold,
  );

  static const largeTextWhite = TextStyle(
    color: Color(SMColors.textColorWhite),
    fontSize: bigTextSize,
  );

  static const largeTextWhiteBold = TextStyle(
    color: Color(SMColors.textColorWhite),
    fontSize: bigTextSize,
    fontWeight: FontWeight.bold,
  );

  static const largeLargeTextWhite = TextStyle(
    color: Color(SMColors.textColorWhite),
    fontSize: lagerTextSize,
    fontWeight: FontWeight.bold,
  );

  static const largeLargeText = TextStyle(
    color: Color(SMColors.primaryValue),
    fontSize: lagerTextSize,
    fontWeight: FontWeight.bold,
  );

  static const largeTextHolderWhite = TextStyle(
    color: Color(SMColors.textPlaceHolderWhite),
    fontSize: bigTextSize,
  );

  static const normalTextHolderWhite = TextStyle(
    color: Color(SMColors.textPlaceHolderWhite),
    fontSize: normalTextSize,
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
  static const String TAB_DISCOVER_ACTIVE = 'static/images/tabs/discover_active.png';
  static const String TAB_PROFILE = 'static/images/tabs/profile.png';
  static const String TAB_PROFILE_ACTIVE = 'static/images/tabs/profile_active.png';
  static const String TASKHALL_BG = 'static/images/discover/taskhall/task_bg.jpg';
  static const String TASKHALL_ITEM_BG = 'static/images/discover/taskhall/task_item_bg.png';
  static const String TASK_RECT = 'static/images/discover/taskhall/rectangle_yellow.png';
  static const String TASK_PICTURE = 'static/images/discover/taskhall/task_picture.png';
  static const String TASK_VIDEO = 'static/images/discover/taskhall/task_video.png';
  static const String COMMON_BACK = 'static/images/common/icon_back.png';



}



