import 'package:redux/redux.dart';
import 'package:flutter_smallworld/common/model/index.dart';
import 'package:flutter_smallworld/page/home/home_tab/HomeTab.dart';

class HomeTabStore {
  Map<HomeTabType, HomeTabData> homeTabDataMap;

  HomeTabStore(this.homeTabDataMap);

  static initStore() {
    Map<HomeTabType, HomeTabData> homeTabDataMap = new Map<HomeTabType, HomeTabData>();
    homeTabDataMap[HomeTabType.tab_near] = new HomeTabData([]);
    homeTabDataMap[HomeTabType.tab_recent] = new HomeTabData([]);
    homeTabDataMap[HomeTabType.tab_new] = new HomeTabData([]);

    return HomeTabStore(
      homeTabDataMap,
    );
  }
}

class HomeTabData {
  List<HomeTabModel> homeTabList;

  HomeTabData(this.homeTabList);

}

final HomeTabReducer = combineReducers<HomeTabStore>([
  TypedReducer<HomeTabStore,  RefreshHomeTabAction>(_refresh),
  TypedReducer<HomeTabStore, LoadMoreHomeTabAction>(_loadMore),
]);


HomeTabStore _refresh(HomeTabStore homeTabStore, RefreshHomeTabAction action) {
  homeTabStore.homeTabDataMap[action.type].homeTabList.clear();
  if (action.list == null) {
    return homeTabStore;
  } else {
    homeTabStore.homeTabDataMap[action.type].homeTabList.addAll(action.list);
    return homeTabStore;
  }
}

HomeTabStore _loadMore(HomeTabStore homeTabStore, LoadMoreHomeTabAction action) {
  if (action.list == null) {
    return homeTabStore;
  } else {
    homeTabStore.homeTabDataMap[action.type].homeTabList.addAll(action.list);
    return homeTabStore;
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