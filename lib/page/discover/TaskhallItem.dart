import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/model/index.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/widget/index.dart';

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
  bool isPicTask;
  bool isFullTask;

  @override
  Widget build(BuildContext context) {
    user = widget.taskhall.user;
    taskhall = widget.taskhall;
    isPicTask = taskhall.content_type == 1;
    isFullTask = int.parse(taskhall.complete_num) >= taskhall.num;
    return Container(
      width: ScreenUtil().screenWidth,
      height: TaskhallPageStyle.itemContainerHeight,
      padding: EdgeInsets.only(
          top: TaskhallPageStyle.itemContainerPaddingVertical,
          left: TaskhallPageStyle.itemContainerPaddingVertical,
          right: TaskhallPageStyle.itemContainerPaddingVertical),
      child: Column(
        children: <Widget>[
          /*第一行*/
          Row(
            children: <Widget>[
              /*头像*/
              Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(user.avatar),
                    backgroundColor: Colors.black,
                  ),
                  Positioned(
                      bottom: TaskhallPageStyle.itemVipContainerBottom,
                      right: TaskhallPageStyle.itemVipContainerRight,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: TaskhallPageStyle
                                .itemVipContainerPaddingHorizontal),
                        decoration: BoxDecoration(
                          color: SMColors.darkGolden,
                          borderRadius: BorderRadius.all(Radius.circular(
                              TaskhallPageStyle.itemVipContainerRadius)),
                          border: Border.all(
                              color: SMColors.white,
                              width: TaskhallPageStyle.itemVipContainerBorder),
                        ),
                        child: Text(
                          'V' + user.vip.toString(),
                          style: TaskhallPageStyle.vipText,
                        ),
                      )),
                ],
              ),
              Padding(
                  padding: EdgeInsets.all(
                      TaskhallPageStyle.itemNicknamePaddingLeft)),
              Text(user.nickname, style: TaskhallPageStyle.nicknameText),
            ],
          ),
          /*第二行*/
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 50,
                  height: 15,
                  child: CustomPaint(
                    painter: TrianglePainter(context),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 10),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(SMIcons.TASKHALL_ITEM_BG),
                          fit: BoxFit.fill),
                      borderRadius: BorderRadius.all(
                          Radius.circular(TaskhallPageStyle.itemBorderRadius)),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            SMColors.lightGolden,
                            SMColors.darkGolden
                          ],
                          tileMode: TileMode.repeated),
                    ),
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          isPicTask ? SMIcons.TASK_PICTURE : SMIcons.TASK_VIDEO,
                          width: isPicTask
                              ? TaskhallPageStyle.itemLeftImgPicWid
                              : TaskhallPageStyle.itemLeftImgVideoWid,
                          height: isPicTask
                              ? TaskhallPageStyle.itemLeftImgPicHei
                              : TaskhallPageStyle.itemLeftImgVideoHei,
                          fit: BoxFit.contain,
                        ),
                        /*中间*/
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(taskhall.context,
                                  style: TaskhallPageStyle.contextTextStyle,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis),
                              Text.rich(TextSpan(
                                  children: [
                                    TextSpan(text: '¥ ${taskhall.reward}',
                                        style: SMTxtStyle.largeTextWhite),
                                    TextSpan(text: '  红包奖励',
                                        style: SMTxtStyle.minTextWhite),
                                  ]
                              ))
                            ],
                          ),
                        ),
                        /*右边*/
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            isFullTask
                                ? Container(
                              height: TaskhallPageStyle.itemRightButtonH,
                              padding: SMCommonStyle.btnPadding,
                              decoration: BoxDecoration(
                                  border: SMCommonStyle.border05White,
                                  borderRadius: SMCommonStyle.borderRadius5),
                              child: Text(
                                '名额已满',
                                style: SMTxtStyle.smallTextWhite,
                              ),
                            )
                                : SMButtonWidget(
                              height: TaskhallPageStyle.itemRightButtonH,
                              text: '去完成',
                              gradientColors: [
                                Colors.white,
                                Colors.white
                              ],
                              textStyle: TaskhallPageStyle.toCompleteText,
                              onPress: () {this.doTask();},
                            ),
                            Padding(padding: EdgeInsets.only(top: 3.0)),
                            Text(
                              '已提交 ${taskhall.complete_num}/${taskhall.num}',
                              style: TaskhallPageStyle.microTextStyle,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  doTask() async {
    bool result = await PermissionUtil.deal([PermissionGroup.photos]);
    if (result) {

    }
  }
}
