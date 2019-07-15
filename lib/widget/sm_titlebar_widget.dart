import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/widget/index.dart';

class SMTitleBarWidget extends StatefulWidget implements PreferredSizeWidget{
  final Widget leftWidget;
  final VoidCallback leftLick;
  final String title;
  final String rightTitle;
  final Widget rightWidget;
  final VoidCallback rightClick;
  final bool needLeftBack;
  // 样式
  final bool isDefault; // 默认白底黑字
  final Color bgColor;
  final Color backIconColor;


  SMTitleBarWidget({this.leftWidget, this.leftLick, this.title, this.rightTitle, this.rightWidget, this.rightClick, this.isDefault = true, this.bgColor, this.backIconColor, this.needLeftBack = true});

  @override
  _SMTitleBarWidgetState createState() => _SMTitleBarWidgetState();

  @override
  Size get preferredSize => Size.fromHeight(Style.containH);
}

class _SMTitleBarWidgetState extends State<SMTitleBarWidget>{

  @override
  Widget build(BuildContext context) {
    SMTextStyle titleTextStyle = widget.isDefault ? SMTxtStyle.middleTextBold :SMTxtStyle.middleTextWhiteBold;
    SMTextStyle rightTitleTextStyle = widget.isDefault ? SMTxtStyle.smallText :SMTxtStyle.smallTextWhite;
    Color containBg = widget.bgColor != null ? widget.bgColor : (widget.isDefault ? SMColors.white : SMColors.black);
    Color backIconColor = widget.backIconColor != null ? widget.backIconColor : (widget.isDefault ? SMColors.black : SMColors.white);

    return Container(
      color: containBg,
      height: Style.containH + ScreenUtil.getInstance().statusBarHeight,
      padding: EdgeInsets.only(top: ScreenUtil.getInstance().statusBarHeight, left: Style.containPadHori, right: Style.containPadHori),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          /*左边*/
          Container(
//            color: Colors.red,
            width: Style.leftRightContainW,
            alignment: Alignment.centerLeft,
            child: widget.needLeftBack ? GestureDetector(
              onTap: () {
                if (widget.leftWidget == null) {
                  NavigatorUtils.getInstance().pop(context);
                } else {
                  widget.leftLick?.call();
                }
              },
              child: Container(
//                color: Colors.pink,
                padding: EdgeInsets.all(10.0),
                child: widget.leftWidget == null ? Image.asset(SMIcons.COMMON_BACK,width: Style.leftImgSize, height: Style.leftImgSize, fit: BoxFit.contain, color: backIconColor,) : widget.leftWidget,
              ),
            ): Container(),
          ),
          Text(widget.title ??'', style: titleTextStyle),
          /*右边*/
          Container(
//            color: Colors.red,
            width: Style.leftRightContainW,
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                if (widget.rightWidget != null || widget.rightTitle != null) {
                  widget.rightClick?.call();
                }
              },
              child: Container(
//                color: Colors.pink,
                padding: EdgeInsets.all(10.0),
                child: widget.rightWidget == null ? Text(widget.rightTitle ??'', style: rightTitleTextStyle): widget.rightWidget,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Style {
  static double containH = ScreenUtil.getInstance().getWidth(44.0);
  static double containPadBott = ScreenUtil.getInstance().getWidth(5.0);
  static double containPadHori = ScreenUtil.getInstance().getWidth(10.0);
  static double leftImgSize = ScreenUtil.getInstance().getWidth(20.0);
  static double leftRightContainW = ScreenUtil.getInstance().getWidth(100.0);


}
