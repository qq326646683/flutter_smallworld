import 'package:flutter_smallworld/common/dao/index.dart';
import 'package:flutter_smallworld/common/dao/ranklist_dao.dart';
import 'package:flutter_smallworld/common/model/index.dart';
import 'package:flutter_smallworld/common/model/test/rank_list_result.dart';
import 'package:flutter_smallworld/common/net/index.dart';
import 'package:flutter_smallworld/common/redux/rank_state.dart';
import 'package:flutter_smallworld/common/utils/common_util.dart';

class RankListService {
  static RankListService instance;

  static RankListService getInstance() {
    if (instance == null) {
      instance = new RankListService();
    }
    return instance;
  }

  Future<ResponseResult<RankListResult>> fetchRankList(String type,
      {int page}) async {
    String param = ApiAddress.getPageParams('?', page);
    ResponseResult<RankListResult> response =
        await RankListDao.getRankListList(param, type);

    if (response.isSuccess) {
      RankListResult rankListResult = response.data;
      if (page == 1) {
        CommonUtils.store.dispatch(RefreshRankListAction(rankListResult.list));
      } else {
        CommonUtils.store.dispatch(LoadMoreRankListAction(rankListResult.list));
      }
    }

    return response;
  }
}
