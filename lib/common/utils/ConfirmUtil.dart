import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/widget/index.dart';

// http://note.youdao.com/noteshare?id=0e660f7b7c0c323d1ca646c7e1ce7471
class ConfirmUtil {
  static showConfirm(ConfirmParam param) {
    assert(param.type != null);
    Widget widget;
    switch (param.type) {
      case 2:
        widget = Container(
          height: 200,
          decoration: BoxDecoration(
            color: Color(SMColors.black),
            borderRadius: BorderRadius.all(Radius.circular(SMSize.borderRadius5))
          ),
          child: Column(
            children: <Widget>[
              Text(param.title, style: SMTxtStyle.normalTextBoldWhite,),
              Text(param.content, style: SMTxtStyle.smallTextWhite,),
              Row(
                children: <Widget>[
                  SMButtonWidget(
//                    height: TaskhallPageStyle.itemRightButtonH,
                    text: param.sureText ?? '确认',
                    gradientColors: [
                      Colors.white,
                      Colors.white
                    ],
                    textStyle: SMTxtStyle.normalText,
                    onPress: () {
                      Navigator.pop(NavigatorUtils.getInstance().getContext());
                      param.surePress?.call();
                    },
                  )
                ],
              ),
            ],
          ),
        );
        break;
    }

    OverlayUtil.showPop(widget);
  }
}

class ConfirmParam {
  int type;
  String title;
  String content;
  String cancelText;
  String sureText;
  VoidCallback cancelPress;
  VoidCallback surePress;
  ConfirmParam({@required this.type, this.title, this.content, this.cancelText, this.sureText, this.cancelPress, this.surePress});
}