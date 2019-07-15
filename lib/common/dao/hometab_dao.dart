import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:redux/redux.dart';
import 'package:dio/dio.dart';
import 'package:flutter_smallworld/common/model/index.dart';
import 'package:flutter_smallworld/common/net/http_manager.dart';
import 'package:flutter_smallworld/common/net/api_adress.dart';



class HomeTabDao{
  static final String sName = "HomeTabDao";

  static getHomeTabList(String param) async{
    ResponseResult<HomeTabResult> response = await HttpManager.netFetch<HomeTabResult>(ApiAddress.getHomeTab() + param, null, NetMethod.GET);
    LogUtil.i(sName, 'getHomeTabList response: ${response.data.toString()}');
    return response;
  }

}