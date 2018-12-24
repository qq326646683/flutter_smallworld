// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return UserInfo(json['id'] as String,
      gender: json['gender'] as int,
      profession: json['profession'] as String,
      birthday: json['birthday'] as String,
      education: json['education'] as String,
      area_code: json['area_code'] as String,
      mobile: json['mobile'] as String,
      wechat: json['wechat'] as String,
      stature: (json['stature'] as num)?.toDouble(),
      asset: json['asset'] as String,
      annual_income: json['annual_income'] as String,
      lifestyle: json['lifestyle'] as String,
      smoking: json['smoking'] as String,
      drinking: json['drinking'] as String,
      signature: json['signature'] as String,
      flag_check: json['flag_check'] as int,
      flag_quick: json['flag_quick'] as int,
      flag_banned: json['flag_banned'] as int,
      latest_leave_time: json['latest_leave_time'] as String,
      img_show: json['img_show'] as String,
      weight: json['weight'] as int,
      bwh: json['bwh'] as String,
      interest: json['interest'] as String,
      is_new: json['is_new'] as bool,
      nickname: json['nickname'] as String,
      avatar: json['avatar'] as String,
      vip: json['vip'] as int,
      city: json['city'] as String,
      age: json['age'] as int,
      zodiac: json['zodiac'] as String,
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
