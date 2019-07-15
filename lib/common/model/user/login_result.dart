import 'package:flutter_smallworld/common/model/index.dart';
import 'package:json_annotation/json_annotation.dart';
import 'userinfo.dart';

part 'login_result.g.dart';

@JsonSerializable()
class LoginResult extends BaseEntity{
  String token;

  @JsonKey(name: "user_info")
  UserInfo userInfo;

  LoginResult(this.token, this.userInfo);

  factory LoginResult.fromJson(Map<String, dynamic> json) =>
      _$LoginResultFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResultToJson(this);

  LoginResult.empty();
}