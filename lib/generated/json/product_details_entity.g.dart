import 'package:kenz_market_new/generated/json/base/json_convert_content.dart';
import 'package:kenz_market_new/models/product_details_entity.dart';

ProductDetailsEntity $ProductDetailsEntityFromJson(Map<String, dynamic> json) {
	final ProductDetailsEntity productDetailsEntity = ProductDetailsEntity();
	final List<ProductDetailsProducts>? products = jsonConvert.convertListNotNull<ProductDetailsProducts>(json['products']);
	if (products != null) {
		productDetailsEntity.products = products;
	}
	final String? xReturn = jsonConvert.convert<String>(json['return']);
	if (xReturn != null) {
		productDetailsEntity.xReturn = xReturn;
	}
	return productDetailsEntity;
}

Map<String, dynamic> $ProductDetailsEntityToJson(ProductDetailsEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['products'] =  entity.products.map((v) => v.toJson()).toList();
	data['return'] = entity.xReturn;
	return data;
}

ProductDetailsProducts $ProductDetailsProductsFromJson(Map<String, dynamic> json) {
	final ProductDetailsProducts productDetailsProducts = ProductDetailsProducts();
	final int? catId = jsonConvert.convert<int>(json['cat_id']);
	if (catId != null) {
		productDetailsProducts.catId = catId;
	}
	final String? fastDelivery = jsonConvert.convert<String>(json['fast_delivery']);
	if (fastDelivery != null) {
		productDetailsProducts.fastDelivery = fastDelivery;
	}
	final String? featured = jsonConvert.convert<String>(json['featured']);
	if (featured != null) {
		productDetailsProducts.featured = featured;
	}
	final String? fresh = jsonConvert.convert<String>(json['fresh']);
	if (fresh != null) {
		productDetailsProducts.fresh = fresh;
	}
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		productDetailsProducts.id = id;
	}
	final bool? inWishlist = jsonConvert.convert<bool>(json['in_wishlist']);
	if (inWishlist != null) {
		productDetailsProducts.inWishlist = inWishlist;
	}
	final String? offer = jsonConvert.convert<String>(json['offer']);
	if (offer != null) {
		productDetailsProducts.offer = offer;
	}
	final String? otherTitleAr = jsonConvert.convert<String>(json['other_title_ar']);
	if (otherTitleAr != null) {
		productDetailsProducts.otherTitleAr = otherTitleAr;
	}
	final String? otherTitleEn = jsonConvert.convert<String>(json['other_title_en']);
	if (otherTitleEn != null) {
		productDetailsProducts.otherTitleEn = otherTitleEn;
	}
	final String? productBarcode = jsonConvert.convert<String>(json['product_barcode']);
	if (productBarcode != null) {
		productDetailsProducts.productBarcode = productBarcode;
	}
	final int? productCatId = jsonConvert.convert<int>(json['product_cat_id']);
	if (productCatId != null) {
		productDetailsProducts.productCatId = productCatId;
	}
	final String? productCode = jsonConvert.convert<String>(json['product_code']);
	if (productCode != null) {
		productDetailsProducts.productCode = productCode;
	}
	final String? productDescAr = jsonConvert.convert<String>(json['product_desc_ar']);
	if (productDescAr != null) {
		productDetailsProducts.productDescAr = productDescAr;
	}
	final String? productDescEn = jsonConvert.convert<String>(json['product_desc_en']);
	if (productDescEn != null) {
		productDetailsProducts.productDescEn = productDescEn;
	}
	final List<ProductDetailsProductsProductImages>? productImages = jsonConvert.convertListNotNull<ProductDetailsProductsProductImages>(json['product_images']);
	if (productImages != null) {
		productDetailsProducts.productImages = productImages;
	}
	final String? productNameAr = jsonConvert.convert<String>(json['product_name_ar']);
	if (productNameAr != null) {
		productDetailsProducts.productNameAr = productNameAr;
	}
	final String? productNameEn = jsonConvert.convert<String>(json['product_name_en']);
	if (productNameEn != null) {
		productDetailsProducts.productNameEn = productNameEn;
	}
	final List<ProductDetailsProductsProductStock>? productStock = jsonConvert.convertListNotNull<ProductDetailsProductsProductStock>(json['product_stock']);
	if (productStock != null) {
		productDetailsProducts.productStock = productStock;
	}
	final int? productSubcatId = jsonConvert.convert<int>(json['product_subcat_id']);
	if (productSubcatId != null) {
		productDetailsProducts.productSubcatId = productSubcatId;
	}
	final String? status = jsonConvert.convert<String>(json['status']);
	if (status != null) {
		productDetailsProducts.status = status;
	}
	final int? subcatId = jsonConvert.convert<int>(json['subcat_id']);
	if (subcatId != null) {
		productDetailsProducts.subcatId = subcatId;
	}
	final String? unitQuantity = jsonConvert.convert<String>(json['unit_quantity']);
	if (unitQuantity != null) {
		productDetailsProducts.unitQuantity = unitQuantity;
	}
	return productDetailsProducts;
}

