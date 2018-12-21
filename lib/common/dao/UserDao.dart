import 'dart:convert';

import 'package:flutter_smallworld/common/net/HttpManager.dart';
import 'package:dio/dio.dart';

class UserDao {
  static login(mobile, password, device) {

    Map requestParams = {
      "mobile" : mobile,
      "password" : password,
      "device" : device
    };

    HttpManager.netFetch('/users/login', json.encode(requestParams), Options(method: "post"));
    
  }
}