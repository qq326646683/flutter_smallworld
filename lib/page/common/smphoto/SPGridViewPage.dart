import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_smallworld/widget/index.dart';
import 'package:flutter_smallworld/page/index.dart';
import 'package:flutter_smallworld/common/utils/index.dart';
import 'package:flutter_smallworld/common/redux/index.dart';
import 'package:redux/redux.dart';
import 'AssetLruCache.dart';

class SPGridViewPage extends StatefulWidget {
  static final String sName = "smphoto_gridview";

  List<AssetEntity> assetList;
  String albumName;

  SPGridViewPage({@required this.assetList, this.albumName});

  @override
  _SPGridViewPageState createState() => _SPGridViewPageState();
}

class _SPGridViewPageState extends State<SPGridViewPage> {
  List<int> indexList;

  @override
  Widget build(BuildContext context) {
    NavigatorUtils.getInstance().setContext(context);
    indexList =
        StoreProvider.of<MainStore>(context).state.smPhotoStore.indexList;

    return StoreBuilder<MainStore>(builder: (context, store) {
      return Scaffold(
        appBar: SMTitleBarWidget(
          isDefault: false,
          title: widget.albumName,
          backIconColor: SMColors.lightGolden,
        ),
        bottomNavigationBar: Container(
          height: _Style.bottomContainH,
          padding: SMCommonStyle.padding10,
          color: SMColors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  this._clickPreview();
                },
                child: Text(
                  '预览',
                  style: indexList.length > 0
                      ? SMTxtStyle.smallTextWhite
                      : _Style.smallTextGray,
                ),
              ),
              Row(
                children: <Widget>[
                  indexList.length > 0
                      ? AlbumNumCheckBox(
                          num: indexList.length,
                        )
                      : Container(),
                  SizedBox(
                    width: SMSize.dp5,
                  ),
                  Text('完成',
                      style: indexList.length > 0
                          ? SMTxtStyle.smallTextLightGolden
                          : SMTxtStyle.smallTextWhite),
                ],
              )
            ],
          ),
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1.0,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0),
          itemBuilder: _buildItem,
          itemCount: widget.assetList.length,
        ),
      );
    });
  }

  Widget _buildItem(BuildContext context, int index) {
    AssetEntity assetEntity = widget.assetList[index];
    Uint8List cacheList = AssetLruCache.getData(assetEntity);
    if (cacheList != null) {
      return this._renderItem(assetEntity, cacheList, index);
    }

    Future<Uint8List> thumbDataWithSize = assetEntity.thumbDataWithSize(60, 60);
    return FutureBuilder(
      future: thumbDataWithSize,
      builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          AssetLruCache.setData(assetEntity, 60, snapshot.data);
          return this._renderItem(assetEntity, snapshot.data, index);
        } else {
          return Container();
        }
      },
    );
  }

  Widget _renderItem(AssetEntity assetEntity, Uint8List list, int index) {
    return GestureDetector(
      onTap: () {
        this._clickItem(index);
      },
      child: Stack(
        children: <Widget>[
          Image.memory(
            list,
            fit: BoxFit.cover,
            width: _Style.previewImgSize,
            height: _Style.previewImgSize,
          ),
          Positioned(
              right: SMSize.dp5,
              top: SMSize.dp5,
              child: GestureDetector(
                onTap: () {
                  this._chickRightTop(index, assetEntity);
                },
                child: AlbumNumCheckBox(
                  num: _getNum(index),
                ),
              )),
          _renderVideoDuration(assetEntity),
        ],
      ),
    );
  }

  _chickRightTop(int index, AssetEntity assetEntity) {
    Store<MainStore> store = StoreProvider.of(context);

    if (indexList.contains(index)) {
      indexList.remove(index);
      store.dispatch(updateIndexListAction(indexList));
    } else {
      indexList.add(index);
      store.dispatch(updateIndexListAction(indexList));
    }
  }

  _clickItem(int index) {
    NavigatorUtils.getInstance().pushNamed(
        SPMediaPreviewPage.sName,
        (context) => SPMediaPreviewPage(
              assetList: widget.assetList,
              currentIndex: index,
            ));
  }

  _clickPreview() {
    if (indexList.length <= 0) {
      return;
    }
    List<AssetEntity> assetList = new List<AssetEntity>();
    for (int i = 0; i < indexList.length; i++) {
      assetList.add(widget.assetList[indexList[i]]);
    }
    NavigatorUtils.getInstance().pushNamed(SPMediaPreviewPage.sName,
        (context) => SPMediaPreviewPage(assetList: assetList));
  }

  int _getNum(int index) {
    if (indexList.contains(index)) {
      return indexList.indexOf(index) + 1;
    } else {
      return null;
    }
  }

  Widget _renderVideoDuration(AssetEntity assetEntity) {
    return FutureBuilder(
        future: assetEntity.videoDuration,
        builder: (BuildContext context, AsyncSnapshot<Duration> snapshot) {
          if (snapshot != null && snapshot.data != null) {
            return Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.videocam,
                      color: SMColors.white,
                    ),
                    Text(
                      TimeUtil.showDuration(snapshot.data),
                      style: SMTxtStyle.minTextWhite,
                    )
                  ],
                ));
          } else {
            return Container();
          }
        });
  }
}

class _Style {
  static double previewImgSize = ScreenUtil().screenWidth / 4;
  static double bottomContainH = ScreenUtil().getWidth(40.0);
  static const smallTextGray = SMTextStyle(
    color: SMColors.grayLineColor,
    fontSize: SMTxtStyle.smallTextSize,
  );
}
