import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_smallworld/common/redux/config_state.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/page/index.dart';
import 'package:screen/screen.dart';

import 'activity_info_page.dart';
import 'package:flutter_smallworld/common/redux/index.dart';
import 'package:redux/redux.dart';

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
    setState(() {
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
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Container(
        color: Colors.greenAccent,
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                NavigatorUtils.getInstance()
                    .pushNamed(context, ActivityInfoPage.sName);
              },
              child: Text('活动信息'),
            ),
            RaisedButton(
              onPressed: () {
                Store<MainStore> store = StoreProvider.of(context);
                store.dispatch(UpdateConfigAction(null));
              },
              child: Text('置空redux中config'),
            ),
            Text(_getReduxConfigState()),
            RaisedButton(
              onPressed: () {
                NavigatorUtils.getInstance()
                    .pushNamed(context, TaskhallPage.sName);
              },
              child: Text('任务大厅'),
            ),
            RaisedButton(
              onPressed: () {
                NavigatorUtils.getInstance()
                    .pushNamed(context, DebugPage.sName);
              },
              child: Text('Debug'),
            ),
            CircularProgressIndicator(
              strokeWidth: 2,
              backgroundColor: SMColors.lightGolden,
              value: 0.8,
            ),
            Checkbox(
                value: _isKeptOn,
                onChanged: (bool b) {
                  Screen.keepOn(b);
                  setState(() {
                    _isKeptOn = b;
                  });
                }),
//          Slider(max: 1,value : _brightness, onChanged : (double b){
//            setState((){_brightness = b;});
//            Screen.setBrightness(b);
//          })
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  String _getReduxConfigState() {
    Store<MainStore> store = StoreProvider.of(context);
    String configTextInReduxStore = "redux中config信息：";
    if (store != null &&
        store.state != null &&
        store.state.configState != null &&
        store.state.configState.configEntity != null) {
      configTextInReduxStore +=
          "\n configEntity id:" + store.state.configState.configEntity.id;
    }
    return configTextInReduxStore;
  }
}
