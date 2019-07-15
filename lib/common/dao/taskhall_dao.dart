import 'dart:convert';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:redux/redux.dart';
import 'package:dio/dio.dart';
import 'package:flutter_smallworld/common/model/index.dart';
import 'package:flutter_smallworld/common/net/http_manager.dart';
import 'package:flutter_smallworld/common/net/api_adress.dart';
import 'package:flutter_smallworld/common/redux/index.dart';



class TaskhallDao{
  static final String sName = "TaskhallDao";

  static getTaskhallList(String param) async{

    ResponseResult<TaskhallResult> response = await HttpManager.netFetch<TaskhallResult>(ApiAddress.getTashhall() + param, null, NetMethod.GET);
    LogUtil.i(sName, 'getTaskhallInfo response: ${response.data.toString()}');
    return response;

  }
}