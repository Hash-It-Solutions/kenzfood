import 'package:kenz_market_new/generated/json/base/json_convert_content.dart';
import 'package:kenz_market_new/models/order_list_entity.dart';

OrderListEntity $OrderListEntityFromJson(Map<String, dynamic> json) {
	final OrderListEntity orderListEntity = OrderListEntity();
	final List<OrderListOrders>? orders = jsonConvert.convertListNotNull<OrderListOrders>(json['orders']);
	if (orders != null) {
		orderListEntity.orders = orders;
	}
	final String? xReturn = jsonConvert.convert<String>(json['return']);
	if (xReturn != null) {
		orderListEntity.xReturn = xReturn;
	}
	return orderListEntity;
}

Map<String, dynamic> $OrderListEntityToJson(OrderListEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['orders'] =  entity.orders.map((v) => v.toJson()).toList();
	data['return'] = entity.xReturn;
	return data;
}

OrderListOrders $OrderListOrdersFromJson(Map<String, dynamic> json) {
	final OrderListOrders orderListOrders = OrderListOrders();
	final int? addressId = jsonConvert.convert<int>(json['address_id']);
	if (addressId != null) {
		orderListOrders.addressId = addressId;
	}
	final String? createdAt = jsonConvert.convert<String>(json['created_at']);
	if (createdAt != null) {
		orderListOrders.createdAt = createdAt;
	}
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		orderListOrders.id = id;
	}
	final String? modifiedAt = jsonConvert.convert<String>(json['modified_at']);
	if (modifiedAt != null) {
		orderListOrders.modifiedAt = modifiedAt;
	}
	final String? status = jsonConvert.convert<String>(json['status']);
	if (status != null) {
		orderListOrders.status = status;
	}
	final String? totalPrice = jsonConvert.convert<String>(json['total_price']);
	if (totalPrice != null) {
		orderListOrders.totalPrice = totalPrice;
	}
	final String? totalQuantity = jsonConvert.convert<String>(json['total_quantity']);
	if (totalQuantity != null) {
		orderListOrders.totalQuantity = totalQuantity;
	}
	return orderListOrders;
}

Map<String, dynamic> $OrderListOrdersToJson(OrderListOrders entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['address_id'] = entity.addressId;
	data['created_at'] = entity.createdAt;
	data['id'] = entity.id;
	data['modified_at'] = entity.modifiedAt;
	data['status'] = entity.status;
	data['total_price'] = entity.totalPrice;
	data['total_quantity'] = entity.totalQuantity;
	return data;
}