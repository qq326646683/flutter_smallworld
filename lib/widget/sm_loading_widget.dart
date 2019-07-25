import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SMLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double headerContainerH = ScreenUtil.getInstance().getWidth(44.0);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          width:  ScreenUtil.getInstance().screenWidth,
          height: ScreenUtil.getInstance().screenHeight - headerContainerH - ScreenUtil.getInstance().statusBarHeight,
          color: SMColors.transparent,
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: headerContainerH / 2 + ScreenUtil.getInstance().statusBarHeight),
          child: Container(
            width: ScreenUtil.getInstance().getWidth(90.0),
            height: ScreenUtil.getInstance().getWidth(90.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: SMColors.opacity75Cover,
                borderRadius: BorderRadius.all(Radius.circular(5.0))
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                true ? SpinKitDoubleBounce(
                  color: Colors.white,
                  size: ScreenUtil.getInstance().getWidth(40.0),
                ): Container(),
                SizedBox(height: 5.0,),
                Text('加载中...', style: SMTxtStyle.smallSubLightText)
              ],
            ),
          ),
        ),
      ],
    );
  }
}