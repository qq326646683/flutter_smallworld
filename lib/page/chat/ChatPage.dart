import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/common/redux/index.dart';
import 'package:flutter_smallworld/widget/index.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>
    with AutomaticKeepAliveClientMixin<ChatPage> {
  Map siseMap = {"width": 0.0, "height": 0.0};
  Map positionMap = {"left": 0.0, "top": 0.0};
  List monthsOfTheYear = new List();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 10; i++) {
      monthsOfTheYear.add('aaaaaa' + i.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('render:ChatPage');
    return Container(
      color: Colors.blueAccent,
      child: Column(
        children: <Widget>[
          TestWidget(widthAndHeight: (Map map) {
            this.setState(() {
              siseMap = {
                "width": map['width'].toString(),
                "height": map['height'].toString()
              };
            });
          }),
          Text(
            '宽:${siseMap["width"]}高:${siseMap["height"]}',
            style: SMTextStyle(color: Colors.white, fontSize: 14.0),
          ),
          LayoutBuilder(builder: (BuildContext mContext, BoxConstraints cons) {
            return RaisedButton(
              child: Text('获取我的位置'),
              onPressed: () {
                Offset offset = WidgetUtil.getWidgetLocalToGlobal(mContext);
                print('获取位置');
                this.setState(() {
                  positionMap = {
                    "left": offset.dx,
                    "top": offset.dy,
                  };
                });
              },
            );
          }),
          Text(
            '距离左边:${positionMap["left"]}距离上边:${positionMap["top"]}',
            style: SMTextStyle(color: Colors.white, fontSize: 14.0),
          ),
          RaisedButton(
            onPressed: () {
              Store<MainStore> store = StoreProvider.of(context);
              store.dispatch(updateUserAction(null));
            },
            child: Text('修改userinfoStore为null'),
          ),
          FlatButton(
              onPressed: () {
                ConfirmUtil.showConfirm(
                  context,
                  ConfirmParam(
                      type: 2,
                      title: '权限未开',
                      content: '请前往设置打开权限',
                      sureText: '前往设置',
                      surePress: () {}),
                );
              },
              child: Text('showConfirm')),
          FlatButton(
              onPressed: () {
                OverlayUtil.showPull(
                  context,
                  SMYearWheelWidget(
                    context: context,
                    initalText: '2015',
                    onSureText: (String text) {
                      print('onSureText:' + text);
                    },
                  ),
                );
              },
              child: Text('showPull'))
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class TestWidget extends StatefulWidget {
  final ValueChanged<Map<String, double>> widthAndHeight;

  TestWidget({Key key, this.widthAndHeight}) : super(key: key);

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
