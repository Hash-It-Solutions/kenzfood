
import 'dart:convert';

import '../generated/json/base/json_field.dart';
import '../generated/json/delivery_charge_data_entity.g.dart';

@JsonSerializable()
class DeliveryChargeDataEntity {

	@JSONField(name: "fast_charge")
	late double fastCharge;
	@JSONField(name: "normal_charge")
	late double normalCharge;
	late int zipcode;
  
  DeliveryChargeDataEntity();

  factory DeliveryChargeDataEntity.fromJson(Map<String, dynamic> json) => $DeliveryChargeDataEntityFromJson(json);

  Map<String, dynamic> toJson() => $DeliveryChargeDataEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}