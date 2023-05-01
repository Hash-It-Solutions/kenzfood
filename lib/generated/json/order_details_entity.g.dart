import 'package:kenz_market_new/generated/json/base/json_convert_content.dart';
import 'package:kenz_market_new/models/order_details_entity.dart';

OrderDetailsEntity $OrderDetailsEntityFromJson(Map<String, dynamic> json) {
	final OrderDetailsEntity orderDetailsEntity = OrderDetailsEntity();
	final List<OrderDetailsOrderDetails>? orderDetails = jsonConvert.convertListNotNull<OrderDetailsOrderDetails>(json['order_details']);
	if (orderDetails != null) {
		orderDetailsEntity.orderDetails = orderDetails;
	}
	final String? xReturn = jsonConvert.convert<String>(json['return']);
	if (xReturn != null) {
		orderDetailsEntity.xReturn = xReturn;
	}
	return orderDetailsEntity;
}

Map<String, dynamic> $OrderDetailsEntityToJson(OrderDetailsEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['order_details'] =  entity.orderDetails.map((v) => v.toJson()).toList();
	data['return'] = entity.xReturn;
	return data;
}

OrderDetailsOrderDetails $OrderDetailsOrderDetailsFromJson(Map<String, dynamic> json) {
	final OrderDetailsOrderDetails orderDetailsOrderDetails = OrderDetailsOrderDetails();
	final int? addressId = jsonConvert.convert<int>(json['address_id']);
	if (addressId != null) {
		orderDetailsOrderDetails.addressId = addressId;
	}
	final int? catId = jsonConvert.convert<int>(json['cat_id']);
	if (catId != null) {
		orderDetailsOrderDetails.catId = catId;
	}
	final dynamic? fastDelivery = jsonConvert.convert<dynamic>(json['fast_delivery']);
	if (fastDelivery != null) {
		orderDetailsOrderDetails.fastDelivery = fastDelivery;
	}
	final dynamic? featured = jsonConvert.convert<dynamic>(json['featured']);
	if (featured != null) {
		orderDetailsOrderDetails.featured = featured;
	}
	final int? fkOrderId = jsonConvert.convert<int>(json['fk_order_id']);
	if (fkOrderId != null) {
		orderDetailsOrderDetails.fkOrderId = fkOrderId;
	}
	final int? fkProductId = jsonConvert.convert<int>(json['fk_product_id']);
	if (fkProductId != null) {
		orderDetailsOrderDetails.fkProductId = fkProductId;
	}
	final dynamic? fresh = jsonConvert.convert<dynamic>(json['fresh']);
	if (fresh != null) {
		orderDetailsOrderDetails.fresh = fresh;
	}
	final String? itemQuantity = jsonConvert.convert<String>(json['item_quantity']);
	if (itemQuantity != null) {
		orderDetailsOrderDetails.itemQuantity = itemQuantity;
	}
	final dynamic? offer = jsonConvert.convert<dynamic>(json['offer']);
	if (offer != null) {
		orderDetailsOrderDetails.offer = offer;
	}
	final String? orderDate = jsonConvert.convert<String>(json['order_date']);
	if (orderDate != null) {
		orderDetailsOrderDetails.orderDate = orderDate;
	}
	final int? orderId = jsonConvert.convert<int>(json['order_id']);
	if (orderId != null) {
		orderDetailsOrderDetails.orderId = orderId;
	}
	final dynamic? otherTitleAr = jsonConvert.convert<dynamic>(json['other_title_ar']);
	if (otherTitleAr != null) {
		orderDetailsOrderDetails.otherTitleAr = otherTitleAr;
	}
	final dynamic? otherTitleEn = jsonConvert.convert<dynamic>(json['other_title_en']);
	if (otherTitleEn != null) {
		orderDetailsOrderDetails.otherTitleEn = otherTitleEn;
	}
	final dynamic? productBarcode = jsonConvert.convert<dynamic>(json['product_barcode']);
	if (productBarcode != null) {
		orderDetailsOrderDetails.productBarcode = productBarcode;
	}
	final int? productCatId = jsonConvert.convert<int>(json['product_cat_id']);
	if (productCatId != null) {
		orderDetailsOrderDetails.productCatId = productCatId;
	}
	final dynamic? productCode = jsonConvert.convert<dynamic>(json['product_code']);
	if (productCode != null) {
		orderDetailsOrderDetails.productCode = productCode;
	}
	final String? productDescAr = jsonConvert.convert<String>(json['product_desc_ar']);
	if (productDescAr != null) {
		orderDetailsOrderDetails.productDescAr = productDescAr;
	}
	final String? productDescEn = jsonConvert.convert<String>(json['product_desc_en']);
	if (productDescEn != null) {
		orderDetailsOrderDetails.productDescEn = productDescEn;
	}
	final int? productId = jsonConvert.convert<int>(json['product_id']);
	if (productId != null) {
		orderDetailsOrderDetails.productId = productId;
	}
	final List<OrderDetailsOrderDetailsProductImages>? productImages = jsonConvert.convertListNotNull<OrderDetailsOrderDetailsProductImages>(json['product_images']);
	if (productImages != null) {
		orderDetailsOrderDetails.productImages = productImages;
	}
	final String? productNameAr = jsonConvert.convert<String>(json['product_name_ar']);
	if (productNameAr != null) {
		orderDetailsOrderDetails.productNameAr = productNameAr;
	}
	final String? productNameEn = jsonConvert.convert<String>(json['product_name_en']);
	if (productNameEn != null) {
		orderDetailsOrderDetails.productNameEn = productNameEn;
	}
	final OrderDetailsOrderDetailsProductStock? productStock = jsonConvert.convert<OrderDetailsOrderDetailsProductStock>(json['product_stock']);
	if (productStock != null) {
		orderDetailsOrderDetails.productStock = productStock;
	}
	final int? productSubcatId = jsonConvert.convert<int>(json['product_subcat_id']);
	if (productSubcatId != null) {
		orderDetailsOrderDetails.productSubcatId = productSubcatId;
	}
	final String? status = jsonConvert.convert<String>(json['status']);
	if (status != null) {
		orderDetailsOrderDetails.status = status;
	}
	final int? subcatId = jsonConvert.convert<int>(json['subcat_id']);
	if (subcatId != null) {
		orderDetailsOrderDetails.subcatId = subcatId;
	}
	final String? unitQuantity = jsonConvert.convert<String>(json['unit_quantity']);
	if (unitQuantity != null) {
		orderDetailsOrderDetails.unitQuantity = unitQuantity;
	}
	return orderDetailsOrderDetails;
}

