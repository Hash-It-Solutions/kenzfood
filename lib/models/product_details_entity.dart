import 'package:kenz_market_new/generated/json/base/json_field.dart';
import 'package:kenz_market_new/generated/json/product_details_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class ProductDetailsEntity {

	late List<ProductDetailsProducts> products=[];
	@JSONField(name: "return")
	late String xReturn="";
  
  ProductDetailsEntity();

  factory ProductDetailsEntity.fromJson(Map<String, dynamic> json) => $ProductDetailsEntityFromJson(json);

  Map<String, dynamic> toJson() => $ProductDetailsEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ProductDetailsProducts {

	@JSONField(name: "cat_id")
	late int catId=0;
	@JSONField(name: "fast_delivery")
	late String fastDelivery="";
	late String featured="";
	late String fresh="";
	late int id=0;
	@JSONField(name: "in_wishlist")
	late bool inWishlist=false;
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
	late List<ProductDetailsProductsProductImages> productImages=[];
	@JSONField(name: "product_name_ar")
	late String productNameAr="";
	@JSONField(name: "product_name_en")
	late String productNameEn="";
	@JSONField(name: "product_stock")
	late List<ProductDetailsProductsProductStock> productStock=[];
	@JSONField(name: "product_subcat_id")
	late int productSubcatId=0;
	late String status="";
	@JSONField(name: "subcat_id")
	late int subcatId=0;
	@JSONField(name: "unit_quantity")
	late String unitQuantity="";
  
  ProductDetailsProducts();

  factory ProductDetailsProducts.fromJson(Map<String, dynamic> json) => $ProductDetailsProductsFromJson(json);

  Map<String, dynamic> toJson() => $ProductDetailsProductsToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ProductDetailsProductsProductImages {

	late int id;
	@JSONField(name: "product_id")
	late int productId;
	@JSONField(name: "product_image_url")
	late String productImageUrl;
  
  ProductDetailsProductsProductImages();

  factory ProductDetailsProductsProductImages.fromJson(Map<String, dynamic> json) => $ProductDetailsProductsProductImagesFromJson(json);

  Map<String, dynamic> toJson() => $ProductDetailsProductsProductImagesToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ProductDetailsProductsProductStock {

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
  
  ProductDetailsProductsProductStock();

  factory ProductDetailsProductsProductStock.fromJson(Map<String, dynamic> json) => $ProductDetailsProductsProductStockFromJson(json);

  Map<String, dynamic> toJson() => $ProductDetailsProductsProductStockToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}