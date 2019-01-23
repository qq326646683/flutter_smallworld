import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_smallworld/common/utils/index.dart';


class OverlayUtil {
  static showPop({@required Widget child, barrierDismissible = false, barrierColor = SMColors.opacity60CoverWhite}) {
    showGeneralDialog(
        context: NavigatorUtils.getInstance().getContext(),
        pageBuilder: (context, animation, secondaryAnimation) {
          return Dialog(
            child: child,
            shape: RoundedRectangleBorder(
                borderRadius: SMCommonStyle.borderRadius5
            ),
          );
        },
        barrierDismissible: barrierDismissible,
        barrierLabel: '',
        barrierColor: barrierColor,
        transitionDuration: Duration(milliseconds: 100)
    );
  }

  static showPull(Widget child) {
    showCupertinoModalPopup(
        context: NavigatorUtils.getInstance().getContext(),
        builder: (BuildContext context) {
          return child;
        }
    );
  }
}