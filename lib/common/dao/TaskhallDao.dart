import 'dart:convert';
import 'package:redux/redux.dart';
import 'package:dio/dio.dart';
import 'package:flutter_smallworld/common/model/index.dart';
import 'package:flutter_smallworld/common/net/HttpManager.dart';
import 'package:flutter_smallworld/common/net/ApiAddress.dart';
import 'package:flutter_smallworld/common/redux/index.dart';



class TaskhallDao{
  static getTaskhallInfo(Store<MainStore> store, {page = 1}) async{

    String url = ApiAddress.getTashhall() +ApiAddress.getPageParams('?', page);
    var res = await HttpManager.netFetch(url, null, Options(method: "get"));
    print(res);
    if (res != null && res.result) {
      if (res.data == null) {
        return null;
      }
      TaskhallResult taskhallResult = TaskhallResult.fromJson(res.data);
      print(taskhallResult.toJson().toString());
      if (page == 1) {
        store.dispatch(new RefreshAction(taskhallResult.list));
      } else {
        store.dispatch(new LoadMoreAction(taskhallResult.list));
      }
      return taskhallResult.list;
    } else {
      return null;
    }
  }
}