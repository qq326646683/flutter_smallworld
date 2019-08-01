import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_smallworld/common/model/test/rank_item_bean.dart';
import 'package:flutter_smallworld/common/redux/main_store.dart';
import 'package:flutter_smallworld/common/redux/rank_state.dart';
import 'package:flutter_smallworld/common/utils/common_util.dart';

/// created by flyaswind
/// Date:2019/7/31
class RankInfoPage extends StatefulWidget {
  static final String sName = "rankInfo";
  final int rankPos;

  RankInfoPage(this.rankPos);

  @override
  _RankInfoPageState createState() => _RankInfoPageState();
}

class _RankInfoPageState extends State<RankInfoPage> {
  @override
  Widget build(BuildContext context) {
    debugPrint("----------------item info build");
    return StoreBuilder<MainStore>(builder: (context, store) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(_getCurrentRankInfo()),
            RaisedButton(
              child: Text("修改当前rank信息"),
              onPressed: () {
                CommonUtils.store
                    .dispatch(UpdateRankAction(_modifyCurrentItem()));
              },
            ),
          ],
        ),
      );
    });
  }

  String _getCurrentRankInfo() {
    RankItem item = StoreProvider.of<MainStore>(context)
        .state
        .rankState
        .rankItems
        .elementAt(widget.rankPos);
    String info = "nickName:  " + item.nickname ?? "";
    info +=
        "\n amount:  " + (item.amount == null ? "" : item.amount.toString());
    return info;
  }

  RankItem _modifyCurrentItem() {
    RankItem item = StoreProvider.of<MainStore>(context)
        .state
        .rankState
        .rankItems
        .elementAt(widget.rankPos);
    var date = DateTime.now().millisecondsSinceEpoch;
    var date1 = DateTime.fromMillisecondsSinceEpoch(date);
    item.nickname =
        item.nickname.split(" modified")[0] + " modified at $date1 ";
    return item;
  }
}
