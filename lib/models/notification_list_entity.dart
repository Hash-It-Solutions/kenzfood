
import 'dart:convert';

import '../generated/json/base/json_field.dart';
import '../generated/json/notification_list_entity.g.dart';

@JsonSerializable()
class NotificationListEntity {

	late List<NotificationListData> data=[];
	late String message="";
	@JSONField(name: "return")
	late String xReturn="";
  
  NotificationListEntity();

  factory NotificationListEntity.fromJson(Map<String, dynamic> json) => $NotificationListEntityFromJson(json);

  Map<String, dynamic> toJson() => $NotificationListEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class NotificationListData {

	late int id=0;
	@JSONField(name: "image_url")
	late String imageUrl="";
	late String message="";
	late String title="";
  @JSONField(name: "product_id")
  late String productid="";
  
  NotificationListData();

  factory NotificationListData.fromJson(Map<String, dynamic> json) => $NotificationListDataFromJson(json);

  Map<String, dynamic> toJson() => $NotificationListDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}