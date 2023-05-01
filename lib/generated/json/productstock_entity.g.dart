import 'package:kenz_market_new/generated/json/base/json_convert_content.dart';
import 'package:kenz_market_new/models/productstock_entity.dart';

ProductstockEntity $ProductstockEntityFromJson(Map<String, dynamic> json) {
	final ProductstockEntity productstockEntity = ProductstockEntity();
	final List<ProductstockProductStocks>? productStocks = jsonConvert.convertListNotNull<ProductstockProductStocks>(json['product_stocks']);
	if (productStocks != null) {
		productstockEntity.productStocks = productStocks;
	}
	final String? xReturn = jsonConvert.convert<String>(json['return']);
	if (xReturn != null) {
		productstockEntity.xReturn = xReturn;
	}
	return productstockEntity;
}

Map<String, dynamic> $ProductstockEntityToJson(ProductstockEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['product_stocks'] =  entity.productStocks.map((v) => v.toJson()).toList();
	data['return'] = entity.xReturn;
	return data;
}

ProductstockProductStocks $ProductstockProductStocksFromJson(Map<String, dynamic> json) {
	final ProductstockProductStocks productstockProductStocks = ProductstockProductStocks();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		productstockProductStocks.id = id;
	}
	final dynamic? mainRackNo = jsonConvert.convert<dynamic>(json['main_rack_no']);
	if (mainRackNo != null) {
		productstockProductStocks.mainRackNo = mainRackNo;
	}
	final String? maxStock = jsonConvert.convert<String>(json['max_stock']);
	if (maxStock != null) {
		productstockProductStocks.maxStock = maxStock;
	}
	final String? minStock = jsonConvert.convert<String>(json['min_stock']);
	if (minStock != null) {
		productstockProductStocks.minStock = minStock;
	}
	final String? openingStock = jsonConvert.convert<String>(json['opening_stock']);
	if (openingStock != null) {
		productstockProductStocks.openingStock = openingStock;
	}
	final String? productOfferPrice = jsonConvert.convert<String>(json['product_offer_price']);
	if (productOfferPrice != null) {
		productstockProductStocks.productOfferPrice = productOfferPrice;
	}
	final String? productPrice = jsonConvert.convert<String>(json['product_price']);
	if (productPrice != null) {
		productstockProductStocks.productPrice = productPrice;
	}
	final String? productPurchasePrice = jsonConvert.convert<String>(json['product_purchase_price']);
	if (productPurchasePrice != null) {
		productstockProductStocks.productPurchasePrice = productPurchasePrice;
	}
	final dynamic? subRackNo = jsonConvert.convert<dynamic>(json['sub_rack_no']);
	if (subRackNo != null) {
		productstockProductStocks.subRackNo = subRackNo;
	}
	return productstockProductStocks;
}

Map<String, dynamic> $ProductstockProductStocksToJson(ProductstockProductStocks entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['main_rack_no'] = entity.mainRackNo;
	data['max_stock'] = entity.maxStock;
	data['min_stock'] = entity.minStock;
	data['opening_stock'] = entity.openingStock;
	data['product_offer_price'] = entity.productOfferPrice;
	data['product_price'] = entity.productPrice;
	data['product_purchase_price'] = entity.productPurchasePrice;
	data['sub_rack_no'] = entity.subRackNo;
	return data;
}