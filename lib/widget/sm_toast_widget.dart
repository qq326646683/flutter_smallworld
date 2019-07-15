import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/utils/index.dart';

class SMToastWidget extends StatelessWidget {
  final Color color;
  final String content;

  SMToastWidget({this.color, this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: ScreenUtil.getInstance().statusBarHeight + ScreenUtil.getInstance().getWidth(10.0),),
        Container(
          width: ScreenUtil.getInstance().getWidth(335.0),
          height: ScreenUtil.getInstance().getWidth(50.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(ScreenUtil.getInstance().getWidth(5.0)))
          ),
          child: Text(content, style: SMTxtStyle.middleTextWhite,),
        )
      ],
    );
  }
}