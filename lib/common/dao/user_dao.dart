import 'dart:convert';
import 'package:flutter_smallworld/common/config/config.dart';
import 'package:flutter_smallworld/common/redux/user_redux.dart';
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

    var res = await HttpManager.netFetch('/users/login', json.encode(requestParams), Options(method: "post"));
    if (res != null && res.result) {
      UserInfo currentUserInfo = LoginResult.fromJson(res.data).userInfo;
      await StorageUtil.save(Config.USERINFO_KEY, json.encode(currentUserInfo.toJson()));

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
      await StorageUtil.save(Config.USERINFO_KEY, json.encode(currentUserInfo.toJson()));
      store.dispatch(updateUserAction(currentUserInfo));
    }

    return DataResult(res.data, res.result);

  }
  
  
  static getUserInfoLocal({store}) async {
    String userTxt = await StorageUtil.get(Config.USERINFO_KEY);
    if (userTxt != null) {
      var userMap = json.decode(userTxt);
      UserInfo userInfo = UserInfo.fromJson(userMap);
      
      store?.dispatch(updateUserAction(userInfo));
      return DataResult(userInfo, true);
    } else {
      return DataResult(null, false);
    }
  }
  

  static clearAll(Store store) async {
    HttpManager.clearToken();
    StorageUtil.remove(Config.USERINFO_KEY);
    store.dispatch(new updateUserAction(UserInfo.empty()));
  }
}