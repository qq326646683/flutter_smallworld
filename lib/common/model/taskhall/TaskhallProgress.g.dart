// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TaskhallProgress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskhallProgress _$TaskhallProgressFromJson(Map<String, dynamic> json) {
  return TaskhallProgress(
      today_submit: json['today_submit'] as int,
      submit_limit: json['submit_limit'] as String,
      total_reward_ticket: json['total_reward_ticket'] as int,
      total_reward: json['total_reward'] as int);
}

Map<String, dynamic> _$TaskhallProgressToJson(TaskhallProgress instance) =>
    <String, dynamic>{
      'today_submit': instance.today_submit,
      'submit_limit': instance.submit_limit,
      'total_reward_ticket': instance.total_reward_ticket,
      'total_reward': instance.total_reward
    };
