import 'dart:typed_data';
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
  List<_Album> albumList = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      this.getAsset();
    });
  }

  Future getAsset() async {
    bool permissionRes = await PhotoManager.requestPermission();
    if (permissionRes != true) {
      return;
    }

    List<AssetPathEntity> albumListRes = await PhotoManager.getAssetPathList(
        hasVideo: true);

    List<_Album> tmpAlbum = [];
    List<Future<List<AssetEntity>>> futureList = [];
    albumListRes.forEach((album) {
      futureList.add(album.assetList);
    });

    List<List<AssetEntity>> assetLists = await Future.wait(futureList);
    for (int i = 0; i < assetLists.length; i++) {
      tmpAlbum.add(new _Album(albumListRes[i].name, assetLists[i]));
    }

    this.setState(() {
      albumList = tmpAlbum;
    });
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
//    return Container(
//      height: 100,
//      color: Colors.green,
//      child: Row(
//        children: <Widget>[
//          Text(albumList[index].name),
//          Text(albumList[index].assetList.length.toString()),
//        ],
//      ),
//    );
    Future<Uint8List> thumbDataWithSize = albumList[index].assetList[albumList[index].assetList.length - 1]
        .thumbDataWithSize(50, 50);
    return FutureBuilder<Uint8List>(
        future: thumbDataWithSize,
        builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            return Container(
              height: 100,
              color: Colors.green,
              child: Row(
                children: <Widget>[
                  Image.memory(
                    snapshot.data,
                    fit: BoxFit.cover,
                    width: 60,
                    height: 60,
                  ),
                  Text(albumList[index].name),
                  Text(albumList[index].assetList.length.toString()),
                ],
              ),
            );
          } else {
            return Container();
          }
        }
    );
  }
}

class _Album {
  String name;
  List<AssetEntity> assetList;

  _Album(this.name, this.assetList);

}
