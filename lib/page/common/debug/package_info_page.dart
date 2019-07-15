import 'package:flutter/material.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/widget/index.dart';
import 'package:package_info/package_info.dart';


class PackageInfoPage extends StatefulWidget {
  static final String sName = "package_info";

  @override
  _PackageInfoPageState createState() => _PackageInfoPageState();
}

class _PackageInfoPageState extends State<PackageInfoPage> {
  PackageInfo packageInfo = new PackageInfo();

  @override
  void initState() {
    super.initState();
    getPackageInfo();
  }

  getPackageInfo() async {
    packageInfo = await PackageInfo.fromPlatform();
    LogUtil.i(PackageInfoPage.sName, 'packageInfo::');
    LogUtil.i(PackageInfoPage.sName, packageInfo);
    this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SMTitleBarWidget(
          title: '应用信息',
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
//              ListTile(title: Text('appName', style: SMTxtStyle.middleTextRed), subtitle: Text(packageInfo.appName ?? '', style: SMTxtStyle.smallText,)),
              ListTile(title: Text('packageName', style: SMTxtStyle.middleTextRed), subtitle: Text(packageInfo.packageName?? '', style: SMTxtStyle.smallText,)),
              ListTile(title: Text('version', style: SMTxtStyle.middleTextRed), subtitle: Text(packageInfo.version?? '', style: SMTxtStyle.smallText,)),
              ListTile(title: Text('buildNumber', style: SMTxtStyle.middleTextRed), subtitle: Text(packageInfo.buildNumber?? '', style: SMTxtStyle.smallText,)),
            ],
          ),
        ));
  }
}
