
import 'dart:convert';

import '../generated/json/base/json_field.dart';
import '../generated/json/productlist_entity.g.dart';

@JsonSerializable()
class ProductlistEntity {

	late List<ProductlistProducts> products=[];
	@JSONField(name: "return")
	late String xReturn="";
  
  ProductlistEntity();

  factory ProductlistEntity.fromJson(Map<String, dynamic> json) => $ProductlistEntityFromJson(json);

  Map<String, dynamic> toJson() => $ProductlistEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ProductlistProducts {

	@JSONField(name: "cat_id")
	late int catId=0;
	@JSONField(name: "fast_delivery")
	late String fastDelivery="";
	late String featured="";
	late String fresh="";
	late int id=0;
	@JSONField(name: "in_wishlist")
	late bool inWishlist;
	late String offer="";
	@JSONField(name: "other_title_ar")
	late String otherTitleAr="";
	@JSONField(name: "other_title_en")
	late String otherTitleEn="";
	@JSONField(name: "product_barcode")
	late String productBarcode="";
	@JSONField(name: "product_cat_id")
	late int productCatId=0;
	@JSONField(name: "product_code")
	late String productCode="";
	@JSONField(name: "product_desc_ar")
	late String productDescAr="";
	@JSONField(name: "product_desc_en")
	late String productDescEn="";
	@JSONField(name: "product_images")
	late List<ProductlistProductsProductImages> productImages=[];
	@JSONField(name: "product_name_ar")
	late String productNameAr="";
	@JSONField(name: "product_name_en")
	late String productNameEn="";
	@JSONField(name: "product_stock")
	late List<ProductlistProductsProductStock> productStock=[];
	@JSONField(name: "product_subcat_id")
	late int productSubcatId=0;
	late String status="";
	@JSONField(name: "subcat_id")
	late int subcatId=0;
	@JSONField(name: "unit_quantity")
	late String unitQuantity="";
	bool ispricesame=false;
	bool isaddedcart=false;
  
  ProductlistProducts();

  factory ProductlistProducts.fromJson(Map<String, dynamic> json) => $ProductlistProductsFromJson(json);

  Map<String, dynamic> toJson() => $ProductlistProductsToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ProductlistProductsProductImages {

	late int id;
	@JSONField(name: "product_id")
	late int productId;
	@JSONField(name: "product_image_url")
	late String productImageUrl;
  
  ProductlistProductsProductImages();

  factory ProductlistProductsProductImages.fromJson(Map<String, dynamic> json) => $ProductlistProductsProductImagesFromJson(json);

  Map<String, dynamic> toJson() => $ProductlistProductsProductImagesToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ProductlistProductsProductStock {

	late int id;
	@JSONField(name: "main_rack_no")
	dynamic mainRackNo;
	@JSONField(name: "max_stock")
	late String maxStock;
	@JSONField(name: "min_stock")
	late String minStock;
	@JSONField(name: "opening_stock")
	late String openingStock;
	@JSONField(name: "product_id")
	late int productId;
	@JSONField(name: "product_offer_price")
	late String productOfferPrice;
	@JSONField(name: "product_price")
	late String productPrice;
	@JSONField(name: "product_purchase_price")
	late String productPurchasePrice;
	@JSONField(name: "sub_rack_no")
	dynamic subRackNo;
  
  ProductlistProductsProductStock();

  factory ProductlistProductsProductStock.fromJson(Map<String, dynamic> json) => $ProductlistProductsProductStockFromJson(json);

  Map<String, dynamic> toJson() => $ProductlistProductsProductStockToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}