import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_smallworld/common/dao/activity_info_dao.dart';
import 'package:flutter_smallworld/common/dao/index.dart';
import 'package:flutter_smallworld/common/model/index.dart';
import 'package:flutter_smallworld/common/model/test/cofig_result_entity.dart';
import 'package:flutter_smallworld/common/net/index.dart';
import 'package:flutter_smallworld/common/redux/config_state.dart';
import 'package:flutter_smallworld/common/redux/index.dart';
import 'package:flutter_smallworld/common/utils/index.dart';

class ActivityInfoService {
  static ActivityInfoService instance;

  static ActivityInfoService getInstance() {
    if (instance == null) {
      instance = new ActivityInfoService();
    }
    return instance;
  }

  Future<ResponseResult<Entity>> fetchActivityInfo() async {
    ResponseResult<Entity> response = await ActivityInfoDao.getActivtyInfo();

    if (response.isSuccess) {
      Entity configResult = response.data;
      CommonUtils.store.dispatch(UpdateConfigAction(configResult));
    }

    return response;
  }
}
