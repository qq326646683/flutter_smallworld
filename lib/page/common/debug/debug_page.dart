import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/page/index.dart';
import 'package:flutter_smallworld/widget/index.dart';

class DebugPage extends StatefulWidget {
  static final String sName = "debug";

  @override
  _DebugPageState createState() => _DebugPageState();
}

class _DebugPageState extends State<DebugPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PermissionUtil.deal(context, [PermissionGroup.storage]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SMTitleBarWidget(
        title: 'Debug',
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('请求日志'),
            onTap: () {
              NavigatorUtils.getInstance()
                  .pushNamed(context, NetLogPage.sName);
            },
          ),
          ListTile(
            title: Text('打印日志'),
            onTap: () {
              NavigatorUtils.getInstance()
                  .pushNamed(context, PrintLogPage.sName);
            },
          ),
          ListTile(
            title: Text('应用信息'),
            onTap: () {
              NavigatorUtils.getInstance()
                  .pushNamed(context, PackageInfoPage.sName);
            },
          ),
          ListTile(
            title: Text('视频demo'),
            onTap: () {
              NavigatorUtils.getInstance()
                  .pushNamed(context, VideoDemoPage.sName);
            },
          ),
        ],
      ),
    );
  }
}
