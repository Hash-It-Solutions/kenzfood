
import 'dart:convert';

import '../generated/json/base/json_field.dart';
import '../generated/json/cart_entity.g.dart';

@JsonSerializable()
class CartEntity {

	@JSONField(name: "cart_items")
	late List<CartCartItems> cartItems=[];
	@JSONField(name: "return")
	late String xReturn;
  
  CartEntity();

  factory CartEntity.fromJson(Map<String, dynamic> json) => $CartEntityFromJson(json);

  Map<String, dynamic> toJson() => $CartEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class CartCartItems {

	@JSONField(name: "cat_id")
	late int catId=0;
	@JSONField(name: "created_at")
	late String createdAt="";
	@JSONField(name: "fast_delivery")
	dynamic fastDelivery="";
	dynamic featured="";
	dynamic fresh="";
	late int id=0;
	@JSONField(name: "modified_at")
	late String modifiedAt="";
	dynamic offer="";
	@JSONField(name: "other_title_ar")
	dynamic otherTitleAr="";
	@JSONField(name: "other_title_en")
	dynamic otherTitleEn="";
	@JSONField(name: "product_barcode")
	dynamic productBarcode="";
	@JSONField(name: "product_cat_id")
	late int productCatId=0;
	@JSONField(name: "product_code")
	dynamic productCode="";
	@JSONField(name: "product_desc_ar")
	late String productDescAr="";
	@JSONField(name: "product_desc_en")
	late String productDescEn="";
	@JSONField(name: "product_id")
	late int productId=0;
	@JSONField(name: "product_images")
	late List<CartCartItemsProductImages> productImages=[];
	@JSONField(name: "product_name_ar")
	late String productNameAr="";
	@JSONField(name: "product_name_en")
	late String productNameEn="";
	@JSONField(name: "product_stock")
	late CartCartItemsProductStock productStock;
	@JSONField(name: "product_subcat_id")
	late int productSubcatId=0;
	late String quantity="";
	late String status="";
	@JSONField(name: "subcat_id")
	late int subcatId=0;
	@JSONField(name: "unit_quantity")
	late String unitQuantity="";
	@JSONField(name: "user_id")
	late int userId=0;
  
  CartCartItems();

  factory CartCartItems.fromJson(Map<String, dynamic> json) => $CartCartItemsFromJson(json);

  Map<String, dynamic> toJson() => $CartCartItemsToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class CartCartItemsProductImages {

	late int id;
	@JSONField(name: "product_id")
	late int productId;
	@JSONField(name: "product_image_url")
	late String productImageUrl;
  
  CartCartItemsProductImages();

  factory CartCartItemsProductImages.fromJson(Map<String, dynamic> json) => $CartCartItemsProductImagesFromJson(json);

  Map<String, dynamic> toJson() => $CartCartItemsProductImagesToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class CartCartItemsProductStock {

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
  
  CartCartItemsProductStock();

  factory CartCartItemsProductStock.fromJson(Map<String, dynamic> json) => $CartCartItemsProductStockFromJson(json);

  Map<String, dynamic> toJson() => $CartCartItemsProductStockToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}