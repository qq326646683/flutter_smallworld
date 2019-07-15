import 'package:flutter_smallworld/common/config/config.dart';

enum APIType {
  // 局域网
  DEV,
  // 外侧
  STAGING,
  // 线上
  PRODUCTION
}

Map<APIType, String> apiMap = {
  APIType.DEV : 'http://10.0.0.17:4000',
  APIType.STAGING : 'http://106.75.11.161:8082',
  APIType.PRODUCTION : 'http://47.100.103.110:3000',
};

class ApiAddress {
  static final HOST = apiMap[Config.API_SETTING];
  static final API_HOST = '$HOST/api';

  // 登录
  static login() {
    return '/users/login';
  }
  // 用户信息
  static userInfo() {
    return '/users/info';
  }

  // 任务大厅
  static getTashhall() {
    return '/personal_task';
  }

  // 陌生人列表
  static getHomeTab() {
    return '/strangers';
  }

  //处理分页参数
  static getPageParams(tab, page, [pageSize = Config.PAGE_SIZE]) {
    if (page != null) {
      if (pageSize != null) {
        return '${tab}pos=${(page - 1) * pageSize}&limit=${pageSize}';
      } else {
        return '${tab}pos=${(page - 1) * pageSize}';
      }
    } else {
      return '';
    }
  }

}