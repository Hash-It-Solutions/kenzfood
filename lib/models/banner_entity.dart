
import 'dart:convert';

import '../generated/json/banner_entity.g.dart';
import '../generated/json/base/json_field.dart';

@JsonSerializable()
class BannerEntity {

	late List<BannerData> data=[];
	late String message="";
	@JSONField(name: "return")
	late String xReturn="";
  
  BannerEntity();

  factory BannerEntity.fromJson(Map<String, dynamic> json) => $BannerEntityFromJson(json);

  Map<String, dynamic> toJson() => $BannerEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class BannerData {

	@JSONField(name: "banner_desc_en")
	late String bannerDescEn="";
	@JSONField(name: "banner_image_url")
	late String bannerImageUrl="";
	@JSONField(name: "banner_name_en")
	late String bannerNameEn="";
	late int id=0;
	dynamic status=0;
  
  BannerData();

  factory BannerData.fromJson(Map<String, dynamic> json) => $BannerDataFromJson(json);

  Map<String, dynamic> toJson() => $BannerDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}