Map<String, dynamic> $OrderDetailsOrderDetailsToJson(OrderDetailsOrderDetails entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['address_id'] = entity.addressId;
	data['cat_id'] = entity.catId;
	data['fast_delivery'] = entity.fastDelivery;
	data['featured'] = entity.featured;
	data['fk_order_id'] = entity.fkOrderId;
	data['fk_product_id'] = entity.fkProductId;
	data['fresh'] = entity.fresh;
	data['item_quantity'] = entity.itemQuantity;
	data['offer'] = entity.offer;
	data['order_date'] = entity.orderDate;
	data['order_id'] = entity.orderId;
	data['other_title_ar'] = entity.otherTitleAr;
	data['other_title_en'] = entity.otherTitleEn;
	data['product_barcode'] = entity.productBarcode;
	data['product_cat_id'] = entity.productCatId;
	data['product_code'] = entity.productCode;
	data['product_desc_ar'] = entity.productDescAr;
	data['product_desc_en'] = entity.productDescEn;
	data['product_id'] = entity.productId;
	data['product_images'] =  entity.productImages.map((v) => v.toJson()).toList();
	data['product_name_ar'] = entity.productNameAr;
	data['product_name_en'] = entity.productNameEn;
	data['product_stock'] = entity.productStock.toJson();
	data['product_subcat_id'] = entity.productSubcatId;
	data['status'] = entity.status;
	data['subcat_id'] = entity.subcatId;
	data['unit_quantity'] = entity.unitQuantity;
	return data;
}

