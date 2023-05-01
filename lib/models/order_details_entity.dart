
import 'dart:convert';

import '../generated/json/base/json_field.dart';
import '../generated/json/order_details_entity.g.dart';

@JsonSerializable()
class OrderDetailsEntity {

	@JSONField(name: "order_details")
	late List<OrderDetailsOrderDetails> orderDetails=[];
	@JSONField(name: "return")
	late String xReturn;
  
  OrderDetailsEntity();

  factory OrderDetailsEntity.fromJson(Map<String, dynamic> json) => $OrderDetailsEntityFromJson(json);

  Map<String, dynamic> toJson() => $OrderDetailsEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class OrderDetailsOrderDetails {

	@JSONField(name: "address_id")
	late int addressId;
	@JSONField(name: "cat_id")
	late int catId;
	@JSONField(name: "fast_delivery")
	dynamic fastDelivery;
	dynamic featured;
	@JSONField(name: "fk_order_id")
	late int fkOrderId;
	@JSONField(name: "fk_product_id")
	late int fkProductId;
	dynamic fresh;
	@JSONField(name: "item_quantity")
	late String itemQuantity;
	dynamic offer;
	@JSONField(name: "order_date")
	late String orderDate;
	@JSONField(name: "order_id")
	late int orderId;
	@JSONField(name: "other_title_ar")
	dynamic otherTitleAr;
	@JSONField(name: "other_title_en")
	dynamic otherTitleEn;
	@JSONField(name: "product_barcode")
	dynamic productBarcode;
	@JSONField(name: "product_cat_id")
	late int productCatId;
	@JSONField(name: "product_code")
	dynamic productCode;
	@JSONField(name: "product_desc_ar")
	late String productDescAr;
	@JSONField(name: "product_desc_en")
	late String productDescEn;
	@JSONField(name: "product_id")
	late int productId;
	@JSONField(name: "product_images")
	late List<OrderDetailsOrderDetailsProductImages> productImages;
	@JSONField(name: "product_name_ar")
	late String productNameAr;
	@JSONField(name: "product_name_en")
	late String productNameEn;
	@JSONField(name: "product_stock")
	late OrderDetailsOrderDetailsProductStock productStock;
	@JSONField(name: "product_subcat_id")
	late int productSubcatId;
	late String status;
	@JSONField(name: "subcat_id")
	late int subcatId;
	@JSONField(name: "unit_quantity")
	late String unitQuantity;
  
  OrderDetailsOrderDetails();

  factory OrderDetailsOrderDetails.fromJson(Map<String, dynamic> json) => $OrderDetailsOrderDetailsFromJson(json);

  Map<String, dynamic> toJson() => $OrderDetailsOrderDetailsToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class OrderDetailsOrderDetailsProductImages {

	late int id;
	@JSONField(name: "product_id")
	late int productId;
	@JSONField(name: "product_image_url")
	late String productImageUrl;
  
  OrderDetailsOrderDetailsProductImages();

  factory OrderDetailsOrderDetailsProductImages.fromJson(Map<String, dynamic> json) => $OrderDetailsOrderDetailsProductImagesFromJson(json);

  Map<String, dynamic> toJson() => $OrderDetailsOrderDetailsProductImagesToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class OrderDetailsOrderDetailsProductStock {

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
  
  OrderDetailsOrderDetailsProductStock();

  factory OrderDetailsOrderDetailsProductStock.fromJson(Map<String, dynamic> json) => $OrderDetailsOrderDetailsProductStockFromJson(json);

  Map<String, dynamic> toJson() => $OrderDetailsOrderDetailsProductStockToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}