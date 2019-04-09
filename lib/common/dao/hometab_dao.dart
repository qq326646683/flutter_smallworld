import 'package:redux/redux.dart';
import 'package:dio/dio.dart';
import 'package:flutter_smallworld/common/model/index.dart';
import 'package:flutter_smallworld/common/net/http_manager.dart';
import 'package:flutter_smallworld/common/net/api_adress.dart';
import 'package:flutter_smallworld/common/redux/index.dart';
import 'package:flutter_smallworld/page/home/home_tab/home_tab.dart';



class HomeTabDao{
  static getHomeTabList(Store<MainStore> store, HomeTabType homeTabType, {page = 1}) async{

    int type = homeTabType == HomeTabType.tab_near ? 3 : homeTabType == HomeTabType.tab_recent ? 1 : 2;

    String url = ApiAddress.getHomeTab() + ApiAddress.getPageParams('?', page) + '&type=${type}';
    var res = await HttpManager.netFetch(url, null, Options(method: "get"));
    if (res != null && res.result) {
      if (res.data == null) {
        return null;
      }
      HomeTabResult homeTabResult = HomeTabResult.fromJson(res.data);
      print(homeTabResult.toJson().toString());
      if (page == 1) {
        store.dispatch(new RefreshHomeTabAction(homeTabType, homeTabResult.list));
      } else {
        store.dispatch(new LoadMoreHomeTabAction(homeTabType, homeTabResult.list));
      }
      return homeTabResult.list;
    } else {
      return null;
    }
  }
}