import 'package:flutter_smallworld/common/config/Config.dart';

class ApiAddress {
  static const HOST 

  // 任务大厅
  static getTashhall() {
    return '/personal_task';
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
