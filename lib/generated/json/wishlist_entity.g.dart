import 'package:kenz_market_new/generated/json/base/json_convert_content.dart';
import 'package:kenz_market_new/models/wishlist_entity.dart';

WishlistEntity $WishlistEntityFromJson(Map<String, dynamic> json) {
	final WishlistEntity wishlistEntity = WishlistEntity();
	final List<WishlistData>? data = jsonConvert.convertListNotNull<WishlistData>(json['data']);
	if (data != null) {
		wishlistEntity.data = data;
	}
	final String? message = jsonConvert.convert<String>(json['message']);
	if (message != null) {
		wishlistEntity.message = message;
	}
	final String? xReturn = jsonConvert.convert<String>(json['return']);
	if (xReturn != null) {
		wishlistEntity.xReturn = xReturn;
	}
	return wishlistEntity;
}

Map<String, dynamic> $WishlistEntityToJson(WishlistEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['data'] =  entity.data.map((v) => v.toJson()).toList();
	data['message'] = entity.message;
	data['return'] = entity.xReturn;
	return data;
}

WishlistData $WishlistDataFromJson(Map<String, dynamic> json) {
	final WishlistData wishlistData = WishlistData();
	final int? catId = jsonConvert.convert<int>(json['cat_id']);
	if (catId != null) {
		wishlistData.catId = catId;
	}
	final String? createdAt = jsonConvert.convert<String>(json['created_at']);
	if (createdAt != null) {
		wishlistData.createdAt = createdAt;
	}
	final dynamic? fastDelivery = jsonConvert.convert<dynamic>(json['fast_delivery']);
	if (fastDelivery != null) {
		wishlistData.fastDelivery = fastDelivery;
	}
	final dynamic? featured = jsonConvert.convert<dynamic>(json['featured']);
	if (featured != null) {
		wishlistData.featured = featured;
	}
	final dynamic? fresh = jsonConvert.convert<dynamic>(json['fresh']);
	if (fresh != null) {
		wishlistData.fresh = fresh;
	}
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		wishlistData.id = id;
	}
	final String? modifiedAt = jsonConvert.convert<String>(json['modified_at']);
	if (modifiedAt != null) {
		wishlistData.modifiedAt = modifiedAt;
	}
	final dynamic? offer = jsonConvert.convert<dynamic>(json['offer']);
	if (offer != null) {
		wishlistData.offer = offer;
	}
	final dynamic? otherTitleAr = jsonConvert.convert<dynamic>(json['other_title_ar']);
	if (otherTitleAr != null) {
		wishlistData.otherTitleAr = otherTitleAr;
	}
	final dynamic? otherTitleEn = jsonConvert.convert<dynamic>(json['other_title_en']);
	if (otherTitleEn != null) {
		wishlistData.otherTitleEn = otherTitleEn;
	}
	final dynamic? productBarcode = jsonConvert.convert<dynamic>(json['product_barcode']);
	if (productBarcode != null) {
		wishlistData.productBarcode = productBarcode;
	}
	final int? productCatId = jsonConvert.convert<int>(json['product_cat_id']);
	if (productCatId != null) {
		wishlistData.productCatId = productCatId;
	}
	final dynamic? productCode = jsonConvert.convert<dynamic>(json['product_code']);
	if (productCode != null) {
		wishlistData.productCode = productCode;
	}
	final String? productDescAr = jsonConvert.convert<String>(json['product_desc_ar']);
	if (productDescAr != null) {
		wishlistData.productDescAr = productDescAr;
	}
	final String? productDescEn = jsonConvert.convert<String>(json['product_desc_en']);
	if (productDescEn != null) {
		wishlistData.productDescEn = productDescEn;
	}
	final int? productId = jsonConvert.convert<int>(json['product_id']);
	if (productId != null) {
		wishlistData.productId = productId;
	}
	final List<WishlistDataProductImages>? productImages = jsonConvert.convertListNotNull<WishlistDataProductImages>(json['product_images']);
	if (productImages != null) {
		wishlistData.productImages = productImages;
	}
	final String? productNameAr = jsonConvert.convert<String>(json['product_name_ar']);
	if (productNameAr != null) {
		wishlistData.productNameAr = productNameAr;
	}
	final String? productNameEn = jsonConvert.convert<String>(json['product_name_en']);
	if (productNameEn != null) {
		wishlistData.productNameEn = productNameEn;
	}
	final WishlistDataProductStock? productStock = jsonConvert.convert<WishlistDataProductStock>(json['product_stock']);
	if (productStock != null) {
		wishlistData.productStock = productStock;
	}
	final int? productSubcatId = jsonConvert.convert<int>(json['product_subcat_id']);
	if (productSubcatId != null) {
		wishlistData.productSubcatId = productSubcatId;
	}
	final String? status = jsonConvert.convert<String>(json['status']);
	if (status != null) {
		wishlistData.status = status;
	}
	final int? subcatId = jsonConvert.convert<int>(json['subcat_id']);
	if (subcatId != null) {
		wishlistData.subcatId = subcatId;
	}
	final String? unitQuantity = jsonConvert.convert<String>(json['unit_quantity']);
	if (unitQuantity != null) {
		wishlistData.unitQuantity = unitQuantity;
	}
	final int? userId = jsonConvert.convert<int>(json['user_id']);
	if (userId != null) {
		wishlistData.userId = userId;
	}
	final bool? ispricesame = jsonConvert.convert<bool>(json['ispricesame']);
	if (ispricesame != null) {
		wishlistData.ispricesame = ispricesame;
	}
	return wishlistData;
}

