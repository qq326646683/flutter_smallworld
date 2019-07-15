import 'package:flutter_smallworld/common/config/config.dart';
import 'package:flutter_smallworld/common/dao/user_dao.dart';
import 'package:flutter_smallworld/common/model/user/userinfo.dart';
import 'package:flutter_smallworld/common/net/http_manager.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/common/utils/storage_util.dart';

/// 集中初始化的类，当成功取得用户信息时做相应初始化
class InitUtils {
  static onUserLogin(UserInfo userInfo) {
    String userId = userInfo.id;
    UserStorageManage.getInstance().init(userId);
//    DbManager.init(userId);
  }

  static onUserLogout() async {
    HttpManager.clearToken();
    if (!UserStorageManage.getInstance().hasInitialize()) {
      // 还没有初始化就被登出, 初始化用户存储管理器
      UserInfo userInfo = await UserDao.getUserInfoLocal();
      if (userInfo != null) {
        UserStorageManage.getInstance().init(userInfo.id);
      }
    }
    StorageManager.getInstance().remove(Config.USERINFO_KEY);
//    DbManager.destroy();
//    CacheFileUtil.clearCacheFile();
//    StorageManager.getInstance().remove(Config.UPDATE_IGNORE);
  }
}