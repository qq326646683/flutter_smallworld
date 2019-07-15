import 'package:flutter_smallworld/common/dao/index.dart';
import 'package:flutter_smallworld/common/model/index.dart';
import 'package:flutter_smallworld/common/net/index.dart';
import 'package:flutter_smallworld/common/redux/index.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/page/home/home_tab/home_tab.dart';

class HomeTabService {
  static HomeTabService instance;

  static HomeTabService getInstance() {
    if (instance == null) {
      instance = new HomeTabService();
    }
    return instance;
  }

  Future<ResponseResult<HomeTabResult>> fetchList({HomeTabType homeTabType, int page}) async {
    int type = homeTabType == HomeTabType.tab_near ? 3 : homeTabType == HomeTabType.tab_recent ? 1 : 2;

    String param = ApiAddress.getPageParams('?', page) + "&type=${type}";
    ResponseResult<HomeTabResult> response = await HomeTabDao.getHomeTabList(param);

    if (response.isSuccess) {
      HomeTabResult homeTabResult = response.data;
      if (page == 1) {
        CommonUtils.store.dispatch(new RefreshHomeTabAction(homeTabType, homeTabResult.list));
      } else {
        CommonUtils.store.dispatch(new LoadMoreHomeTabAction(homeTabType, homeTabResult.list));
      }
    }

    return response;

  }



}