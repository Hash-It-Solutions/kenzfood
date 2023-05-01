import 'package:kenz_market_new/generated/json/base/json_convert_content.dart';
import 'package:kenz_market_new/models/cart_entity.dart';

CartEntity $CartEntityFromJson(Map<String, dynamic> json) {
	final CartEntity cartEntity = CartEntity();
	final List<CartCartItems>? cartItems = jsonConvert.convertListNotNull<CartCartItems>(json['cart_items']);
	if (cartItems != null) {
		cartEntity.cartItems = cartItems;
	}
	final String? xReturn = jsonConvert.convert<String>(json['return']);
	if (xReturn != null) {
		cartEntity.xReturn = xReturn;
	}
	return cartEntity;
}

Map<String, dynamic> $CartEntityToJson(CartEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['cart_items'] =  entity.cartItems.map((v) => v.toJson()).toList();
	data['return'] = entity.xReturn;
	return data;
}

CartCartItems $CartCartItemsFromJson(Map<String, dynamic> json) {
	final CartCartItems cartCartItems = CartCartItems();
	final int? catId = jsonConvert.convert<int>(json['cat_id']);
	if (catId != null) {
		cartCartItems.catId = catId;
	}
	final String? createdAt = jsonConvert.convert<String>(json['created_at']);
	if (createdAt != null) {
		cartCartItems.createdAt = createdAt;
	}
	final dynamic? fastDelivery = jsonConvert.convert<dynamic>(json['fast_delivery']);
	if (fastDelivery != null) {
		cartCartItems.fastDelivery = fastDelivery;
	}
	final dynamic? featured = jsonConvert.convert<dynamic>(json['featured']);
	if (featured != null) {
		cartCartItems.featured = featured;
	}
	final dynamic? fresh = jsonConvert.convert<dynamic>(json['fresh']);
	if (fresh != null) {
		cartCartItems.fresh = fresh;
	}
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		cartCartItems.id = id;
	}
	final String? modifiedAt = jsonConvert.convert<String>(json['modified_at']);
	if (modifiedAt != null) {
		cartCartItems.modifiedAt = modifiedAt;
	}
	final dynamic? offer = jsonConvert.convert<dynamic>(json['offer']);
	if (offer != null) {
		cartCartItems.offer = offer;
	}
	final dynamic? otherTitleAr = jsonConvert.convert<dynamic>(json['other_title_ar']);
	if (otherTitleAr != null) {
		cartCartItems.otherTitleAr = otherTitleAr;
	}
	final dynamic? otherTitleEn = jsonConvert.convert<dynamic>(json['other_title_en']);
	if (otherTitleEn != null) {
		cartCartItems.otherTitleEn = otherTitleEn;
	}
	final dynamic? productBarcode = jsonConvert.convert<dynamic>(json['product_barcode']);
	if (productBarcode != null) {
		cartCartItems.productBarcode = productBarcode;
	}
	final int? productCatId = jsonConvert.convert<int>(json['product_cat_id']);
	if (productCatId != null) {
		cartCartItems.productCatId = productCatId;
	}
	final dynamic? productCode = jsonConvert.convert<dynamic>(json['product_code']);
	if (productCode != null) {
		cartCartItems.productCode = productCode;
	}
	final String? productDescAr = jsonConvert.convert<String>(json['product_desc_ar']);
	if (productDescAr != null) {
		cartCartItems.productDescAr = productDescAr;
	}
	final String? productDescEn = jsonConvert.convert<String>(json['product_desc_en']);
	if (productDescEn != null) {
		cartCartItems.productDescEn = productDescEn;
	}
	final int? productId = jsonConvert.convert<int>(json['product_id']);
	if (productId != null) {
		cartCartItems.productId = productId;
	}
	final List<CartCartItemsProductImages>? productImages = jsonConvert.convertListNotNull<CartCartItemsProductImages>(json['product_images']);
	if (productImages != null) {
		cartCartItems.productImages = productImages;
	}
	final String? productNameAr = jsonConvert.convert<String>(json['product_name_ar']);
	if (productNameAr != null) {
		cartCartItems.productNameAr = productNameAr;
	}
	final String? productNameEn = jsonConvert.convert<String>(json['product_name_en']);
	if (productNameEn != null) {
		cartCartItems.productNameEn = productNameEn;
	}
	final CartCartItemsProductStock? productStock = jsonConvert.convert<CartCartItemsProductStock>(json['product_stock']);
	if (productStock != null) {
		cartCartItems.productStock = productStock;
	}
	final int? productSubcatId = jsonConvert.convert<int>(json['product_subcat_id']);
	if (productSubcatId != null) {
		cartCartItems.productSubcatId = productSubcatId;
	}
	final String? quantity = jsonConvert.convert<String>(json['quantity']);
	if (quantity != null) {
		cartCartItems.quantity = quantity;
	}
	final String? status = jsonConvert.convert<String>(json['status']);
	if (status != null) {
		cartCartItems.status = status;
	}
	final int? subcatId = jsonConvert.convert<int>(json['subcat_id']);
	if (subcatId != null) {
		cartCartItems.subcatId = subcatId;
	}
	final String? unitQuantity = jsonConvert.convert<String>(json['unit_quantity']);
	if (unitQuantity != null) {
		cartCartItems.unitQuantity = unitQuantity;
	}
	final int? userId = jsonConvert.convert<int>(json['user_id']);
	if (userId != null) {
		cartCartItems.userId = userId;
	}
	return cartCartItems;
}

