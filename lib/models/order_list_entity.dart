
import 'dart:convert';

import '../generated/json/base/json_field.dart';
import '../generated/json/order_list_entity.g.dart';

@JsonSerializable()
class OrderListEntity {

	late List<OrderListOrders> orders=[];
	@JSONField(name: "return")
	late String xReturn="";
  
  OrderListEntity();

  factory OrderListEntity.fromJson(Map<String, dynamic> json) => $OrderListEntityFromJson(json);

  Map<String, dynamic> toJson() => $OrderListEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class OrderListOrders {

	@JSONField(name: "address_id")
	late int addressId;
	@JSONField(name: "created_at")
	late String createdAt;
	late int id;
	@JSONField(name: "modified_at")
	late String modifiedAt;
	late String status;
	@JSONField(name: "total_price")
	late String totalPrice;
	@JSONField(name: "total_quantity")
	late String totalQuantity;
  
  OrderListOrders();

  factory OrderListOrders.fromJson(Map<String, dynamic> json) => $OrderListOrdersFromJson(json);

  Map<String, dynamic> toJson() => $OrderListOrdersToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}