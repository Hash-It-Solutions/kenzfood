import 'package:kenz_market_new/generated/json/base/json_convert_content.dart';
import 'package:kenz_market_new/models/category_list_entity.dart';

CategoryListEntity $CategoryListEntityFromJson(Map<String, dynamic> json) {
	final CategoryListEntity categoryListEntity = CategoryListEntity();
	final List<CategoryListCategories>? categories = jsonConvert.convertListNotNull<CategoryListCategories>(json['categories']);
	if (categories != null) {
		categoryListEntity.categories = categories;
	}
	final String? xReturn = jsonConvert.convert<String>(json['return']);
	if (xReturn != null) {
		categoryListEntity.xReturn = xReturn;
	}
	return categoryListEntity;
}

Map<String, dynamic> $CategoryListEntityToJson(CategoryListEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['categories'] =  entity.categories.map((v) => v.toJson()).toList();
	data['return'] = entity.xReturn;
	return data;
}

CategoryListCategories $CategoryListCategoriesFromJson(Map<String, dynamic> json) {
	final CategoryListCategories categoryListCategories = CategoryListCategories();
	final dynamic? active = jsonConvert.convert<dynamic>(json['active']);
	if (active != null) {
		categoryListCategories.active = active;
	}
	final String? categoryDescAr = jsonConvert.convert<String>(json['category_desc_ar']);
	if (categoryDescAr != null) {
		categoryListCategories.categoryDescAr = categoryDescAr;
	}
	final String? categoryDescEn = jsonConvert.convert<String>(json['category_desc_en']);
	if (categoryDescEn != null) {
		categoryListCategories.categoryDescEn = categoryDescEn;
	}
	final String? categoryImageUrl = jsonConvert.convert<String>(json['category_image_url']);
	if (categoryImageUrl != null) {
		categoryListCategories.categoryImageUrl = categoryImageUrl;
	}
	final String? categoryNameAr = jsonConvert.convert<String>(json['category_name_ar']);
	if (categoryNameAr != null) {
		categoryListCategories.categoryNameAr = categoryNameAr;
	}
	final String? categoryNameEn = jsonConvert.convert<String>(json['category_name_en']);
	if (categoryNameEn != null) {
		categoryListCategories.categoryNameEn = categoryNameEn;
	}
	final dynamic? categoryOrder = jsonConvert.convert<dynamic>(json['category_order']);
	if (categoryOrder != null) {
		categoryListCategories.categoryOrder = categoryOrder;
	}
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		categoryListCategories.id = id;
	}
	return categoryListCategories;
}

Map<String, dynamic> $CategoryListCategoriesToJson(CategoryListCategories entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['active'] = entity.active;
	data['category_desc_ar'] = entity.categoryDescAr;
	data['category_desc_en'] = entity.categoryDescEn;
	data['category_image_url'] = entity.categoryImageUrl;
	data['category_name_ar'] = entity.categoryNameAr;
	data['category_name_en'] = entity.categoryNameEn;
	data['category_order'] = entity.categoryOrder;
	data['id'] = entity.id;
	return data;
}