import 'dart:convert';
import 'package:flutter_smallworld/common/config/config.dart';
import 'package:flutter_smallworld/common/db/index.dart';
import 'package:flutter_smallworld/common/net/index.dart';
import 'package:flutter_smallworld/common/redux/user_state.dart';
import 'package:flutter_smallworld/common/model/index.dart';
import 'package:flutter_smallworld/common/utils/index.dart';



import 'package:flutter_smallworld/common/net/http_manager.dart';
import 'package:dio/dio.dart';
import 'package:redux/redux.dart';

class UserDao {
  static login(mobile, password, device, store) async{

    Map requestParams = {
      "mobile" : mobile,
      "password" : password,
      "device" : device
    };

    HttpManager.clearToken();

    ResponseResult<LoginResult> response = await HttpManager.netFetch<LoginResult>(ApiAddress.login(), json.encode(requestParams), NetMethod.POST);
    if (response.isSuccess) {
      LoginResult loginResult = response.data;
      await StorageManager.getInstance().save(Config.TOKEN_KEY, loginResult.token);
      await _onMyselfInfoReceived(store, loginResult.userInfo);
    }
    return response;
  }

  static getUserInfo(store, {userId}) async{
    Map requestParams;
    if (userId != null) {
      requestParams = {
        "user_id": userId
      };
    }

    ResponseResult<UserInfo> response = await HttpManager.netFetch<UserInfo>(ApiAddress.userInfo(), requestParams, NetMethod.GET);
    if (response.isSuccess && userId == null) {
      await _onMyselfInfoReceived(store, response.data);
    }

    return response;

  }


  static getUserInfoLocal({store}) async {
    String userTxt = await StorageManager.getInstance().get(Config.USERINFO_KEY);
    if (!userTxt.isEmpty) {
      var userMap = json.decode(userTxt);
      UserInfo userInfo = UserInfo.fromJson(userMap);
      _onMyselfInfoReceived(store, userInfo, false);
      return userInfo;
    }
  }

  static _onMyselfInfoReceived(store, UserInfo userInfo, [bool fromServer = true]) async {
    if (fromServer) {
      await StorageManager.getInstance().save(
          Config.USERINFO_KEY, json.encode(userInfo.toJson()));
    }
    store?.dispatch(UpdateUserAction(userInfo));
  }
  

  static clearAll() async {
    InitUtils.onUserLogout();
  }
}