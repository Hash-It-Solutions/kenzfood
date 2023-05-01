
import 'dart:convert';

import '../generated/json/base/json_field.dart';
import '../generated/json/productstock_entity.g.dart';

@JsonSerializable()
class ProductstockEntity {

	@JSONField(name: "product_stocks")
	late List<ProductstockProductStocks> productStocks=[];
	@JSONField(name: "return")
	late String xReturn;
  
  ProductstockEntity();

  factory ProductstockEntity.fromJson(Map<String, dynamic> json) => $ProductstockEntityFromJson(json);

  Map<String, dynamic> toJson() => $ProductstockEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class ProductstockProductStocks {

	late int id=0;
	@JSONField(name: "main_rack_no")
	dynamic mainRackNo="";
	@JSONField(name: "max_stock")
	late String maxStock="";
	@JSONField(name: "min_stock")
	late String minStock="";
	@JSONField(name: "opening_stock")
	late String openingStock="";
	@JSONField(name: "product_offer_price")
	late String productOfferPrice="";
	@JSONField(name: "product_price")
	late String productPrice="";
	@JSONField(name: "product_purchase_price")
	late String productPurchasePrice="";
	@JSONField(name: "sub_rack_no")
	dynamic subRackNo="";
  
  ProductstockProductStocks();

  factory ProductstockProductStocks.fromJson(Map<String, dynamic> json) => $ProductstockProductStocksFromJson(json);

  Map<String, dynamic> toJson() => $ProductstockProductStocksToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}