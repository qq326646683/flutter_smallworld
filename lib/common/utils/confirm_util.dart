import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/widget/index.dart';

// http://note.youdao.com/noteshare?id=0e660f7b7c0c323d1ca646c7e1ce7471
class ConfirmUtil {
  static showConfirm(BuildContext context, ConfirmParam param) {
    assert(param.type != null);
    Widget widget;
    switch (param.type) {
      case 2:
        widget = Container(
          height: _Style.type2Height,
          padding: EdgeInsets.all(_Style.containPad),
          decoration: BoxDecoration(
              color: SMColors.black,
              borderRadius: SMCommonStyle.borderRadius5
          ),
          child: Column(
            children: <Widget>[
              Text(param.title, style: SMTxtStyle.largeTextGoldenBold,),
              Padding(padding: SMCommonStyle.padding5,),
              Expanded(
                child: Text(param.content, style: SMTxtStyle.normalTextGolden,),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      child: Container(
                        height: _Style.cancelHeight,
                        padding: SMCommonStyle.btnPadding,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: SMCommonStyle.border05White,
                            borderRadius: SMCommonStyle.borderRadius5
                        ),
                        child: Text(
                          param.cancelText ?? '取消',
                          style: SMTxtStyle.normalTextWhite,
                        ),
                      ),
                      onTap: () {
                        NavigatorUtils.getInstance().pop(context);
                        param.cancelPress?.call();
                      },
                    ),
                  ),
                  Padding(padding: SMCommonStyle.padding5,),
                  Expanded(
                    child: SMButtonWidget(
                      height: _Style.cancelHeight,
                      text: param.sureText ?? '确认',
                      gradientColors: [
                        Colors.white,
                        Colors.white
                      ],
                      textStyle: SMTxtStyle.normalText,
                      onPress: () {
                        NavigatorUtils.getInstance().pop(context);
                        param.surePress?.call();
                      },
                    ),
                  ),


                ],
              ),
            ],
          ),
        );
        break;
    }

    OverlayUtil.showPop(
      context: context,
      child: widget,
    );
  }
}

class _Style {
  static double type2Height = ScreenUtil.getInstance().getWidth(180.0);
  static double containPad = ScreenUtil.getInstance().getWidth(15.0);
  static double cancelHeight = ScreenUtil.getInstance().getWidth(40.0);
}

class ConfirmParam {
  int type;
  String title;
  String content;
  String cancelText;
  String sureText;
  VoidCallback cancelPress;
  VoidCallback surePress;

  ConfirmParam(
      {@required this.type, this.title, this.content, this.cancelText, this.sureText, this.cancelPress, this.surePress});
}