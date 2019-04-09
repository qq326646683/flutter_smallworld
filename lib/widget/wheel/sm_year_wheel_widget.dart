import 'package:flutter/material.dart';
import 'package:flutter_smallworld/widget/index.dart';
import 'package:flutter_smallworld/common/utils/index.dart';

class SMYearWheelWidget extends StatefulWidget {
  final String initalText;
  final BuildContext context;
  final ValueChanged<String> onSureText;


  SMYearWheelWidget({this.initalText, @required this.context, this.onSureText});

  @override
  _SMYearWheelWidgetState createState() => _SMYearWheelWidgetState();
}

class _SMYearWheelWidgetState extends State<SMYearWheelWidget> {
  List<CommonWheelData> sourceData = new List<CommonWheelData>();
  String currentText;

  @override
  void initState() {
    super.initState();
    int thisYear = DateTime.now().year;
    currentText = widget.initalText ?? thisYear.toString();

    for(int i = thisYear; i > thisYear - 10; i--) {
      sourceData.add(new CommonWheelData(thisYear - i, i.toString()));
    }
  }
  
  int getInitalIndexByInitalText() {
    int initIndex = 0;
    for(int i = 0; i< sourceData.length; i++) {
      if(widget.initalText != null && sourceData[i].text == widget.initalText) {
        initIndex = sourceData[i].index;
        break;
      }
    }
    return initIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: SMColors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  NavigatorUtils.getInstance().pop(widget.context);
                },
                child: Text('取消', style: SMTxtStyle.normalText,),
              ),
              FlatButton(
                onPressed: () {
                  widget.onSureText?.call(this.currentText);
                  NavigatorUtils.getInstance().pop(widget.context);
                },
                child: Text('确定', style: SMTxtStyle.normalText,),
              )
            ],
          ),
          SMCommonWheelWidget(
            dataList: sourceData,
            initalIndex: getInitalIndexByInitalText(),
            onIndexChange: (index) {
              this.currentText = sourceData[index].text;
            },
          )
        ],
      ),
    );
  }
}
