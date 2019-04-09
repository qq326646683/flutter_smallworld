import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/widget/index.dart';

class SMCommonWheelWidget extends StatefulWidget {
  final List<CommonWheelData> dataList;
  final double width;
  final double height;
  final double diameterRatio;
  final int initalIndex;
  final ValueChanged<int> onIndexChange;

  SMCommonWheelWidget(
      {@required this.dataList, this.width, this.height = 160, this.diameterRatio = 1.0, this.initalIndex = 0, this.onIndexChange});

  @override
  _SMCommonWheelWidgetState createState() => _SMCommonWheelWidgetState();
}

class _SMCommonWheelWidgetState extends State<SMCommonWheelWidget> {
  @override
  Widget build(BuildContext context) {
    double width = widget.width ?? ScreenUtil.getInstance().screenWidth;
    return Container(
      color: Colors.white,
      width: width,
      height: widget.height,
      child: Stack(
        alignment: Alignment(0.0, 0.0),
        children: <Widget>[
          Container(
            height: 40.0,
            width: width,
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 0.3, color: SMColors.black),
                  top: BorderSide(width: 0.3, color: SMColors.black)),
            ),
          ),
          ListWheelScrollView(
            diameterRatio: widget.diameterRatio,
            controller: new FixedExtentScrollController(initialItem: widget.initalIndex),
            physics: FixedExtentScrollPhysics(),
            onSelectedItemChanged: (index) {widget.onIndexChange?.call(index);},
            children: widget.dataList.map((CommonWheelData data) {
              return Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        data.text,
                        style: SMTxtStyle.normalText,
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
            itemExtent: 30.0,
          ),
        ],
      ),
    );
  }
}

class CommonWheelData {
  int index;
  String text;

  CommonWheelData(this.index, this.text);
}
