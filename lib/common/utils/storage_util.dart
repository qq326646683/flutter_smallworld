import 'package:mmkv_flutter/mmkv_flutter.dart';

/// 用户无关的本地存储管理类
class StorageManager extends _BaseStorageManager {
  static StorageManager _sInstance;
  StorageManager._();
  static StorageManager getInstance() {
    if (_sInstance == null) {
      _sInstance = StorageManager._();
    }
    return _sInstance;
  }

  removeAll() async {
    MmkvFlutter mmkv = await MmkvFlutter.getInstance();
    mmkv.clear();
  }
}

/// 用户相关的本地存储管理类
class UserStorageManage extends _BaseStorageManager {
  static UserStorageManage _sInstance;
  String _userId;
  UserStorageManage._();
  static UserStorageManage getInstance() {
    if (_sInstance == null) {
      _sInstance = UserStorageManage._();
    }
    return _sInstance;
  }

  init(String userId) {
    _userId = userId;
  }

  bool hasInitialize() => _userId != null && _userId.isNotEmpty;

  @override
  String _getWrapKey(String key) {
    return "${_userId}_$key";
  }
}

class _BaseStorageManager {
  save(String key, String value) async {
    MmkvFlutter mmkv = await MmkvFlutter.getInstance();
    mmkv.setString(_getWrapKey(key), value);
  }

  saveInt(String key, int value) async {
    MmkvFlutter mmkv = await MmkvFlutter.getInstance();
    mmkv.setInt(_getWrapKey(key), value);
  }

  saveLong(String key, int value) async {
    MmkvFlutter mmkv = await MmkvFlutter.getInstance();
    mmkv.setLong(_getWrapKey(key), value);
  }

  saveBool(String key, bool value) async {
    MmkvFlutter mmkv = await MmkvFlutter.getInstance();
    mmkv.setBool(_getWrapKey(key), value);
  }

  get(String key) async {
    MmkvFlutter mmkv = await MmkvFlutter.getInstance();
    return mmkv.getString(_getWrapKey(key));
  }
  Future<int> getInt(String key) async{
    MmkvFlutter mmkv = await MmkvFlutter.getInstance();
    return await mmkv.getInt(_getWrapKey(key));
  }

  Future<int> getLong(String key) async{
    MmkvFlutter mmkv = await MmkvFlutter.getInstance();
    return await mmkv.getLong(_getWrapKey(key));
  }

  Future<bool> getBool(String key) async{
    MmkvFlutter mmkv = await MmkvFlutter.getInstance();
    return await mmkv.getBool(_getWrapKey(key));
  }

  remove(String key) async {
    key = _getWrapKey(key);
    MmkvFlutter mmkv = await MmkvFlutter.getInstance();
    mmkv.removeByKey(key);
  }

  String _getWrapKey(String key) {
    return key;
  }
}