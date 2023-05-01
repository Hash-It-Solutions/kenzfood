
import 'dart:convert';

import '../generated/json/base/json_field.dart';
import '../generated/json/product_image_entity.g.dart';

@JsonSerializable()
class ProductImageEntity {

	@JSONField(name: "product_images")
	late List<String> productImages=[];
	@JSONField(name: "return")
	late String xReturn="";
  
  ProductImageEntity();

  factory ProductImageEntity.fromJson(Map<String, dynamic> json) => $ProductImageEntityFromJson(json);

  Map<String, dynamic> toJson() => $ProductImageEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}