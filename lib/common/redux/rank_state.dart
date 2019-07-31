import 'package:flutter_smallworld/common/model/test/rank_item_bean.dart';
import 'package:redux/redux.dart';
import 'package:flutter_smallworld/common/model/taskhall/taskhall_result.dart';

class RankState {
  List<RankItem> rankItems;

  RankState(this.rankItems);

  static initStore() {
    return RankState([]);
  }
}

final RankReducer = combineReducers<RankState>([
  TypedReducer<RankState, UpdateRankAction>(_updateRankInfo),
  TypedReducer<RankState, RefreshRankListAction>(_refresh),
  TypedReducer<RankState, LoadMoreRankListAction>(_loadMore),
]);

RankState _updateRankInfo(RankState rankState, action) {
  for (int i = 0; i < rankState.rankItems.length; i++) {
    if (rankState.rankItems[i].user_id == action.rankItem.user_id) {
      rankState.rankItems[i] = action.rankItem;
      break;
    }
  }
  return rankState;
}

class UpdateRankAction {
  final RankItem rankItem;

  UpdateRankAction(this.rankItem);
}

RankState _refresh(RankState rankState, action) {
  rankState.rankItems.clear();
  if (action.list == null) {
    return rankState;
  } else {
    rankState.rankItems.addAll(action.list);
    return rankState;
  }
}

RankState _loadMore(RankState rankState, action) {
  if (action.list == null) {
    return rankState;
  } else {
    rankState.rankItems.addAll(action.list);
    return rankState;
  }
}

class RefreshRankListAction {
  final List<RankItem> list;

  RefreshRankListAction(this.list);
}

class LoadMoreRankListAction {
  final List<RankItem> list;

  LoadMoreRankListAction(this.list);
}
