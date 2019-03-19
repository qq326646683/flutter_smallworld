// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HomeTabResult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeTabResult _$HomeTabResultFromJson(Map<String, dynamic> json) {
  return HomeTabResult(
      json['total'] as int,
      (json['list'] as List)
          ?.map((e) => e == null
              ? null
              : HomeTabModel.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$HomeTabResultToJson(HomeTabResult instance) =>
    <String, dynamic>{'total': instance.total, 'list': instance.list};

HomeTabModel _$HomeTabModelFromJson(Map<String, dynamic> json) {
  return HomeTabModel(
      json['user_id'] as String,
      json['nickname'] as String,
      json['zodiac'] as String,
      json['city'] as String,
      json['avatar'] as String,
      json['vip'] as int,
      json['gender'] as int,
      json['is_new'] as bool,
      json['flag_mask'] as int,
      json['friend_flag'] as int,
      json['flag_video'] as int,
      json['certify_video'] == null
          ? null
          : CertifyVideo.fromJson(
              json['certify_video'] as Map<String, dynamic>),
      json['flag_invisible'] as int,
      json['offline_at'] as String,
      json['flag_online'] as dynamic,
      json['age'],
      json['distance'] as String);
}

Map<String, dynamic> _$HomeTabModelToJson(HomeTabModel instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'nickname': instance.nickname,
      'zodiac': instance.zodiac,
      'city': instance.city,
      'avatar': instance.avatar,
      'vip': instance.vip,
      'gender': instance.gender,
      'is_new': instance.isNew,
      'flag_mask': instance.flagMask,
      'friend_flag': instance.friendFlag,
      'flag_video': instance.flagVideo,
      'certify_video': instance.certifyVideo,
      'flag_invisible': instance.flagInvisible,
      'offline_at': instance.offlineAt,
      'flag_online': instance.flagOnline,
      'age': instance.age,
      'distance': instance.distance
    };

CertifyVideo _$CertifyVideoFromJson(Map<String, dynamic> json) {
  return CertifyVideo(
      json['id'] as String,
      json['video'] as String,
      json['thumb'] as String,
      json['width'] as String,
      json['height'] as String,
      json['duration'] as int);
}

Map<String, dynamic> _$CertifyVideoToJson(CertifyVideo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'video': instance.video,
      'thumb': instance.thumb,
      'width': instance.width,
      'height': instance.height,
      'duration': instance.duration
    };
