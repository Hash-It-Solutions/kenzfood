import 'package:kenz_market_new/generated/json/base/json_convert_content.dart';
import 'package:kenz_market_new/models/product_image_entity.dart';

ProductImageEntity $ProductImageEntityFromJson(Map<String, dynamic> json) {
	final ProductImageEntity productImageEntity = ProductImageEntity();
	final List<String>? productImages = jsonConvert.convertListNotNull<String>(json['product_images']);
	if (productImages != null) {
		productImageEntity.productImages = productImages;
	}
	final String? xReturn = jsonConvert.convert<String>(json['return']);
	if (xReturn != null) {
		productImageEntity.xReturn = xReturn;
	}
	return productImageEntity;
}

Map<String, dynamic> $ProductImageEntityToJson(ProductImageEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['product_images'] =  entity.productImages;
	data['return'] = entity.xReturn;
	return data;
}