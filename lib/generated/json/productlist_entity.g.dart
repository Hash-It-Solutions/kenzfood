import 'package:kenz_market_new/generated/json/base/json_convert_content.dart';
import 'package:kenz_market_new/models/productlist_entity.dart';

ProductlistEntity $ProductlistEntityFromJson(Map<String, dynamic> json) {
	final ProductlistEntity productlistEntity = ProductlistEntity();
	final List<ProductlistProducts>? products = jsonConvert.convertListNotNull<ProductlistProducts>(json['products']);
	if (products != null) {
		productlistEntity.products = products;
	}
	final String? xReturn = jsonConvert.convert<String>(json['return']);
	if (xReturn != null) {
		productlistEntity.xReturn = xReturn;
	}
	return productlistEntity;
}

Map<String, dynamic> $ProductlistEntityToJson(ProductlistEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['products'] =  entity.products.map((v) => v.toJson()).toList();
	data['return'] = entity.xReturn;
	return data;
}

ProductlistProducts $ProductlistProductsFromJson(Map<String, dynamic> json) {
	final ProductlistProducts productlistProducts = ProductlistProducts();
	final int? catId = jsonConvert.convert<int>(json['cat_id']);
	if (catId != null) {
		productlistProducts.catId = catId;
	}
	final String? fastDelivery = jsonConvert.convert<String>(json['fast_delivery']);
	if (fastDelivery != null) {
		productlistProducts.fastDelivery = fastDelivery;
	}
	final String? featured = jsonConvert.convert<String>(json['featured']);
	if (featured != null) {
		productlistProducts.featured = featured;
	}
	final String? fresh = jsonConvert.convert<String>(json['fresh']);
	if (fresh != null) {
		productlistProducts.fresh = fresh;
	}
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		productlistProducts.id = id;
	}
	final bool? inWishlist = jsonConvert.convert<bool>(json['in_wishlist']);
	if (inWishlist != null) {
		productlistProducts.inWishlist = inWishlist;
	}
	final String? offer = jsonConvert.convert<String>(json['offer']);
	if (offer != null) {
		productlistProducts.offer = offer;
	}
	final String? otherTitleAr = jsonConvert.convert<String>(json['other_title_ar']);
	if (otherTitleAr != null) {
		productlistProducts.otherTitleAr = otherTitleAr;
	}
	final String? otherTitleEn = jsonConvert.convert<String>(json['other_title_en']);
	if (otherTitleEn != null) {
		productlistProducts.otherTitleEn = otherTitleEn;
	}
	final String? productBarcode = jsonConvert.convert<String>(json['product_barcode']);
	if (productBarcode != null) {
		productlistProducts.productBarcode = productBarcode;
	}
	final int? productCatId = jsonConvert.convert<int>(json['product_cat_id']);
	if (productCatId != null) {
		productlistProducts.productCatId = productCatId;
	}
	final String? productCode = jsonConvert.convert<String>(json['product_code']);
	if (productCode != null) {
		productlistProducts.productCode = productCode;
	}
	final String? productDescAr = jsonConvert.convert<String>(json['product_desc_ar']);
	if (productDescAr != null) {
		productlistProducts.productDescAr = productDescAr;
	}
	final String? productDescEn = jsonConvert.convert<String>(json['product_desc_en']);
	if (productDescEn != null) {
		productlistProducts.productDescEn = productDescEn;
	}
	final List<ProductlistProductsProductImages>? productImages = jsonConvert.convertListNotNull<ProductlistProductsProductImages>(json['product_images']);
	if (productImages != null) {
		productlistProducts.productImages = productImages;
	}
	final String? productNameAr = jsonConvert.convert<String>(json['product_name_ar']);
	if (productNameAr != null) {
		productlistProducts.productNameAr = productNameAr;
	}
	final String? productNameEn = jsonConvert.convert<String>(json['product_name_en']);
	if (productNameEn != null) {
		productlistProducts.productNameEn = productNameEn;
	}
	final List<ProductlistProductsProductStock>? productStock = jsonConvert.convertListNotNull<ProductlistProductsProductStock>(json['product_stock']);
	if (productStock != null) {
		productlistProducts.productStock = productStock;
	}
	final int? productSubcatId = jsonConvert.convert<int>(json['product_subcat_id']);
	if (productSubcatId != null) {
		productlistProducts.productSubcatId = productSubcatId;
	}
	final String? status = jsonConvert.convert<String>(json['status']);
	if (status != null) {
		productlistProducts.status = status;
	}
	final int? subcatId = jsonConvert.convert<int>(json['subcat_id']);
	if (subcatId != null) {
		productlistProducts.subcatId = subcatId;
	}
	final String? unitQuantity = jsonConvert.convert<String>(json['unit_quantity']);
	if (unitQuantity != null) {
		productlistProducts.unitQuantity = unitQuantity;
	}
	final bool? ispricesame = jsonConvert.convert<bool>(json['ispricesame']);
	if (ispricesame != null) {
		productlistProducts.ispricesame = ispricesame;
	}
	final bool? isaddedcart = jsonConvert.convert<bool>(json['isaddedcart']);
	if (isaddedcart != null) {
		productlistProducts.isaddedcart = isaddedcart;
	}
	return productlistProducts;
}

