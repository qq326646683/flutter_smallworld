import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:flutter_smallworld/widget/index.dart';
import 'package:flutter_smallworld/common/utils/index.dart';

class SPHomePage extends StatefulWidget {
  static final String sName = "smphoto_home";

  @override
  _SPHomePageState createState() => _SPHomePageState();
}

class _SPHomePageState extends State<SPHomePage> {
  List<AssetPathEntity> albumList = [];

  @override
  void initState() {
    super.initState();
    this.getAsset();
  }

  Future getAsset() async {
    bool permissionRes = await PhotoManager.requestPermission();
    if (permissionRes != true) {
      return;
    }
    albumList = await PhotoManager.getAssetPathList(hasVideo: true);
    print('albumList');
    print(albumList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SMTitleBarWidget(
        isDefault: false,
        title: '图片',
        backIconColor: SMColors.lightGolden,
      ),
      body: ListView.builder(
        itemBuilder: _buildItem,
        itemCount: albumList.length,
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return Text(albumList[index].name);
  }
}