Map<String, dynamic> $ProductDetailsProductsToJson(ProductDetailsProducts entity) {
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
	return data;
}

ProductDetailsProductsProductImages $ProductDetailsProductsProductImagesFromJson(Map<String, dynamic> json) {
	final ProductDetailsProductsProductImages productDetailsProductsProductImages = ProductDetailsProductsProductImages();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		productDetailsProductsProductImages.id = id;
	}
	final int? productId = jsonConvert.convert<int>(json['product_id']);
	if (productId != null) {
		productDetailsProductsProductImages.productId = productId;
	}
	final String? productImageUrl = jsonConvert.convert<String>(json['product_image_url']);
	if (productImageUrl != null) {
		productDetailsProductsProductImages.productImageUrl = productImageUrl;
	}
	return productDetailsProductsProductImages;
}

Map<String, dynamic> $ProductDetailsProductsProductImagesToJson(ProductDetailsProductsProductImages entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['product_id'] = entity.productId;
	data['product_image_url'] = entity.productImageUrl;
	return data;
}

ProductDetailsProductsProductStock $ProductDetailsProductsProductStockFromJson(Map<String, dynamic> json) {
	final ProductDetailsProductsProductStock productDetailsProductsProductStock = ProductDetailsProductsProductStock();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		productDetailsProductsProductStock.id = id;
	}
	final dynamic? mainRackNo = jsonConvert.convert<dynamic>(json['main_rack_no']);
	if (mainRackNo != null) {
		productDetailsProductsProductStock.mainRackNo = mainRackNo;
	}
	final String? maxStock = jsonConvert.convert<String>(json['max_stock']);
	if (maxStock != null) {
		productDetailsProductsProductStock.maxStock = maxStock;
	}
	final String? minStock = jsonConvert.convert<String>(json['min_stock']);
	if (minStock != null) {
		productDetailsProductsProductStock.minStock = minStock;
	}
	final String? openingStock = jsonConvert.convert<String>(json['opening_stock']);
	if (openingStock != null) {
		productDetailsProductsProductStock.openingStock = openingStock;
	}
	final int? productId = jsonConvert.convert<int>(json['product_id']);
	if (productId != null) {
		productDetailsProductsProductStock.productId = productId;
	}
	final String? productOfferPrice = jsonConvert.convert<String>(json['product_offer_price']);
	if (productOfferPrice != null) {
		productDetailsProductsProductStock.productOfferPrice = productOfferPrice;
	}
	final String? productPrice = jsonConvert.convert<String>(json['product_price']);
	if (productPrice != null) {
		productDetailsProductsProductStock.productPrice = productPrice;
	}
	final String? productPurchasePrice = jsonConvert.convert<String>(json['product_purchase_price']);
	if (productPurchasePrice != null) {
		productDetailsProductsProductStock.productPurchasePrice = productPurchasePrice;
	}
	final dynamic? subRackNo = jsonConvert.convert<dynamic>(json['sub_rack_no']);
	if (subRackNo != null) {
		productDetailsProductsProductStock.subRackNo = subRackNo;
	}
	return productDetailsProductsProductStock;
}

Map<String, dynamic> $ProductDetailsProductsProductStockToJson(ProductDetailsProductsProductStock entity) {
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