Map<String, dynamic> $ProductlistProductsToJson(ProductlistProducts entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['cat_id'] = entity.catId;
	data['fast_delivery'] = entity.fastDelivery;
	data['featured'] = entity.featured;
	data['fresh'] = entity.fresh;
	data['id'] = entity.id;
	data['in_wishlist'] = entity.inWishlist;
	data['offer'] = entity.offer;
	data['other_title_ar'] = entity.otherTitleAr;
	data['other_title_en'] = entity.otherTitleEn;
	data['product_barcode'] = entity.productBarcode;
	data['product_cat_id'] = entity.productCatId;
	data['product_code'] = entity.productCode;
	data['product_desc_ar'] = entity.productDescAr;
	data['product_desc_en'] = entity.productDescEn;
	data['product_images'] =  entity.productImages.map((v) => v.toJson()).toList();
	data['product_name_ar'] = entity.productNameAr;
	data['product_name_en'] = entity.productNameEn;
	data['product_stock'] =  entity.productStock.map((v) => v.toJson()).toList();
	data['product_subcat_id'] = entity.productSubcatId;
	data['status'] = entity.status;
	data['subcat_id'] = entity.subcatId;
	data['unit_quantity'] = entity.unitQuantity;
	data['ispricesame'] = entity.ispricesame;
	data['isaddedcart'] = entity.isaddedcart;
	return data;
}

ProductlistProductsProductImages $ProductlistProductsProductImagesFromJson(Map<String, dynamic> json) {
	final ProductlistProductsProductImages productlistProductsProductImages = ProductlistProductsProductImages();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		productlistProductsProductImages.id = id;
	}
	final int? productId = jsonConvert.convert<int>(json['product_id']);
	if (productId != null) {
		productlistProductsProductImages.productId = productId;
	}
	final String? productImageUrl = jsonConvert.convert<String>(json['product_image_url']);
	if (productImageUrl != null) {
		productlistProductsProductImages.productImageUrl = productImageUrl;
	}
	return productlistProductsProductImages;
}

Map<String, dynamic> $ProductlistProductsProductImagesToJson(ProductlistProductsProductImages entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['product_id'] = entity.productId;
	data['product_image_url'] = entity.productImageUrl;
	return data;
}

ProductlistProductsProductStock $ProductlistProductsProductStockFromJson(Map<String, dynamic> json) {
	final ProductlistProductsProductStock productlistProductsProductStock = ProductlistProductsProductStock();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		productlistProductsProductStock.id = id;
	}
	final dynamic? mainRackNo = jsonConvert.convert<dynamic>(json['main_rack_no']);
	if (mainRackNo != null) {
		productlistProductsProductStock.mainRackNo = mainRackNo;
	}
	final String? maxStock = jsonConvert.convert<String>(json['max_stock']);
	if (maxStock != null) {
		productlistProductsProductStock.maxStock = maxStock;
	}
	final String? minStock = jsonConvert.convert<String>(json['min_stock']);
	if (minStock != null) {
		productlistProductsProductStock.minStock = minStock;
	}
	final String? openingStock = jsonConvert.convert<String>(json['opening_stock']);
	if (openingStock != null) {
		productlistProductsProductStock.openingStock = openingStock;
	}
	final int? productId = jsonConvert.convert<int>(json['product_id']);
	if (productId != null) {
		productlistProductsProductStock.productId = productId;
	}
	final String? productOfferPrice = jsonConvert.convert<String>(json['product_offer_price']);
	if (productOfferPrice != null) {
		productlistProductsProductStock.productOfferPrice = productOfferPrice;
	}
	final String? productPrice = jsonConvert.convert<String>(json['product_price']);
	if (productPrice != null) {
		productlistProductsProductStock.productPrice = productPrice;
	}
	final String? productPurchasePrice = jsonConvert.convert<String>(json['product_purchase_price']);
	if (productPurchasePrice != null) {
		productlistProductsProductStock.productPurchasePrice = productPurchasePrice;
	}
	final dynamic? subRackNo = jsonConvert.convert<dynamic>(json['sub_rack_no']);
	if (subRackNo != null) {
		productlistProductsProductStock.subRackNo = subRackNo;
	}


	final int? wholesaleCount = jsonConvert.convert<int>(json['wholesale_count']);
	if (wholesaleCount != null) {
		productlistProductsProductStock.wholesaleCount = wholesaleCount;
	}
	final String? wholesaleUnit = jsonConvert.convert<String>(json['wholesale_unit']);
	if (wholesaleUnit != null) {
		productlistProductsProductStock.wholesaleUnit = wholesaleUnit;
	}


	return productlistProductsProductStock;
}

Map<String, dynamic> $ProductlistProductsProductStockToJson(ProductlistProductsProductStock entity) {
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
	data['wholesale_count'] = entity.wholesaleCount;
	data['wholesale_unit'] = entity.wholesaleUnit;

	return data;
}