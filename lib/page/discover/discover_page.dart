import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/page/index.dart';

class DiscoverPage extends StatefulWidget {
  static final String sName = "discover";

  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with AutomaticKeepAliveClientMixin<DiscoverPage> {
  @override
  void initState() {
    super.initState();
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
      color: Colors.blueAccent,
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
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
