import 'package:flutter_smallworld/common/dao/index.dart';
import 'package:flutter_smallworld/common/model/index.dart';
import 'package:flutter_smallworld/common/net/index.dart';
import 'package:flutter_smallworld/common/redux/index.dart';
import 'package:flutter_smallworld/common/utils/index.dart';

class TaskhallService {
  static TaskhallService instance;

  static TaskhallService getInstance() {
    if (instance == null) {
      instance = new TaskhallService();
    }
    return instance;
  }

  Future<ResponseResult<TaskhallResult>> fetchList({int page}) async {
    String param = ApiAddress.getPageParams('?', page);
    ResponseResult<TaskhallResult> response = await TaskhallDao.getTaskhallList(param);

    if (response.isSuccess) {
      TaskhallResult taskhallResult = response.data;
      if (page == 1) {
        CommonUtils.store.dispatch(new RefreshTaskhallAction(taskhallResult.list));
      } else {
        CommonUtils.store.dispatch(new LoadMoreTaskhallAction(taskhallResult.list));
      }
    }

    return response;

  }


}