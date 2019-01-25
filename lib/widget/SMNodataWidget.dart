import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/utils/index.dart';

class SMNodataWidget extends StatelessWidget {
  String imgAsset;
  String text;


  SMNodataWidget({this.imgAsset = SMIcons.PLACE_NODATA, this.text = '暂无数据'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(imgAsset),
          Text(text, style: SMTxtStyle.smallTextGray,)
        ],
      ),
    );
  }
}
