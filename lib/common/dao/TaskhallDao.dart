import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_smallworld/common/model/index.dart';
import 'package:flutter_smallworld/common/net/HttpManager.dart';
import 'package:flutter_smallworld/common/net/ApiAddress.dart';



class TaskhallDao{
  static getTaskhallInfo({page = 1}) async{

    String url = ApiAddress.getTashhall() +ApiAddress.getPageParams('?', page);
    print('ress::11');
    var res = await HttpManager.netFetch(url, null, Options(method: "get"));
    print('res::22');
    print(res);
  }
}