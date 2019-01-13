// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Taskhall.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Taskhall _$TaskhallFromJson(Map<String, dynamic> json) {
  return Taskhall(
      id: json['id'] as String,
      complete_num: json['complete_num'] as String,
      num: json['num'] as int,
      reward: json['reward'] as int,
      context: json['context'] as String,
      content_type: json['content_type'] as int,
      shot: json['shot'] as int,
      user: json['user'] == null
          ? null
          : UserInfo.fromJson(json['user'] as Map<String, dynamic>),
      isComplete: json['isComplete'] as bool);
}

Map<String, dynamic> _$TaskhallToJson(Taskhall instance) => <String, dynamic>{
      'id': instance.id,
      'complete_num': instance.complete_num,
      'num': instance.num,
      'reward': instance.reward,
      'context': instance.context,
      'content_type': instance.content_type,
      'shot': instance.shot,
      'user': instance.user,
      'isComplete': instance.isComplete
    };
