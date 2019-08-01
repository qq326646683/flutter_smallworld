import 'package:flutter_smallworld/common/model/test/rank_item_bean.dart';

/// created by flyaswind
/// Date:2019/7/30

import 'package:json_annotation/json_annotation.dart';

import '../entity_factory.dart';

part 'rank_list_result.g.dart';

@JsonSerializable()
class RankListResult extends BaseEntity {
  int total;

  List<RankItem> list;

  RankListResult(
    this.total,
    this.list,
  );

  factory RankListResult.fromJson(Map<String, dynamic> srcJson) =>
      _$RankListResultFromJson(srcJson);
}
