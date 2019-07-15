import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_smallworld/common/model/index.dart';
import 'package:flutter_smallworld/page/home/home_tab/home_tab.dart';

class HomeTabState {
  Map<HomeTabType, HomeTabData> homeTabDataMap;
  PageController homeToDetailController;

  HomeTabState(this.homeTabDataMap, this.homeToDetailController);

  static initStore() {
    Map<HomeTabType, HomeTabData> homeTabDataMap = new Map<HomeTabType, HomeTabData>();
    homeTabDataMap[HomeTabType.tab_near] = new HomeTabData([]);
    homeTabDataMap[HomeTabType.tab_recent] = new HomeTabData([]);
    homeTabDataMap[HomeTabType.tab_new] = new HomeTabData([]);

    return HomeTabState(
      homeTabDataMap,
      new PageController(),
    );
  }
}

class HomeTabData {
  List<HomeTabModel> homeTabList;

  HomeTabData(this.homeTabList);

}

final HomeTabReducer = combineReducers<HomeTabState>([
  TypedReducer<HomeTabState,  RefreshHomeTabAction>(_refresh),
  TypedReducer<HomeTabState, LoadMoreHomeTabAction>(_loadMore),
]);


HomeTabState _refresh(HomeTabState homeTabState, RefreshHomeTabAction action) {
  homeTabState.homeTabDataMap[action.type].homeTabList.clear();
  if (action.list == null) {
    return homeTabState;
  } else {
    homeTabState.homeTabDataMap[action.type].homeTabList.addAll(action.list);
    return homeTabState;
  }
}

HomeTabState _loadMore(HomeTabState homeTabState, LoadMoreHomeTabAction action) {
  if (action.list == null) {
    return homeTabState;
  } else {
    homeTabState.homeTabDataMap[action.type].homeTabList.addAll(action.list);
    return homeTabState;
  }
}

class RefreshHomeTabAction {
  final HomeTabType type;
  final List<HomeTabModel> list;

  RefreshHomeTabAction(this.type, this.list);
}

class LoadMoreHomeTabAction {
  final HomeTabType type;
  final List<HomeTabModel> list;

  LoadMoreHomeTabAction(this.type, this.list);
}