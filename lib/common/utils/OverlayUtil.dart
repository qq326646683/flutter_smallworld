import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_smallworld/common/utils/index.dart';


class OverlayUtil {
  static showPop(Widget child, [barrierDismissible = false]) {
    showGeneralDialog(
        context: NavigatorUtils.getInstance().getContext(),
        pageBuilder: (context, animation, secondaryAnimation) {
          return Dialog(
            child: child,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(SMSize.borderRadius5))
            ),
          );
        },
        barrierDismissible: barrierDismissible,
        barrierLabel: '',
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