import 'package:json_annotation/json_annotation.dart';

part 'userinfo.g.dart';

@JsonSerializable()
class UserInfo {
  // 用户id
  String id;

  //用户昵称
  String nickname;

  // 头像链接
  String avatar;

  // 用户vip等级
  int vip;

  // 用户年龄
  int age;

  // 城市
  String city;

  // 星座
  String zodiac;

  // 性别，1 - 男；0 - 女
  int gender;

  // 用户职业
  String profession;

  // 用户生日
  String birthday;

  // 用户学历
  String education;

  // No
  String area_code;

  // 手机号
  String mobile;

  // 微信号
  String wechat;

  // 身高，单位cm
  double stature;

  // 总资产
  String asset;

  // 年收入
  String annual_income;

  // 生活品质
  String lifestyle;

  // 吸烟习惯
  String smoking;

  // 饮酒习惯
  String drinking;

  // 个人签名
  String signature;

  // 是否已验证，2 已通过；1 已提交；0 未提交；-1 被拒绝
  int flag_check;

  // 是否加速：1 是；0 否；
  int flag_quick;

  // 用户封禁标识，1 被封禁；0 未被封禁
  int flag_banned;

  // 用户用户最后一次离开App的时间，Y - m - d H: i: s, 后台获取数据时返回，没有返回null
  String latest_leave_time;

  //  用户审核图片
  String img_show;

  // 体重kg
  int weight;

  // 三围
  String bwh;

  // 兴趣爱好
  String interest;

  // 新人
  bool is_new;

  // 是否隐身
  int flag_invisible;

  UserInfo(this.id,
      {this.gender,
      this.profession,
      this.birthday,
      this.education,
      this.area_code,
      this.mobile,
      this.wechat,
      this.stature,
      this.asset,
      this.annual_income,
      this.lifestyle,
      this.smoking,
      this.drinking,
      this.signature,
      this.flag_check,
      this.flag_quick,
      this.flag_banned,
      this.latest_leave_time,
      this.img_show,
      this.weight,
      this.bwh,
      this.interest,
      this.is_new,
      this.nickname,
      this.avatar,
      this.vip,
      this.city,
      this.age,
      this.zodiac,
      this.flag_invisible});

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);

  UserInfo.empty();
}
