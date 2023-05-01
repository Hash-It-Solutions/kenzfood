import 'package:kenz_market_new/generated/json/base/json_convert_content.dart';
import 'package:kenz_market_new/models/sub_category_list_entity.dart';

SubCategoryListEntity $SubCategoryListEntityFromJson(Map<String, dynamic> json) {
	final SubCategoryListEntity subCategoryListEntity = SubCategoryListEntity();
	final String? xReturn = jsonConvert.convert<String>(json['return']);
	if (xReturn != null) {
		subCategoryListEntity.xReturn = xReturn;
	}
	final List<SubCategoryListSubcategories>? subcategories = jsonConvert.convertListNotNull<SubCategoryListSubcategories>(json['subcategories']);
	if (subcategories != null) {
		subCategoryListEntity.subcategories = subcategories;
	}
	return subCategoryListEntity;
}

Map<String, dynamic> $SubCategoryListEntityToJson(SubCategoryListEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['return'] = entity.xReturn;
	data['subcategories'] =  entity.subcategories.map((v) => v.toJson()).toList();
	return data;
}

SubCategoryListSubcategories $SubCategoryListSubcategoriesFromJson(Map<String, dynamic> json) {
	final SubCategoryListSubcategories subCategoryListSubcategories = SubCategoryListSubcategories();
	final int? selected = jsonConvert.convert<int>(json['selected']);
	if (selected != null) {
		subCategoryListSubcategories.selected = selected;
	}
	final dynamic? active = jsonConvert.convert<dynamic>(json['active']);
	if (active != null) {
		subCategoryListSubcategories.active = active;
	}
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		subCategoryListSubcategories.id = id;
	}
	final String? subcategoryDescAr = jsonConvert.convert<String>(json['subcategory_desc_ar']);
	if (subcategoryDescAr != null) {
		subCategoryListSubcategories.subcategoryDescAr = subcategoryDescAr;
	}
	final String? subcategoryDescEn = jsonConvert.convert<String>(json['subcategory_desc_en']);
	if (subcategoryDescEn != null) {
		subCategoryListSubcategories.subcategoryDescEn = subcategoryDescEn;
	}
	final String? subcategoryImageUrl = jsonConvert.convert<String>(json['subcategory_image_url']);
	if (subcategoryImageUrl != null) {
		subCategoryListSubcategories.subcategoryImageUrl = subcategoryImageUrl;
	}
	final String? subcategoryNameAr = jsonConvert.convert<String>(json['subcategory_name_ar']);
	if (subcategoryNameAr != null) {
		subCategoryListSubcategories.subcategoryNameAr = subcategoryNameAr;
	}
	final String? subcategoryNameEn = jsonConvert.convert<String>(json['subcategory_name_en']);
	if (subcategoryNameEn != null) {
		subCategoryListSubcategories.subcategoryNameEn = subcategoryNameEn;
	}
	final dynamic? subcategoryOrder = jsonConvert.convert<dynamic>(json['subcategory_order']);
	if (subcategoryOrder != null) {
		subCategoryListSubcategories.subcategoryOrder = subcategoryOrder;
	}
	return subCategoryListSubcategories;
}

Map<String, dynamic> $SubCategoryListSubcategoriesToJson(SubCategoryListSubcategories entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['selected'] = entity.selected;
	data['active'] = entity.active;
	data['id'] = entity.id;
	data['subcategory_desc_ar'] = entity.subcategoryDescAr;
	data['subcategory_desc_en'] = entity.subcategoryDescEn;
	data['subcategory_image_url'] = entity.subcategoryImageUrl;
	data['subcategory_name_ar'] = entity.subcategoryNameAr;
	data['subcategory_name_en'] = entity.subcategoryNameEn;
	data['subcategory_order'] = entity.subcategoryOrder;
	return data;
}