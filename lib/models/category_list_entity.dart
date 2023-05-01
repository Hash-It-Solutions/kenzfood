
import 'dart:convert';

import '../generated/json/base/json_field.dart';
import '../generated/json/category_list_entity.g.dart';

@JsonSerializable()
class CategoryListEntity {

	late List<CategoryListCategories> categories=[];
	@JSONField(name: "return")
	late String xReturn="";
  
  CategoryListEntity();

  factory CategoryListEntity.fromJson(Map<String, dynamic> json) => $CategoryListEntityFromJson(json);

  Map<String, dynamic> toJson() => $CategoryListEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class CategoryListCategories {

	dynamic active;
	@JSONField(name: "category_desc_ar")
	late String categoryDescAr="";
	@JSONField(name: "category_desc_en")
	late String categoryDescEn="";
	@JSONField(name: "category_image_url")
	late String categoryImageUrl="";
	@JSONField(name: "category_name_ar")
	late String categoryNameAr="";
	@JSONField(name: "category_name_en")
	late String categoryNameEn="";
	@JSONField(name: "category_order")
	dynamic categoryOrder="";
	late int id=0;
  
  CategoryListCategories();

  factory CategoryListCategories.fromJson(Map<String, dynamic> json) => $CategoryListCategoriesFromJson(json);

  Map<String, dynamic> toJson() => $CategoryListCategoriesToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}