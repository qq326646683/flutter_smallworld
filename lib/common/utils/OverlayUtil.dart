import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_smallworld/common/utils/index.dart';


class OverlayUtil {
  static showPop({@required BuildContext context, @required Widget child, barrierDismissible = false, barrierColor = SMColors.opacity60CoverWhite}) {
    showGeneralDialog(
        context: context,
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

  static showPull(@required BuildContext context, @required Widget child) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return child;
        }
    );
  }
}