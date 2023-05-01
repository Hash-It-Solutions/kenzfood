import 'package:kenz_market_new/generated/json/base/json_convert_content.dart';
import 'package:kenz_market_new/models/banner_entity.dart';

BannerEntity $BannerEntityFromJson(Map<String, dynamic> json) {
	final BannerEntity bannerEntity = BannerEntity();
	final List<BannerData>? data = jsonConvert.convertListNotNull<BannerData>(json['data']);
	if (data != null) {
		bannerEntity.data = data;
	}
	final String? message = jsonConvert.convert<String>(json['message']);
	if (message != null) {
		bannerEntity.message = message;
	}
	final String? xReturn = jsonConvert.convert<String>(json['return']);
	if (xReturn != null) {
		bannerEntity.xReturn = xReturn;
	}
	return bannerEntity;
}

Map<String, dynamic> $BannerEntityToJson(BannerEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['data'] =  entity.data.map((v) => v.toJson()).toList();
	data['message'] = entity.message;
	data['return'] = entity.xReturn;
	return data;
}

BannerData $BannerDataFromJson(Map<String, dynamic> json) {
	final BannerData bannerData = BannerData();
	final String? bannerDescEn = jsonConvert.convert<String>(json['banner_desc_en']);
	if (bannerDescEn != null) {
		bannerData.bannerDescEn = bannerDescEn;
	}
	final String? bannerImageUrl = jsonConvert.convert<String>(json['banner_image_url']);
	if (bannerImageUrl != null) {
		bannerData.bannerImageUrl = bannerImageUrl;
	}
	final String? bannerNameEn = jsonConvert.convert<String>(json['banner_name_en']);
	if (bannerNameEn != null) {
		bannerData.bannerNameEn = bannerNameEn;
	}
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		bannerData.id = id;
	}
	final dynamic? status = jsonConvert.convert<dynamic>(json['status']);
	if (status != null) {
		bannerData.status = status;
	}
	return bannerData;
}

Map<String, dynamic> $BannerDataToJson(BannerData entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['banner_desc_en'] = entity.bannerDescEn;
	data['banner_image_url'] = entity.bannerImageUrl;
	data['banner_name_en'] = entity.bannerNameEn;
	data['id'] = entity.id;
	data['status'] = entity.status;
	return data;
}