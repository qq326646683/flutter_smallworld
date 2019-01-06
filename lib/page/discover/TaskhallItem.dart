import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/model/index.dart';
import 'package:flutter_smallworld/common/utils/index.dart';

import 'TaskhallPageStyle.dart';

class TaskhallItem extends StatefulWidget {
  final Taskhall taskhall;
  TaskhallItem({this.taskhall});

  @override
  _TaskhallItemState createState() => _TaskhallItemState();
}

class _TaskhallItemState extends State<TaskhallItem> {
  UserInfo user;
  Taskhall taskhall;

  @override
  Widget build(BuildContext context) {
    user = widget.taskhall.user;
    taskhall = widget.taskhall;
    return Container(
      width: ScreenUtil().screenWidth,
      height: TaskhallPageStyle.itemContainerHeight,
      padding: EdgeInsets.symmetric(
        vertical: TaskhallPageStyle.itemContainerPaddingVertical,
        horizontal: TaskhallPageStyle.itemContainerPaddingVertical,
      ),
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: Colors.white)
      ),
      child: Column(
        children: <Widget>[
          /*第一行*/
          Row(
            children: <Widget>[
              /*头像*/
              Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  CircleAvatar(backgroundImage: NetworkImage(user.avatar),backgroundColor: Colors.black,),
                  Positioned(
                      bottom: TaskhallPageStyle.itemVipContainerBottom,
                      right: TaskhallPageStyle.itemVipContainerRight,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: TaskhallPageStyle.itemVipContainerPaddingHorizontal),
                        decoration: BoxDecoration(
                          color: Color(SMColors.darkGolden),
                          borderRadius: BorderRadius.all(Radius.circular(TaskhallPageStyle.itemVipContainerRadius)),
                          border: Border.all(color: Color(SMColors.white),width: TaskhallPageStyle.itemVipContainerBorder),
                        ),
                        child: Text('V' + user.vip.toString(), style: TaskhallPageStyle.vipText,),
                      )
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(TaskhallPageStyle.itemNicknamePaddingLeft)),
              Text(user.nickname, style: TaskhallPageStyle.nicknameText),
            ],
          ),
          /*第二行*/
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(SMIcons.TASKHALL_ITEM_BG),fit: BoxFit.fill),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(SMColors.lightGolden), Color(SMColors.darkGolden)],
                  tileMode: TileMode.repeated
                )
              ),
              child: Row(
                children: <Widget>[
                  Image.asset(SMIcons.TASKHALL_BG, width: 80, height: 60,)
                ],
              ),
            ),
          ),
//          Container(
//            color: Colors.deepOrange,
//            child: Row(
//              children: <Widget>[
//
//              ],
//            ),
//          )

        ],
      ),
    );
  }
}
