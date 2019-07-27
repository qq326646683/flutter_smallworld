import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/page/index.dart';
import 'package:screen/screen.dart';

class DiscoverPage extends StatefulWidget {
  static final String sName = "discover";

  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with AutomaticKeepAliveClientMixin<DiscoverPage> {
  bool _isKeptOn = false;
  double _brightness = 1.0;
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }
  initPlatformState() async {
    bool keptOn = await Screen.isKeptOn;
    double brightness = await Screen.brightness;
    setState((){
      _isKeptOn = keptOn;
      _brightness = brightness;
    });
  }
  @override
  void deactivate() {
    super.deactivate();
    debugPrint("----disocer deactivate");
  }
  @override
  Widget build(BuildContext context) {
    debugPrint("----disocer build");
    return Container(
      color: Colors.greenAccent,
      child: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              NavigatorUtils.getInstance().pushNamed(context, TaskhallPage.sName);
            },
            child: Text('任务大厅'),
          ),
          RaisedButton(
            onPressed: () {
              NavigatorUtils.getInstance().pushNamed(context, DebugPage.sName);
            },
            child: Text('Debug'),
          ),
          CircularProgressIndicator(
            strokeWidth: 2,
              backgroundColor: SMColors.lightGolden,
              value: 0.8,
          ),
          Checkbox(value: _isKeptOn, onChanged: (bool b){
            Screen.keepOn(b);
            setState((){_isKeptOn = b; });
           }),
//          Slider(max: 1,value : _brightness, onChanged : (double b){
//            setState((){_brightness = b;});
//            Screen.setBrightness(b);
//          })
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
