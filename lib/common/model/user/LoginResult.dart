import 'package:json_annotation/json_annotation.dart';
import 'UserInfo.dart';

part 'LoginResult.g.dart';

@JsonSerializable()
class LoginResult {
  String token;

  @JsonKey(name: "user_info")
  UserInfo userInfo;

  LoginResult(this.token, this.userInfo);

  factory LoginResult.fromJson(Map<String, dynamic> json) =>
      _$LoginResultFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResultToJson(this);

  LoginResult.empty();
}