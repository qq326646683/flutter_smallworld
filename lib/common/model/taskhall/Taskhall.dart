import 'package:json_annotation/json_annotation.dart';
import '../user/UserInfo.dart';

part 'Taskhall.g.dart';

@JsonSerializable()
class Taskhall {
  String id;
  String complete_num;
  int num;
  int reward;
  String context;
  int content_type;
  int shot;
  UserInfo user;
  
  Taskhall({
    this.id,
    this.complete_num,
    this.num,
    this.reward,
    this.context,
    this.content_type,
    this.shot,
    this.user
  });

  factory Taskhall.fromJson(Map<String, dynamic> json) =>
      _$TaskhallFromJson(json);

  Map<String, dynamic> toJson() => _$TaskhallToJson(this);

  Taskhall.empty();

}