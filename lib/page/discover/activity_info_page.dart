import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_smallworld/common/config/config.dart';
import 'package:flutter_smallworld/common/model/test/cofig_result_entity.dart';
import 'package:flutter_smallworld/common/redux/index.dart';
import 'package:flutter_smallworld/common/service/activity_info_service.dart';
import 'package:flutter_smallworld/common/utils/index.dart';

import '../../common/model/http/response_result.dart';

/// created by flyaswind
/// Date:2019/7/29
///
class ActivityInfoPage extends StatefulWidget {
  static final String sName = "ActivityInfoPage";

  @override
  _ActivityInfoPageState createState() => _ActivityInfoPageState();
}

class _ActivityInfoPageState extends State<ActivityInfoPage> {

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<Null> _initData() async {
    Future.delayed(Duration(milliseconds: Config.JUMP_PAGE_DELAY), () {
      ActivityInfoService.getInstance().fetchActivityInfo();

    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<MainStore>(builder: (context, store) {
      Entity configResult = CommonUtils.store.state.configState.configEntity;
      String result = "";
      if (configResult != null) {
        result += "configResult.id: " + configResult.id + "\n";
        result += "configResult.admin_id: " + configResult.admin_id + "\n";
        result += "configResult.status: " + configResult.status.toString() + "\n";
        result += "configResult.update_avatar_diamond_cost: " +
            configResult.update_avatar_diamond_cost.toString() +
            "\n";
        result += "configResult.change_club_name_diamond: " +
            configResult.change_club_name_diamond.toString() +
            "\n";
        result += "configResult.draw_persentage: " +
            configResult.draw_persentage.toString() +
            "\n";
      }
      return Scaffold(
        body: Center(
          child: Text(result),
        ),
      );
    });
  }
}
