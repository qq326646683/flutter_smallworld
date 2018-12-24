// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return UserInfo(
      json['id'] as String,
      json['gender'] as int,
      json['profession'] as String,
      json['birthday'] as String,
      json['education'] as String,
      json['area_code'] as String,
      json['mobile'] as int,
      json['wechat'] as String,
      (json['stature'] as num)?.toDouble(),
      json['asset'] as String,
      json['annual_income'] as String,
      json['lifestyle'] as String,
      json['smoking'] as String,
      json['drinking'] as String,
      json['signature'] as String,
      json['flag_check'] as int,
      json['flag_quick'] as int,
      json['flag_banned'] as int,
      json['latest_leave_time'] as String,
      json['img_show'] as String,
      json['weight'] as int,
      json['bwh'] as String,
      json['interest'] as String,
      is_new: json['is_new'] as bool,
      nickname: json['nickname'] as String,
      avatar: json['avatar'] as String,
      vip: json['vip'] as int,
      city: json['city'] as String,
      age: json['age'] as int,
      zodiac: json['zodiac'] as String,
      credit: json['credit'] as int,
      flag_invisible: json['flag_invisible'] as int);
}

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'avatar': instance.avatar,
      'vip': instance.vip,
      'age': instance.age,
      'city': instance.city,
      'zodiac': instance.zodiac,
      'credit': instance.credit,
      'gender': instance.gender,
      'profession': instance.profession,
      'birthday': instance.birthday,
      'education': instance.education,
      'area_code': instance.area_code,
      'mobile': instance.mobile,
      'wechat': instance.wechat,
      'stature': instance.stature,
      'asset': instance.asset,
      'annual_income': instance.annual_income,
      'lifestyle': instance.lifestyle,
      'smoking': instance.smoking,
      'drinking': instance.drinking,
      'signature': instance.signature,
      'flag_check': instance.flag_check,
      'flag_quick': instance.flag_quick,
      'flag_banned': instance.flag_banned,
      'latest_leave_time': instance.latest_leave_time,
      'img_show': instance.img_show,
      'weight': instance.weight,
      'bwh': instance.bwh,
      'interest': instance.interest,
      'is_new': instance.is_new,
      'flag_invisible': instance.flag_invisible
    };