Map<String, dynamic> $CartCartItemsToJson(CartCartItems entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['cat_id'] = entity.catId;
	data['created_at'] = entity.createdAt;
	data['fast_delivery'] = entity.fastDelivery;
	data['featured'] = entity.featured;
	data['fresh'] = entity.fresh;
	data['id'] = entity.id;
	data['modified_at'] = entity.modifiedAt;
	data['offer'] = entity.offer;
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
	data['quantity'] = entity.quantity;
	data['status'] = entity.status;
	data['subcat_id'] = entity.subcatId;
	data['unit_quantity'] = entity.unitQuantity;
	data['user_id'] = entity.userId;
	return data;
}

CartCartItemsProductImages $CartCartItemsProductImagesFromJson(Map<String, dynamic> json) {
	final CartCartItemsProductImages cartCartItemsProductImages = CartCartItemsProductImages();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		cartCartItemsProductImages.id = id;
	}
	final int? productId = jsonConvert.convert<int>(json['product_id']);
	if (productId != null) {
		cartCartItemsProductImages.productId = productId;
	}
	final String? productImageUrl = jsonConvert.convert<String>(json['product_image_url']);
	if (productImageUrl != null) {
		cartCartItemsProductImages.productImageUrl = productImageUrl;
	}
	return cartCartItemsProductImages;
}

Map<String, dynamic> $CartCartItemsProductImagesToJson(CartCartItemsProductImages entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['product_id'] = entity.productId;
	data['product_image_url'] = entity.productImageUrl;
	return data;
}

CartCartItemsProductStock $CartCartItemsProductStockFromJson(Map<String, dynamic> json) {
	final CartCartItemsProductStock cartCartItemsProductStock = CartCartItemsProductStock();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		cartCartItemsProductStock.id = id;
	}
	final dynamic? mainRackNo = jsonConvert.convert<dynamic>(json['main_rack_no']);
	if (mainRackNo != null) {
		cartCartItemsProductStock.mainRackNo = mainRackNo;
	}
	final String? maxStock = jsonConvert.convert<String>(json['max_stock']);
	if (maxStock != null) {
		cartCartItemsProductStock.maxStock = maxStock;
	}
	final String? minStock = jsonConvert.convert<String>(json['min_stock']);
	if (minStock != null) {
		cartCartItemsProductStock.minStock = minStock;
	}
	final String? openingStock = jsonConvert.convert<String>(json['opening_stock']);
	if (openingStock != null) {
		cartCartItemsProductStock.openingStock = openingStock;
	}
	final int? productId = jsonConvert.convert<int>(json['product_id']);
	if (productId != null) {
		cartCartItemsProductStock.productId = productId;
	}
	final String? productOfferPrice = jsonConvert.convert<String>(json['product_offer_price']);
	if (productOfferPrice != null) {
		cartCartItemsProductStock.productOfferPrice = productOfferPrice;
	}
	final String? productPrice = jsonConvert.convert<String>(json['product_price']);
	if (productPrice != null) {
		cartCartItemsProductStock.productPrice = productPrice;
	}
	final String? productPurchasePrice = jsonConvert.convert<String>(json['product_purchase_price']);
	if (productPurchasePrice != null) {
		cartCartItemsProductStock.productPurchasePrice = productPurchasePrice;
	}
	final dynamic? subRackNo = jsonConvert.convert<dynamic>(json['sub_rack_no']);
	if (subRackNo != null) {
		cartCartItemsProductStock.subRackNo = subRackNo;
	}
	return cartCartItemsProductStock;
}

Map<String, dynamic> $CartCartItemsProductStockToJson(CartCartItemsProductStock entity) {
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