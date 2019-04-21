import 'package:mmkv_flutter/mmkv_flutter.dart';

class StorageUtil {

  static save(String key, value) async {
    MmkvFlutter mmkv = await MmkvFlutter.getInstance();
    mmkv.setString(key, value);
  }

  static get(String key) async {
    MmkvFlutter mmkv = await MmkvFlutter.getInstance();
    return mmkv.getString(key);
  }

  static remove(String key) async {
    MmkvFlutter mmkv = await MmkvFlutter.getInstance();
    mmkv.removeByKey(key);
  }

  static removeAll() async {
    MmkvFlutter mmkv = await MmkvFlutter.getInstance();
    mmkv.clear();

  }
}