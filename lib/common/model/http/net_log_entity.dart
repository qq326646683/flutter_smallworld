import 'package:flutter_smallworld/common/net/index.dart';
import 'package:json_annotation/json_annotation.dart';

part 'net_log_entity.g.dart';

@JsonSerializable()
class NetLogEntityList {
  List<NetLogEntity> netLogEntityList;

  NetLogEntityList(
      {this.netLogEntityList});

  factory NetLogEntityList.fromJson(Map<String, dynamic> json) =>
      _$NetLogEntityListFromJson(json);

  Map<String, dynamic> toJson() => _$NetLogEntityListToJson(this);

  NetLogEntityList.empty();
}

@JsonSerializable()
class NetLogEntity {
  String url;
  DateTime requestTime;
  String method;
  int status;
  String timeLine;
  String requestHeader;
  String requestBody;
  DateTime responseTime;
  String responseBody;
  String error;
  DateTime errorTime;

  NetLogEntity(
      {this.url,
        this.requestTime,
        this.method,
        this.status,
        this.responseTime,
        this.requestHeader,
        this.requestBody,
        this.responseBody,
        this.error,
        this.errorTime});


  factory NetLogEntity.fromJson(Map<String, dynamic> json) =>
      _$NetLogEntityFromJson(json);

  Map<String, dynamic> toJson() => _$NetLogEntityToJson(this);

  NetLogEntity.empty();
}
