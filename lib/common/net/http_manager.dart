import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_smallworld/common/model/http/response_result.dart';
import 'package:flutter_smallworld/common/model/index.dart';
import 'package:flutter_smallworld/common/net/code.dart';
import 'package:flutter_smallworld/common/config/config.dart';
import 'package:flutter_smallworld/common/net/api_adress.dart';
import 'package:flutter_smallworld/common/service/index.dart';
import 'package:flutter_smallworld/common/utils/index.dart';

class NetMethod {
  static const String GET = 'get';
  static const String POST = 'post';
  static const String PUT = 'put';
  static const String DELETE = 'delete';
}

class HttpManager {
  static final String sName = "http_manager";
  static Dio dio = new Dio();
  static String token;

  static Future<ResponseResult> netFetch<Entity>(url, params, String method,
      {noTip = false, bool isList = false, queryParameters, selfHost = false}) async {

    ResponseResult responseResult = isList ? new ResponseResult<List<Entity>>() : new ResponseResult<Entity>();
    // 没有网络
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      responseResult.statusCode = Code.errorHandleEunction(Code.STATUS_CODE_NETWORK_ERROR, "", noTip);
      responseResult.code = Code.CODE_ERROR_NO_NETWORK;
      return responseResult;
    }
    // 设置超时，请求头
    Options option = new Options(method: method);
    option.connectTimeout = Config.HTTP_TIMEOUT;
    option.sendTimeout = Config.HTTP_TIMEOUT;
    option.receiveTimeout = Config.HTTP_TIMEOUT;
    Response response;

    String token = await getToken();
    if (token != null) option.headers = {"Authorization": "Bearer ${token}"};
    NetLogEntity netLogEntity = new NetLogEntity();
    try {
      _httpLogRequest(netLogEntity, method, url, option, params, queryParameters);
      response = await dio.request(selfHost ? url : ApiAddress.API_HOST + url,
          data: params, options: option, queryParameters: queryParameters);
      _httpLogResponse(netLogEntity, response);
      if (_isHttpSuccess(response.statusCode)) {
        // 业务正常
        if (isList) {
          // 数组
          responseResult.fillData(response.statusCode, response.data, EntityCreatorFactory.createEntityList<Entity>(
              response.data), Code.CODE_ALL_SUCCESS, null);
        } else  {
          Entity entity;
          if (Entity == dynamic) {
            // 不解析
            entity = response.data;
          } else {
            entity = EntityCreatorFactory.createEntity(response.data);
          }
          responseResult.fillData(response.statusCode, response.data, entity, Code.CODE_ALL_SUCCESS, null);
        }
      } else {
        responseResult.statusCode = response.statusCode;
        Code.errorHandleEunction(response.statusCode, "", noTip);
        responseResult.code = Code.CODE_REQUEST_ERROR;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        responseResult.sourceData = e.response.data;
      }
      //业务异常
      if (e.response != null && _isHttpSuccess(e.response.statusCode)) {
        _httpLogResponse(netLogEntity, e.response);
        responseResult.fillData(e.response.statusCode, e.response.data, null, e.response.data["code"], e.response.data["errorMessage"]);
      } else {
        //请求异常
        _httpErrorLog(netLogEntity, e, url);
        int statusCode = Code.STATUS_CODE_DIO_ERROR;
        if (e.type == DioErrorType.CONNECT_TIMEOUT ||
            e.type == DioErrorType.SEND_TIMEOUT ||
            e.type == DioErrorType.RECEIVE_TIMEOUT) {
          statusCode = Code.STATUS_CODE_NETWORK_TIMEOUT;
        } else if (e.type == DioErrorType.CANCEL) {
          statusCode = Code.STATUS_CODE_NETWORK_CANCEL;
        }
        if (e.response != null && e.response.statusCode != null) {
          statusCode = e.response.statusCode;
        }
        responseResult.statusCode = Code.errorHandleEunction(statusCode, "", noTip);
        responseResult.code = Code.CODE_REQUEST_ERROR;
      }
    }
    return responseResult;
  }

  static bool _isHttpSuccess(statusCode) {
    return statusCode == 200 || statusCode == 201 || statusCode == 400;
  }

  static _httpLogRequest(NetLogEntity netLogEntity, method, url, option, params, queryParameters) {
    LogUtil.i(sName, '请求url: ' + url);
    netLogEntity.url = ApiAddress.API_HOST + url;
    netLogEntity.method = method;
    netLogEntity.requestTime = DateTime.now();
    if(token != null) {
      LogUtil.i(sName,'请求头: ' + option.headers.toString());
      netLogEntity.requestHeader = option.headers.toString();
    }
    if (params != null) {
      LogUtil.i(sName,'请求参数params: ' + params.toString());
      netLogEntity.requestBody = params.toString();
    }
    if (queryParameters != null) {
      LogUtil.i(sName,'请求参数queryParameters: ' + queryParameters.toString());
      netLogEntity.requestBody = queryParameters.toString();
    }
  }

  static _httpLogResponse(NetLogEntity netLogEntity, response) {
    if (response != null) {
      LogUtil.i(sName,'返回参数: ' + response.toString());
      netLogEntity.status = response.statusCode;
      netLogEntity.responseBody = response.toString();
      netLogEntity.responseTime = DateTime.now();
      NetLogService.getInstance().saveToSP(netLogEntity);
    }
  }

  static _httpErrorLog(NetLogEntity netLogEntity, e, url) {
    LogUtil.i(sName,'请求异常: ' + e.toString());
    LogUtil.i(sName,'请求异常response: ' + e.response.toString());
    LogUtil.i(sName,'请求异常url: ' + url);
    netLogEntity.error = e.toString();
    netLogEntity.errorTime = DateTime.now();
    if(e.response != null) {
      netLogEntity.status = e.response.statusCode;
    }
    NetLogService.getInstance().saveToSP(netLogEntity);
  }


  /// 下载文件
  static download(url, savePath, {ProgressCallback onReceiveProgress, CancelToken cancelToken}) async {
    Options option = new Options();
    String token = await getToken();
    if (token != null) option.headers = {"Authorization": "Bearer ${token}"};
    try {
      return dio.download(url, savePath,onReceiveProgress: onReceiveProgress, cancelToken: cancelToken, options: option);
    } catch (e) {
      LogUtil.i(sName,e);
    }
  }

  /// 上传文件
  static Future<ResponseResult<dynamic>> upload(url, File file, {ProgressCallback onSendProgress, noTip = false,}) async {
    Options option = new Options(method: NetMethod.PUT);
    String token = await getToken();
    if (token != null) option.headers = {"Authorization": "Bearer ${token}"};
    try {
      FormData formData = new FormData.from({
        "avatar": new UploadFileInfo(file, "upload.png")
      });
      Response reponse = await dio.put(ApiAddress.API_HOST + url, data: formData, options: option, onSendProgress: onSendProgress);
      return ResponseResult.from(reponse.statusCode, code: Code.CODE_ALL_SUCCESS);
    } on DioError catch (e) {
      LogUtil.i(sName,e);
      return ResponseResult.from(Code.errorHandleEunction(Code.STATUS_CODE_UPLOAD_FAILURE, "", noTip), code: Code.CODE_REQUEST_ERROR);
    }
  }


  static clearToken() {
    token = null;
    StorageManager.getInstance().remove(Config.TOKEN_KEY);
  }

  static Future<String> getToken() async {
    if (token == null) {
      String spToken = await StorageManager.getInstance().get(Config.TOKEN_KEY);
      if (spToken.isNotEmpty) {
        token = spToken;
        LogUtil.i(sName,token);
      }

    }
    return token;
  }
}
