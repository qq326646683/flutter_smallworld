import 'package:json_annotation/json_annotation.dart';

part 'rank_item_bean.g.dart';

@JsonSerializable()
class RankItem {
  int is_new;

  int rank_flag;

  int ranking;

  int rank_change;

  var amount;

  String user_id;

  String nickname;

  String avatar;

  String vip;

  RankItem(
    this.is_new,
    this.rank_flag,
    this.ranking,
    this.rank_change,
    this.amount,
    this.user_id,
    this.nickname,
    this.avatar,
    this.vip,
  );

  factory RankItem.fromJson(Map<String, dynamic> srcJson) =>
      _$RankItemFromJson(srcJson);
}
