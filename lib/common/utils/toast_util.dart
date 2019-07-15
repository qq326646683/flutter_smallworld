import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/widget/index.dart';
import 'package:oktoast/oktoast.dart';
const int toastDuration = 1500;

class ToastUtil {
  static ToastFuture showRed(String msg) {
    return showToastWidget(
      SMToastWidget(
        color: SMColors.toastRed,
        content: msg,
      ),
      duration: Duration(milliseconds: toastDuration),
    );

  }

  static ToastFuture showGreen(String msg) {
    return showToastWidget(
      SMToastWidget(
        color: SMColors.toastGreen,
        content: msg,
      ),
      duration: Duration(milliseconds: toastDuration),
    );
  }
}
