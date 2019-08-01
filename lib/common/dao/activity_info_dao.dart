import 'dart:convert';
import 'package:flutter_smallworld/common/model/test/cofig_result_entity.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/common/model/index.dart';
import 'package:flutter_smallworld/common/net/http_manager.dart';
import 'package:flutter_smallworld/common/net/api_adress.dart';

class ActivityInfoDao {
  static final String sName = "ActivityInfoDao";

  static getActivtyInfo() async {
    ResponseResult<Entity> response = await HttpManager.netFetch<Entity>(
        ApiAddress.getActivityInfo(), null, NetMethod.GET);
    LogUtil.i(sName, 'getActivityInfo response: ${response.data.toString()}');
    return response;
  }
}
