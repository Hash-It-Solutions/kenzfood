import 'package:kenz_market_new/generated/json/base/json_convert_content.dart';
import 'package:kenz_market_new/models/delivery_charge_data_entity.dart';

DeliveryChargeDataEntity $DeliveryChargeDataEntityFromJson(Map<String, dynamic> json) {
	final DeliveryChargeDataEntity deliveryChargeDataEntity = DeliveryChargeDataEntity();
	final double? fastCharge = jsonConvert.convert<double>(json['fast_charge']);
	if (fastCharge != null) {
		deliveryChargeDataEntity.fastCharge = fastCharge;
	}
	final double? normalCharge = jsonConvert.convert<double>(json['normal_charge']);
	if (normalCharge != null) {
		deliveryChargeDataEntity.normalCharge = normalCharge;
	}
	final int? zipcode = jsonConvert.convert<int>(json['zipcode']);
	if (zipcode != null) {
		deliveryChargeDataEntity.zipcode = zipcode;
	}
	return deliveryChargeDataEntity;
}

Map<String, dynamic> $DeliveryChargeDataEntityToJson(DeliveryChargeDataEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['fast_charge'] = entity.fastCharge;
	data['normal_charge'] = entity.normalCharge;
	data['zipcode'] = entity.zipcode;
	return data;
}