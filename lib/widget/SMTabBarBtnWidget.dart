import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/utils/index.dart';

class SMTabBarBtnWidget extends StatelessWidget {
  final Widget icon;
  final bool showDot;
  final cirWidth = SMSize.suit(10.0);

  SMTabBarBtnWidget({this.icon, this.showDot});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        icon,
        Positioned(
            right: 0.0,
            child: Container(
              decoration: BoxDecoration(
                color: Color(SMColors.msgTipColor),
                borderRadius: BorderRadius.circular(cirWidth / 2),
              ),
              width: showDot ? cirWidth : 0.0,
              height: showDot ? cirWidth : 0.0,
            ))
      ],
    );
  }
}
