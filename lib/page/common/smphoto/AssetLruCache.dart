import 'dart:typed_data';
import 'package:quiver/collection.dart';
import 'PhotoManager.dart';
class AssetLruCache {
  static LruMap<_AssetCacheEntity, Uint8List> _map = LruMap<_AssetCacheEntity, Uint8List>();

  static Uint8List getData(AssetEntity entity, [int size = 60]) {
    return _map[_AssetCacheEntity(entity, size)];
  }

  static void setData(AssetEntity entity, int size, Uint8List list) {
    _map[_AssetCacheEntity(entity, size)] = list;
  }

}

class _AssetCacheEntity {
  AssetEntity entity;
  int size;
  _AssetCacheEntity(this.entity, this.size);


  @override
  bool operator ==(other) {
    return identical(this, other) ||
      this is _AssetCacheEntity &&
    runtimeType == other.runtimeType &&
    entity == other.entity &&
    size == other.size;
  }

  @override
  int get hashCode => entity.hashCode ^ size.hashCode;

}