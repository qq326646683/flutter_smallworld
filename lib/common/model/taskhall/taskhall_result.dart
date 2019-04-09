import 'package:json_annotation/json_annotation.dart';
import 'taskhall.dart';
import 'taskhall_progress.dart';

part 'taskhall_result.g.dart';

@JsonSerializable()
class TaskhallResult {
  TaskhallProgress progress;

  List<Taskhall> list;

  TaskhallResult({this.progress, this.list});

  factory TaskhallResult.fromJson(Map<String, dynamic> json) =>
      _$TaskhallResultFromJson(json);

  Map<String, dynamic> toJson() => _$TaskhallResultToJson(this);

  TaskhallResult.empty();
}
