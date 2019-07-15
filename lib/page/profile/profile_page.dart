import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/common/redux/index.dart';
import 'package:flutter_smallworld/common/model/index.dart';
import 'package:flutter_smallworld/widget/index.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin<ProfilePage> {
  static final String sName = "_ChatPageState";

  @override
  Widget build(BuildContext context) {
    super.build(context);
    LogUtil.i(sName,'render:ProfilePage');
    UserInfo userInfo = StoreProvider.of<MainStore>(context).state.userState.userInfo;
    LogUtil.i(sName,userInfo.toString());
    return Container(
      color: Colors.purpleAccent,
      child: Column(
        children: <Widget>[
          SMTitleBarWidget(
            needLeftBack: false,
            bgColor: Colors.transparent,
            rightWidget: Row(
              children: <Widget>[
                Image.asset(SMIcons.TAB_DISCOVER),
                Padding(padding: EdgeInsets.all(10),),
                GestureDetector(
                  onTap: () {
                    LogUtil.i(sName,'aaa');
                  },
                  child: Image.asset(SMIcons.TAB_CLUB_ACTIVE),
                ),
              ],
            )
          ),
          Text(
            userInfo != null
                ? userInfo.toJson().toString()
                : 'deffff',
            style: SMTextStyle(color: Colors.white, fontSize: 14.0),
          ),
        ],
      ),
    );
    ;
  }

  @override
  bool get wantKeepAlive => true;
}
