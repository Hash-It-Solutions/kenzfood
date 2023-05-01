
import 'dart:convert';

import '../generated/json/address_entity.g.dart';
import '../generated/json/base/json_field.dart';

@JsonSerializable()
class AddressEntity {

	late List<AddressData> data=[];
	late String message;
	@JSONField(name: "return")
	late String xReturn;
  
  AddressEntity();

  factory AddressEntity.fromJson(Map<String, dynamic> json) => $AddressEntityFromJson(json);

  Map<String, dynamic> toJson() => $AddressEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class AddressData {

	@JSONField(name: "address_line1")
	late String addressLine1="";
	@JSONField(name: "address_line2")
	late String addressLine2="";
	late String city="";
	late String country="";
	@JSONField(name: "created_at")
	late String createdAt="";
	late int id=0;
	late String latitude="";
	late String longitude="";
	late String mobile="";
	@JSONField(name: "modified_at")
	late String modifiedAt="";
	late String name="";
	@JSONField(name: "postal_code")
	late String postalCode="";
	late String telephone="";
	@JSONField(name: "user_id")
	late int userId=0;
	bool selected=false;
  
  AddressData();

  factory AddressData.fromJson(Map<String, dynamic> json) => $AddressDataFromJson(json);

  Map<String, dynamic> toJson() => $AddressDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}