OrderDetailsOrderDetailsProductImages $OrderDetailsOrderDetailsProductImagesFromJson(Map<String, dynamic> json) {
	final OrderDetailsOrderDetailsProductImages orderDetailsOrderDetailsProductImages = OrderDetailsOrderDetailsProductImages();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		orderDetailsOrderDetailsProductImages.id = id;
	}
	final int? productId = jsonConvert.convert<int>(json['product_id']);
	if (productId != null) {
		orderDetailsOrderDetailsProductImages.productId = productId;
	}
	final String? productImageUrl = jsonConvert.convert<String>(json['product_image_url']);
	if (productImageUrl != null) {
		orderDetailsOrderDetailsProductImages.productImageUrl = productImageUrl;
	}
	return orderDetailsOrderDetailsProductImages;
}

Map<String, dynamic> $OrderDetailsOrderDetailsProductImagesToJson(OrderDetailsOrderDetailsProductImages entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['product_id'] = entity.productId;
	data['product_image_url'] = entity.productImageUrl;
	return data;
}

OrderDetailsOrderDetailsProductStock $OrderDetailsOrderDetailsProductStockFromJson(Map<String, dynamic> json) {
	final OrderDetailsOrderDetailsProductStock orderDetailsOrderDetailsProductStock = OrderDetailsOrderDetailsProductStock();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		orderDetailsOrderDetailsProductStock.id = id;
	}
	final dynamic? mainRackNo = jsonConvert.convert<dynamic>(json['main_rack_no']);
	if (mainRackNo != null) {
		orderDetailsOrderDetailsProductStock.mainRackNo = mainRackNo;
	}
	final String? maxStock = jsonConvert.convert<String>(json['max_stock']);
	if (maxStock != null) {
		orderDetailsOrderDetailsProductStock.maxStock = maxStock;
	}
	final String? minStock = jsonConvert.convert<String>(json['min_stock']);
	if (minStock != null) {
		orderDetailsOrderDetailsProductStock.minStock = minStock;
	}
	final String? openingStock = jsonConvert.convert<String>(json['opening_stock']);
	if (openingStock != null) {
		orderDetailsOrderDetailsProductStock.openingStock = openingStock;
	}
	final int? productId = jsonConvert.convert<int>(json['product_id']);
	if (productId != null) {
		orderDetailsOrderDetailsProductStock.productId = productId;
	}
	final String? productOfferPrice = jsonConvert.convert<String>(json['product_offer_price']);
	if (productOfferPrice != null) {
		orderDetailsOrderDetailsProductStock.productOfferPrice = productOfferPrice;
	}
	final String? productPrice = jsonConvert.convert<String>(json['product_price']);
	if (productPrice != null) {
		orderDetailsOrderDetailsProductStock.productPrice = productPrice;
	}
	final String? productPurchasePrice = jsonConvert.convert<String>(json['product_purchase_price']);
	if (productPurchasePrice != null) {
		orderDetailsOrderDetailsProductStock.productPurchasePrice = productPurchasePrice;
	}
	final dynamic? subRackNo = jsonConvert.convert<dynamic>(json['sub_rack_no']);
	if (subRackNo != null) {
		orderDetailsOrderDetailsProductStock.subRackNo = subRackNo;
	}
	return orderDetailsOrderDetailsProductStock;
}

Map<String, dynamic> $OrderDetailsOrderDetailsProductStockToJson(OrderDetailsOrderDetailsProductStock entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['main_rack_no'] = entity.mainRackNo;
	data['max_stock'] = entity.maxStock;
	data['min_stock'] = entity.minStock;
	data['opening_stock'] = entity.openingStock;
	data['product_id'] = entity.productId;
	data['product_offer_price'] = entity.productOfferPrice;
	data['product_price'] = entity.productPrice;
	data['product_purchase_price'] = entity.productPurchasePrice;
	data['sub_rack_no'] = entity.subRackNo;
	return data;
}