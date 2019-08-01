import 'package:json_annotation/json_annotation.dart';

import '../index.dart';

part 'cofig_result_entity.g.dart';

@JsonSerializable()
class Entity extends BaseEntity {
  String id;

  String admin_id;

  int status;

  int update_avatar_diamond_cost;

  int change_club_name_diamond;

  int draw_persentage;

  int introduce_percentage;

  int introduce_sub_percentage;

  int daily_packet_min;

  int daily_packet_max;

  int group_packet_min;

  int group_packet_max;

  int world_packet_max_num;

  int baojianchui_start_diamond;

  int baojianchui_stake_max_diamond;

  int world_moment_prices;

  int world_moment_like_prices;

  int baojianchui_calculation;

  int competition_like_prices;

  int preferential_pay_switch;

  int launch_game_vip_restrict;

  int launch_questionnaire_vip_restrict;

  int user_invisible_vip_restrict;

  int club_task_praise_diamond;

  int club1_min_vip_grade;

  int club2_min_vip_grade;

  int club3_min_vip_grade;

  int world_packet_overtime;

  int open_multiple_club_diamond;

  int club_ad_game_praise_diamond;

  double baojianchui_odds_1;

  double baojianchui_odds_2;

  int quick_diamond_receive;

  double quick_money_cost;

  int mask_diamond_receive;

  double mask_money_cost;

  int mask_diamond_receive2;

  double mask_money_cost2;

  int quick_diamond_receive_apple;

  int quick_money_cost_apple;

  int mask_diamond_receive_apple;

  int mask_money_cost_apple;

  int mask_diamond_receive2_apple;

  int mask_money_cost2_apple;

  String withdraw_ticket_cost;

  String withdraw_rmb_receive;

  String exchange_ticket_cost;

  String exchange_diamond_receive;

  String recharge_rmb_cost;

  String recharge_diamond_receive;

  String ios_censor_recharge_rmb_cost;

  String ios_censor_recharge_diamond_receive;

  int worldchat_diamond_cost_1;

  int worldchat_diamond_cost_8;

  int worldbaojianchui_round;

  int worldbaojianchui_start_diamond;

  int worldbaojianchui_max_stake_diamond;

  int worldbaojianchui_min_stake_diamond;

  int worldbaojianchui_need_min_diamond;

  int party_anonymous_vip;

  int hide_user_address_vip;

  int upgrade_super_club_diamond;

  int upgrade_super_club_vip;

  String default_card;

  Entity(
    this.id,
    this.admin_id,
    this.status,
    this.update_avatar_diamond_cost,
    this.change_club_name_diamond,
    this.draw_persentage,
    this.introduce_percentage,
    this.introduce_sub_percentage,
    this.daily_packet_min,
    this.daily_packet_max,
    this.group_packet_min,
    this.group_packet_max,
    this.world_packet_max_num,
    this.baojianchui_start_diamond,
    this.baojianchui_stake_max_diamond,
    this.world_moment_prices,
    this.world_moment_like_prices,
    this.baojianchui_calculation,
    this.competition_like_prices,
    this.preferential_pay_switch,
    this.launch_game_vip_restrict,
    this.launch_questionnaire_vip_restrict,
    this.user_invisible_vip_restrict,
    this.club_task_praise_diamond,
    this.club1_min_vip_grade,
    this.club2_min_vip_grade,
    this.club3_min_vip_grade,
    this.world_packet_overtime,
    this.open_multiple_club_diamond,
    this.club_ad_game_praise_diamond,
    this.baojianchui_odds_1,
    this.baojianchui_odds_2,
    this.quick_diamond_receive,
    this.quick_money_cost,
    this.mask_diamond_receive,
    this.mask_money_cost,
    this.mask_diamond_receive2,
    this.mask_money_cost2,
    this.quick_diamond_receive_apple,
    this.quick_money_cost_apple,
    this.mask_diamond_receive_apple,
    this.mask_money_cost_apple,
    this.mask_diamond_receive2_apple,
    this.mask_money_cost2_apple,
    this.withdraw_ticket_cost,
    this.withdraw_rmb_receive,
    this.exchange_ticket_cost,
    this.exchange_diamond_receive,
    this.recharge_rmb_cost,
    this.recharge_diamond_receive,
    this.ios_censor_recharge_rmb_cost,
    this.ios_censor_recharge_diamond_receive,
    this.worldchat_diamond_cost_1,
    this.worldchat_diamond_cost_8,
    this.worldbaojianchui_round,
    this.worldbaojianchui_start_diamond,
    this.worldbaojianchui_max_stake_diamond,
    this.worldbaojianchui_min_stake_diamond,
    this.worldbaojianchui_need_min_diamond,
    this.party_anonymous_vip,
    this.hide_user_address_vip,
    this.upgrade_super_club_diamond,
    this.upgrade_super_club_vip,
    this.default_card,
  );

  factory Entity.fromJson(Map<String, dynamic> srcJson) =>
      _$EntityFromJson(srcJson);
}
