import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/page/index.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with AutomaticKeepAliveClientMixin<DiscoverPage> {
  @override
  void initState() {
    super.initState();
    NavigatorUtils.getInstance().setContext(context);
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
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
              NavigatorUtils.getInstance().pushNamed(TaskhallPage.sName);
            },
            child: Text('任务大厅'),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
