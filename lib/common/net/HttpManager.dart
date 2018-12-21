import 'dart:async';
import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_smallworld/common/net/ResultData.dart';
import 'package:flutter_smallworld/common/net/Code.dart';
import 'package:flutter_smallworld/common/config/Config.dart';


class HttpManager {
  static netFetch(url, params, Options option, {noTip = false}) async {
    // 没有网络
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return new ResultData(
          Code.errorHandleEunction(Code.NETWORK_ERROR, "", noTip),
          false,
          Code.NETWORK_ERROR);
    }

    option.connectTimeout = Config.HTTP_TIMEOUT;

    Dio dio = new Dio();
//    print('aaaa111');
//    Response response;
//    response=await dio.get('https://gank.io/api/today');
//    print('aaaa222');
//
//    print(response.data.toString());


    Response response;
    
    Map<String, String> headers = new HashMap();

    option.headers = headers;

    try {
      response = await dio.request(Config.HOST + url,data: params, options: option);
    } on DioError catch (e) {
      if (Config.DEBUG) {
        print('请求异常: ' + e.toString());
        print('请求异常url: ' + url);
      }
    }

    if (Config.DEBUG) {
      print('请求url: ' + url);
      print('请求头: ' + option.headers.toString());
      if (params != null) {
        print('请求参数: ' + params.toString());
      }
      if (response != null) {
        print('返回参数: ' + response.toString());
      }
    }

  }
}
