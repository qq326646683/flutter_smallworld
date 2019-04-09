class Config {
  static const DEBUG = true;
  static const HTTP_TIMEOUT = 15000;
  static const PAGE_SIZE = 10;

  /// //////////////////////////////////////常量////////////////////////////////////// ///
  static const TOKEN_KEY = "token";
  static const USERINFO_KEY = "userinfo";
  static const DB_NAME = "smallworld_zh.db";

}

class ThumbImgSize {
  static const String homeItemImgScaleSize_414_414 = '&iopcmd=thumbnail&type=7&width=828&height=828|iopcmd=convert&dst=jpg&Q=70';
  static const String avatarImgScaleSize_100_100 = '&iopcmd=thumbnail&type=7&width=200&height=200|iopcmd=convert&dst=jpg&Q=70';
}