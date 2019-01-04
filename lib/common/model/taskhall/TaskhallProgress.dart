import 'package:json_annotation/json_annotation.dart';

part 'TaskhallProgress.g.dart';

@JsonSerializable()
class TaskhallProgress {
  int today_submit;
  String submit_limit;
  int total_reward_ticket;
  int total_reward;

  TaskhallProgress({
    this.today_submit,
    this.submit_limit,
    this.total_reward_ticket,
    this.total_reward
  });

  factory TaskhallProgress.fromJson(Map<String, dynamic> json) =>
      _$TaskhallProgressFromJson(json);

  Map<String, dynamic> toJson() => _$TaskhallProgressToJson(this);

  TaskhallProgress.empty();
}