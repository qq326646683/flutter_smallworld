import 'dart:convert';
import 'package:flutter_smallworld/common/config/config.dart';
import 'package:flutter_smallworld/common/model/index.dart';
import 'package:flutter_smallworld/common/utils/index.dart';

class NetLogService {
  static NetLogService _netLogService;

  static NetLogService getInstance() {
    if (_netLogService == null) {
      _netLogService = new NetLogService();
    }
    return _netLogService;
  }

  saveToSP(NetLogEntity netLogEntity) async{
    String netLogListTxt = await StorageManager.getInstance().get(Config.NETLOG_KEY);
    if (netLogListTxt.isNotEmpty) {
      NetLogEntityList netLogEntityList = NetLogEntityList.fromJson(json.decode(netLogListTxt));
      netLogEntityList.netLogEntityList.add(netLogEntity);
      StorageManager.getInstance().save(Config.NETLOG_KEY, json.encode(netLogEntityList));
    } else {
      StorageManager.getInstance().save(Config.NETLOG_KEY, json.encode(new NetLogEntityList(netLogEntityList: [netLogEntity])));
    }

  }

  Future<NetLogEntityList> getFromSP() async {
    NetLogEntityList targetNetLogEntityList;
    String netLogListTxt = await StorageManager.getInstance().get(Config.NETLOG_KEY);
    if (netLogListTxt.isNotEmpty) {
      NetLogEntityList netLogEntityList = NetLogEntityList.fromJson(json.decode(netLogListTxt));
      targetNetLogEntityList =  netLogEntityList;
    }
    return targetNetLogEntityList;
  }



}