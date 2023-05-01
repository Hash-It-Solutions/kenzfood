
import 'dart:convert';

import '../generated/json/base/json_field.dart';
import '../generated/json/sub_category_list_entity.g.dart';

@JsonSerializable()
class SubCategoryListEntity {

	@JSONField(name: "return")
	late String xReturn="";
	late List<SubCategoryListSubcategories> subcategories=[];
  
  SubCategoryListEntity();

  factory SubCategoryListEntity.fromJson(Map<String, dynamic> json) => $SubCategoryListEntityFromJson(json);

  Map<String, dynamic> toJson() => $SubCategoryListEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class SubCategoryListSubcategories {

	int selected=0;
	dynamic active;
	late int id=0;
	@JSONField(name: "subcategory_desc_ar")
	late String subcategoryDescAr="";
	@JSONField(name: "subcategory_desc_en")
	late String subcategoryDescEn="";
	@JSONField(name: "subcategory_image_url")
	late String subcategoryImageUrl="";
	@JSONField(name: "subcategory_name_ar")
	late String subcategoryNameAr="";
	@JSONField(name: "subcategory_name_en")
	late String subcategoryNameEn="";
	@JSONField(name: "subcategory_order")
	dynamic subcategoryOrder="";
  
  SubCategoryListSubcategories();

  factory SubCategoryListSubcategories.fromJson(Map<String, dynamic> json) => $SubCategoryListSubcategoriesFromJson(json);

  Map<String, dynamic> toJson() => $SubCategoryListSubcategoriesToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}