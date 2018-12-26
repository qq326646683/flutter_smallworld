import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/common/redux/index.dart';


class ChatPage extends StatefulWidget{
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>  with AutomaticKeepAliveClientMixin<ChatPage>{
  Map siseMap = {
    "width": 0.0,
    "height" : 0.0
  };
  Map positionMap = {
    "left": 0.0,
    "top": 0.0
  };
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<MainStore>(builder: (context, store) {
      return Container(
        color: Colors.purpleAccent,
        child: Column(
          children: <Widget>[
            TestWidget(
              widthAndHeight: (Map map){
                this.setState((){
                  siseMap = {
                    "width": map['width'].toString(),
                    "height" : map['height'].toString()
                  };
                });
              }
            ),
            Text('宽:${siseMap["width"]}高:${siseMap["height"]}',
              style: TextStyle(color: Colors.white, fontSize: 14.0),
            ),
            LayoutBuilder(builder: (BuildContext mContext, BoxConstraints cons) {
              return RaisedButton(
                child: Text('获取我的位置'),
                onPressed: () {
                  Offset offset = WidgetUtil.getWidgetLocalToGlobal(mContext);
                  print('获取位置');
                  this.setState((){
                    positionMap = {
                      "left": offset.dx,
                      "top": offset.dy,
                    };
                  });
                },
              );
            }),
            Text('距离左边:${positionMap["left"]}距离上边:${positionMap["top"]}',
              style: TextStyle(color: Colors.white, fontSize: 14.0),
            ),
          ],
        ),
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}

class TestWidget extends StatefulWidget {
  final ValueChanged<Map<String, double>> widthAndHeight;

  TestWidget({Key key, this.widthAndHeight}): super(key: key);

  @override
  _TestWidgetState createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  String text = '点击改变我的大小';

  WidgetUtil widgetUtil = new WidgetUtil();


  @override
  Widget build(BuildContext context) {
    widgetUtil.asyncPrepare(context, false, (Rect rect) {
      widget.widthAndHeight?.call({'width': rect.width, 'height': rect.height});
    });
    return RaisedButton(
      onPressed: () {
        this.setState(() {
          text = text + 'hehe';
        });
      },
      child: Container(
        child: Text(text),
      ),
    );
  }
}


