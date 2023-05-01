import 'package:kenz_market_new/generated/json/base/json_convert_content.dart';
import 'package:kenz_market_new/models/address_entity.dart';

AddressEntity $AddressEntityFromJson(Map<String, dynamic> json) {
	final AddressEntity addressEntity = AddressEntity();
	final List<AddressData>? data = jsonConvert.convertListNotNull<AddressData>(json['data']);
	if (data != null) {
		addressEntity.data = data;
	}
	final String? message = jsonConvert.convert<String>(json['message']);
	if (message != null) {
		addressEntity.message = message;
	}
	final String? xReturn = jsonConvert.convert<String>(json['return']);
	if (xReturn != null) {
		addressEntity.xReturn = xReturn;
	}
	return addressEntity;
}

Map<String, dynamic> $AddressEntityToJson(AddressEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['data'] =  entity.data.map((v) => v.toJson()).toList();
	data['message'] = entity.message;
	data['return'] = entity.xReturn;
	return data;
}

AddressData $AddressDataFromJson(Map<String, dynamic> json) {
	final AddressData addressData = AddressData();
	final String? addressLine1 = jsonConvert.convert<String>(json['address_line1']);
	if (addressLine1 != null) {
		addressData.addressLine1 = addressLine1;
	}
	final String? addressLine2 = jsonConvert.convert<String>(json['address_line2']);
	if (addressLine2 != null) {
		addressData.addressLine2 = addressLine2;
	}
	final String? city = jsonConvert.convert<String>(json['city']);
	if (city != null) {
		addressData.city = city;
	}
	final String? country = jsonConvert.convert<String>(json['country']);
	if (country != null) {
		addressData.country = country;
	}
	final String? createdAt = jsonConvert.convert<String>(json['created_at']);
	if (createdAt != null) {
		addressData.createdAt = createdAt;
	}
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		addressData.id = id;
	}
	final String? latitude = jsonConvert.convert<String>(json['latitude']);
	if (latitude != null) {
		addressData.latitude = latitude;
	}
	final String? longitude = jsonConvert.convert<String>(json['longitude']);
	if (longitude != null) {
		addressData.longitude = longitude;
	}
	final String? mobile = jsonConvert.convert<String>(json['mobile']);
	if (mobile != null) {
		addressData.mobile = mobile;
	}
	final String? modifiedAt = jsonConvert.convert<String>(json['modified_at']);
	if (modifiedAt != null) {
		addressData.modifiedAt = modifiedAt;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		addressData.name = name;
	}
	final String? postalCode = jsonConvert.convert<String>(json['postal_code']);
	if (postalCode != null) {
		addressData.postalCode = postalCode;
	}
	final String? telephone = jsonConvert.convert<String>(json['telephone']);
	if (telephone != null) {
		addressData.telephone = telephone;
	}
	final int? userId = jsonConvert.convert<int>(json['user_id']);
	if (userId != null) {
		addressData.userId = userId;
	}
	final bool? selected = jsonConvert.convert<bool>(json['selected']);
	if (selected != null) {
		addressData.selected = selected;
	}
	return addressData;
}

Map<String, dynamic> $AddressDataToJson(AddressData entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['address_line1'] = entity.addressLine1;
	data['address_line2'] = entity.addressLine2;
	data['city'] = entity.city;
	data['country'] = entity.country;
	data['created_at'] = entity.createdAt;
	data['id'] = entity.id;
	data['latitude'] = entity.latitude;
	data['longitude'] = entity.longitude;
	data['mobile'] = entity.mobile;
	data['modified_at'] = entity.modifiedAt;
	data['name'] = entity.name;
	data['postal_code'] = entity.postalCode;
	data['telephone'] = entity.telephone;
	data['user_id'] = entity.userId;
	data['selected'] = entity.selected;
	return data;
}