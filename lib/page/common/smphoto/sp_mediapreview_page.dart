import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_smallworld/widget/index.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'asset_lrucache.dart';

class SPMediaPreviewPage extends StatefulWidget {
  static final String sName = "media_preview";
  List<AssetEntity> assetList;
  int currentIndex;

  SPMediaPreviewPage({@required this.assetList, this.currentIndex = 0});

  @override
  _SPMediaPreviewPageState createState() => new _SPMediaPreviewPageState();
}

class _SPMediaPreviewPageState extends State<SPMediaPreviewPage> {
  bool isToParent = true;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      physics: isToParent
          ? PageScrollPhysics()
          : NeverScrollableScrollPhysics(),
      controller: PageController(initialPage: widget.currentIndex),
      itemBuilder: this._itemBuilder,
      itemCount: widget.assetList.length,
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    AssetEntity entity = widget.assetList[index];
    if (entity.type == AssetType.video) {
      return FutureBuilder(
          future: entity.file,
          builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data != null) {
              return SMVideoPlayer(file: snapshot.data);
            } else {
              return Container();
            }
          });
    }

    Uint8List data =
    AssetLruCache.getData(entity, ScreenUtil.getInstance().screenWidth.floor());

    if (data == null) {
      return FutureBuilder(
          future: entity.thumbDataWithSize(ScreenUtil.getInstance().screenWidth.floor(),
              ScreenUtil.getInstance().screenHeight.floor()),
          builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data != null) {
              AssetLruCache.setData(
                  entity, ScreenUtil.getInstance().screenWidth.floor(), snapshot.data);
              return _buildBody(snapshot.data);
            } else {
              return Container();
            }
          });
    } else {
      return _buildBody(data);
    }
  }

  Widget _buildBody(Uint8List uint8List) {
    return Scaffold(
        backgroundColor: SMColors.black,
        body: Stack(
          children: <Widget>[
            Container(
              child: SMZoomWidget(
                onScaleChange: (scale) {
//                  print('scale:' + scale.toString());
                  if (scale <=1.0) {
                    if (isToParent == false) {
                      this.setState(() {
                        isToParent = true;
                      });
                    }
                  } else {
                    if (isToParent == true) {
                      this.setState(() {
                        isToParent = false;
                      });
                    }
                  }
                },
                child: Image.memory(
                  uint8List,
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
//            RaisedButton(onPressed: () {
//              this.setState(() {
//                isToParent = !isToParent;
//              });
//            }, child: Text('switch'),),
          ],
        )
    );
  }
}