Map<String, dynamic> $WishlistDataToJson(WishlistData entity) {
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
	data['status'] = entity.status;
	data['subcat_id'] = entity.subcatId;
	data['unit_quantity'] = entity.unitQuantity;
	data['user_id'] = entity.userId;
	data['ispricesame'] = entity.ispricesame;
	return data;
}

WishlistDataProductImages $WishlistDataProductImagesFromJson(Map<String, dynamic> json) {
	final WishlistDataProductImages wishlistDataProductImages = WishlistDataProductImages();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		wishlistDataProductImages.id = id;
	}
	final int? productId = jsonConvert.convert<int>(json['product_id']);
	if (productId != null) {
		wishlistDataProductImages.productId = productId;
	}
	final String? productImageUrl = jsonConvert.convert<String>(json['product_image_url']);
	if (productImageUrl != null) {
		wishlistDataProductImages.productImageUrl = productImageUrl;
	}
	return wishlistDataProductImages;
}

Map<String, dynamic> $WishlistDataProductImagesToJson(WishlistDataProductImages entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['product_id'] = entity.productId;
	data['product_image_url'] = entity.productImageUrl;
	return data;
}

WishlistDataProductStock $WishlistDataProductStockFromJson(Map<String, dynamic> json) {
	final WishlistDataProductStock wishlistDataProductStock = WishlistDataProductStock();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		wishlistDataProductStock.id = id;
	}
	final dynamic? mainRackNo = jsonConvert.convert<dynamic>(json['main_rack_no']);
	if (mainRackNo != null) {
		wishlistDataProductStock.mainRackNo = mainRackNo;
	}
	final String? maxStock = jsonConvert.convert<String>(json['max_stock']);
	if (maxStock != null) {
		wishlistDataProductStock.maxStock = maxStock;
	}
	final String? minStock = jsonConvert.convert<String>(json['min_stock']);
	if (minStock != null) {
		wishlistDataProductStock.minStock = minStock;
	}
	final String? openingStock = jsonConvert.convert<String>(json['opening_stock']);
	if (openingStock != null) {
		wishlistDataProductStock.openingStock = openingStock;
	}
	final int? productId = jsonConvert.convert<int>(json['product_id']);
	if (productId != null) {
		wishlistDataProductStock.productId = productId;
	}
	final String? productOfferPrice = jsonConvert.convert<String>(json['product_offer_price']);
	if (productOfferPrice != null) {
		wishlistDataProductStock.productOfferPrice = productOfferPrice;
	}
	final String? productPrice = jsonConvert.convert<String>(json['product_price']);
	if (productPrice != null) {
		wishlistDataProductStock.productPrice = productPrice;
	}
	final String? productPurchasePrice = jsonConvert.convert<String>(json['product_purchase_price']);
	if (productPurchasePrice != null) {
		wishlistDataProductStock.productPurchasePrice = productPurchasePrice;
	}
	final dynamic? subRackNo = jsonConvert.convert<dynamic>(json['sub_rack_no']);
	if (subRackNo != null) {
		wishlistDataProductStock.subRackNo = subRackNo;
	}
	return wishlistDataProductStock;
}

Map<String, dynamic> $WishlistDataProductStockToJson(WishlistDataProductStock entity) {
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