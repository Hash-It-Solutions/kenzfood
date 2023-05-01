import 'package:kenz_market_new/generated/json/base/json_convert_content.dart';
import 'package:kenz_market_new/models/notification_list_entity.dart';

NotificationListEntity $NotificationListEntityFromJson(Map<String, dynamic> json) {
	final NotificationListEntity notificationListEntity = NotificationListEntity();
	final List<NotificationListData>? data = jsonConvert.convertListNotNull<NotificationListData>(json['data']);
	if (data != null) {
		notificationListEntity.data = data;
	}
	final String? message = jsonConvert.convert<String>(json['message']);
	if (message != null) {
		notificationListEntity.message = message;
	}
	final String? xReturn = jsonConvert.convert<String>(json['return']);
	if (xReturn != null) {
		notificationListEntity.xReturn = xReturn;
	}
	return notificationListEntity;
}

Map<String, dynamic> $NotificationListEntityToJson(NotificationListEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['data'] =  entity.data.map((v) => v.toJson()).toList();
	data['message'] = entity.message;
	data['return'] = entity.xReturn;
	return data;
}

NotificationListData $NotificationListDataFromJson(Map<String, dynamic> json) {
	final NotificationListData notificationListData = NotificationListData();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		notificationListData.id = id;
	}
	final String? imageUrl = jsonConvert.convert<String>(json['image_url']);
	if (imageUrl != null) {
		notificationListData.imageUrl = imageUrl;
	}
	final String? message = jsonConvert.convert<String>(json['message']);
	if (message != null) {
		notificationListData.message = message;
	}
	final String? title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		notificationListData.title = title;
	}
	final String? productid = jsonConvert.convert<String>(json['product_id']);
	if (productid != null) {
		notificationListData.productid = productid;
	}
	return notificationListData;
}

Map<String, dynamic> $NotificationListDataToJson(NotificationListData entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['image_url'] = entity.imageUrl;
	data['message'] = entity.message;
	data['title'] = entity.title;
	data['product_id'] = entity.productid;
	return data;
}