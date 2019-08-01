import 'dart:convert';
import 'package:flutter_smallworld/common/model/test/rank_list_result.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:dio/dio.dart';
import 'package:flutter_smallworld/common/model/index.dart';
import 'package:flutter_smallworld/common/net/http_manager.dart';
import 'package:flutter_smallworld/common/net/api_adress.dart';

class RankListDao {
  static final String sName = "RankListDao";

  static getRankListList(String param, String type) async {
    ResponseResult<RankListResult> response =
        await HttpManager.netFetch<RankListResult>(
            ApiAddress.getRankList() + param + "&type=$type",
            null,
            NetMethod.GET);
    LogUtil.i(sName, 'getRankListList response: ${response.data.toString()}');
    return response;
  }
}
