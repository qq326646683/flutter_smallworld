import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:flutter_smallworld/widget/index.dart';
import 'package:flutter_smallworld/common/utils/index.dart';

class SPHomePage extends StatefulWidget {
  static final String sName = "smphoto_home";

  @override
  _SPHomePageState createState() => _SPHomePageState();
}

class _SPHomePageState extends State<SPHomePage> {
  List<_Album> albumList;

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

    List<AssetPathEntity> albumListRes =
        await PhotoManager.getAssetPathList(hasVideo: true);

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
    NavigatorUtils.getInstance().setContext(context);

    Widget body;
    if (albumList == null) {
      body = Center(
        child: CupertinoActivityIndicator(),
      );
    } else {
      if (albumList.length == 0) {
        body = SMNodataWidget();
      } else {
        body = ListView.builder(
          itemBuilder: _buildItem,
          itemCount: albumList.length,
        );
      }
    }

    return Scaffold(
      appBar: SMTitleBarWidget(
        isDefault: false,
        title: '图片',
        backIconColor: SMColors.lightGolden,
      ),
      body: body,
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    Future<Uint8List> thumbDataWithSize = albumList[index]
        .assetList[albumList[index].assetList.length - 1]
        .thumbDataWithSize(60, 60);
    return FutureBuilder<Uint8List>(
        future: thumbDataWithSize,
        builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            return GestureDetector(
              onTap: () {

              },
              child: Container(
                  decoration:
                      BoxDecoration(border: SMCommonStyle.borderBottom03Gray),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Image.memory(
                            snapshot.data,
                            fit: BoxFit.cover,
                            width: _Style.previewImgSize,
                            height: _Style.previewImgSize,
                          ),
                          SizedBox(
                            width: _Style.marginLeft,
                          ),
                          Text(
                            albumList[index].name,
                            style: SMTxtStyle.smallTextBold,
                          ),
                          SizedBox(
                            width: _Style.marginLeft,
                          ),
                          Text(
                            "(${albumList[index].assetList.length.toString()})",
                            style: SMTxtStyle.smallTextGray,
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Image.asset(SMIcons.COMMON_RIGHT,
                              width: _Style.rightIconSize,
                              height: _Style.rightIconSize),
                          SizedBox(
                            width: _Style.marginLeft,
                          ),
                        ],
                      )
                    ],
                  )),
            );
          } else {
            return Container();
          }
        });
  }
}

class _Style {
  static double previewImgSize = ScreenUtil().getWidth(60);
  static double marginLeft = ScreenUtil().getWidth(5);
  static double rightIconSize = ScreenUtil().getWidth(15);
}

class _Album {
  String name;
  List<AssetEntity> assetList;

  _Album(this.name, this.assetList);
}
