import 'dart:convert';
import 'package:flutter_smallworld/common/redux/UserRedux.dart';
import 'package:flutter_smallworld/common/model/index.dart';



import 'package:flutter_smallworld/common/net/HttpManager.dart';
import 'package:dio/dio.dart';

class UserDao {
  static login(mobile, password, device, store) async{

    Map requestParams = {
      "mobile" : mobile,
      "password" : password,
      "device" : device
    };

    HttpManager.clearToken();

    var res = await HttpManager.netFetch('/users/login', json.encode(requestParams), Options(method: "post"));
    if (res != null && res.result) {
      UserInfo currentUserInfo = LoginResult.fromJson(res.data).userInfo;
      store.dispatch(updateUserAction(currentUserInfo));

    }
    return DataResult(res.data, res.result);
  }

  static getUserInfo(store, {userId}) async{
    Map requestParams;
    if (userId != null) {
      requestParams = {
        "user_id": userId
      };
    }

    var res = await HttpManager.netFetch('/users/info', requestParams, Options(method: "get"));
    if (res != null && res.result) {
      UserInfo currentUserInfo = UserInfo.fromJson(res.data);
      store.dispatch(updateUserAction(currentUserInfo));
    }

    return DataResult(res.data, res.result);

  }
}