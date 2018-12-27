import 'dart:async';
import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_smallworld/common/model/index.dart';
import 'package:flutter_smallworld/common/net/Code.dart';
import 'package:flutter_smallworld/common/config/Config.dart';
import 'package:flutter_smallworld/common/utils/index.dart';


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
    Response response;

    String token = await getToken();
    option.headers = {"Authorization": "Bearer ${token}"};

    try {
      response = await dio.request(Config.HOST + url,data: params, options: option);
    } on DioError catch (e) {
      Response errorResponse;
      if(e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = new Response(statusCode: 666);
      }
      if (e.type == DioErrorType.CONNECT_TIMEOUT) {
        errorResponse.statusCode = Code.NETWORK_TIMEOUT;
      }

      if (Config.DEBUG) {
        print('请求异常: ' + e.toString());
        print('请求异常url: ' + url);
      }
      return new ResultData(Code.errorHandleEunction(errorResponse.statusCode, e.message, noTip), false, errorResponse.statusCode);
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

    try {
      if (response.statusCode == 201 && response.data['token'] != null) {
        await StorageUtil.save(Config.TOKEN_KEY, response.data['token']);
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        return new ResultData(response.data, true, Code.SUCCESS, headers: response.headers);
      }
    } catch (e) {
      return new ResultData(response.data, false, response.statusCode, headers: response.headers);
    }

    return new ResultData(Code.errorHandleEunction(response.statusCode, "", noTip), false, response.statusCode);


  }

  static clearToken() {
    StorageUtil.remove(Config.TOKEN_KEY);
  }

  static Future<String> getToken() async{
    return await StorageUtil.get(Config.TOKEN_KEY);
  }

}
