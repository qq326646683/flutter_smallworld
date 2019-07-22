import 'package:flutter_smallworld/common/net/index.dart';

class Config {
  // API 环境
  static const API_SETTING = APIType.STAGING;
  // bugly上报
  static const REPORT_CRASH = false;
  // Debug入口
  static const DEBUG_ENTER = true;
  // 请求超时时间
  static const HTTP_TIMEOUT = 5000;
  // 分页数量
  static const PAGE_SIZE = 10;

  /// //////////////////////////////////////常量////////////////////////////////////// ///
  static const TOKEN_KEY = "token";
  static const USERINFO_KEY = "userinfo";
  static const DB_NAME = "smallworld_zh.db";
  static const NETLOG_KEY = "net_log";
  static const PRINTLOG_KEY = "print_log";


}

class ThumbImgSize {
  static const String homeItemImgScaleSize_414_414 = '&iopcmd=thumbnail&type=7&width=828&height=828|iopcmd=convert&dst=jpg&Q=70';
  static const String avatarImgScaleSize_100_100 = '&iopcmd=thumbnail&type=7&width=200&height=200|iopcmd=convert&dst=jpg&Q=70';
}