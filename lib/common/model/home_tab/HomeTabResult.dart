import 'package:json_annotation/json_annotation.dart';

part 'HomeTabResult.g.dart';


@JsonSerializable()
class HomeTabResult extends Object {

  @JsonKey(name: 'total')
  int total;

  @JsonKey(name: 'list')
  List<HomeTabModel> list;

  HomeTabResult(this.total,this.list,);

  factory HomeTabResult.fromJson(Map<String, dynamic> srcJson) => _$HomeTabResultFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HomeTabResultToJson(this);

}


@JsonSerializable()
class HomeTabModel extends Object {

  @JsonKey(name: 'user_id')
  String userId;

  @JsonKey(name: 'nickname')
  String nickname;

  @JsonKey(name: 'zodiac')
  String zodiac;

  @JsonKey(name: 'city')
  String city;

  @JsonKey(name: 'avatar')
  String avatar;

  @JsonKey(name: 'vip')
  int vip;

  @JsonKey(name: 'gender')
  int gender;

  @JsonKey(name: 'is_new')
  bool isNew;

  @JsonKey(name: 'flag_mask')
  int flagMask;

  @JsonKey(name: 'friend_flag')
  int friendFlag;

  @JsonKey(name: 'flag_video')
  int flagVideo;

  @JsonKey(name: 'certify_video')
  CertifyVideo certifyVideo;

  @JsonKey(name: 'flag_invisible')
  int flagInvisible;

  @JsonKey(name: 'offline_at')
  String offlineAt;

  @JsonKey(name: 'flag_online')
  dynamic flagOnline;

  @JsonKey(name: 'age')
  dynamic age;

  @JsonKey(name: 'distance')
  String distance;

  HomeTabModel(this.userId,this.nickname,this.zodiac,this.city,this.avatar,this.vip,this.gender,this.isNew,this.flagMask,this.friendFlag,this.flagVideo,this.certifyVideo,this.flagInvisible,this.offlineAt,this.flagOnline,this.age,this.distance,);

  factory HomeTabModel.fromJson(Map<String, dynamic> srcJson) => _$HomeTabModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HomeTabModelToJson(this);

}


@JsonSerializable()
class CertifyVideo extends Object {

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'video')
  String video;

  @JsonKey(name: 'thumb')
  String thumb;

  @JsonKey(name: 'width')
  String width;

  @JsonKey(name: 'height')
  String height;

  @JsonKey(name: 'duration')
  int duration;

  CertifyVideo(this.id,this.video,this.thumb,this.width,this.height,this.duration,);

  factory CertifyVideo.fromJson(Map<String, dynamic> srcJson) => _$CertifyVideoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CertifyVideoToJson(this);

}


