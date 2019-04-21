import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/utils/index.dart';

class AlbumNumCheckBox extends StatelessWidget {
  int num;

  AlbumNumCheckBox({this.num});
  
  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.center,
      width: _Style.containerSize,
      height: _Style.containerSize,
      decoration: BoxDecoration(
        border: SMCommonStyle.border05White,
        borderRadius: SMCommonStyle.borderRadius10,
        color: num != null ? SMColors.darkGolden : Colors.transparent,
      ),
      child: num != null ? Text(num.toString(), style: SMTxtStyle.smallText,) : Container(),
    );
  }
}


class _Style {
  static double containerSize = ScreenUtil.getInstance().getWidth(20.0);
}
