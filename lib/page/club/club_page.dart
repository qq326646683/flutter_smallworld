import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/widget/index.dart';

class ClubPage extends StatefulWidget {
  @override
  _ClubPageState createState() => _ClubPageState();
}

class _ClubPageState extends State<ClubPage>
    with AutomaticKeepAliveClientMixin<ClubPage> {
  static final String sName = "_ClubPageState";

  @override
  void initState() {
    super.initState();
    LogUtil.i(sName,'_ClubPageState');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.greenAccent,
      child: Column(
        children: <Widget>[
          SMTitleBarWidget(
              needLeftBack: false,
              title: '俱乐部',
              rightWidget: Row(
                children: <Widget>[
                  Image.asset(SMIcons.TAB_DISCOVER),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  GestureDetector(
                    onTap: () {
                      LogUtil.i(sName,'aaa');
                    },
                    child: Image.asset(SMIcons.TAB_CLUB_ACTIVE),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
