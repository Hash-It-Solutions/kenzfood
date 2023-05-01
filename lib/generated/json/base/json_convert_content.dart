// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:flutter/material.dart' show debugPrint;
import 'package:kenz_market_new/models/address_entity.dart';
import 'package:kenz_market_new/models/banner_entity.dart';
import 'package:kenz_market_new/models/cart_entity.dart';
import 'package:kenz_market_new/models/category_list_entity.dart';
import 'package:kenz_market_new/models/delivery_charge_data_entity.dart';
import 'package:kenz_market_new/models/notification_list_entity.dart';
import 'package:kenz_market_new/models/order_details_entity.dart';
import 'package:kenz_market_new/models/order_list_entity.dart';
import 'package:kenz_market_new/models/product_details_entity.dart';
import 'package:kenz_market_new/models/product_image_entity.dart';
import 'package:kenz_market_new/models/productlist_entity.dart';
import 'package:kenz_market_new/models/productstock_entity.dart';
import 'package:kenz_market_new/models/sub_category_list_entity.dart';
import 'package:kenz_market_new/models/vouchers_entity.dart';
import 'package:kenz_market_new/models/wishlist_entity.dart';

JsonConvert jsonConvert = JsonConvert();
typedef JsonConvertFunction<T> = T Function(Map<String, dynamic> json);

class JsonConvert {
	static final Map<String, JsonConvertFunction> _convertFuncMap = {
		(AddressEntity).toString(): AddressEntity.fromJson,
		(AddressData).toString(): AddressData.fromJson,
		(BannerEntity).toString(): BannerEntity.fromJson,
		(BannerData).toString(): BannerData.fromJson,
		(CartEntity).toString(): CartEntity.fromJson,
		(CartCartItems).toString(): CartCartItems.fromJson,
		(CartCartItemsProductImages).toString(): CartCartItemsProductImages.fromJson,
		(CartCartItemsProductStock).toString(): CartCartItemsProductStock.fromJson,
		(CategoryListEntity).toString(): CategoryListEntity.fromJson,
		(CategoryListCategories).toString(): CategoryListCategories.fromJson,
		(DeliveryChargeDataEntity).toString(): DeliveryChargeDataEntity.fromJson,
		(NotificationListEntity).toString(): NotificationListEntity.fromJson,
		(NotificationListData).toString(): NotificationListData.fromJson,
		(OrderDetailsEntity).toString(): OrderDetailsEntity.fromJson,
		(OrderDetailsOrderDetails).toString(): OrderDetailsOrderDetails.fromJson,
		(OrderDetailsOrderDetailsProductImages).toString(): OrderDetailsOrderDetailsProductImages.fromJson,
		(OrderDetailsOrderDetailsProductStock).toString(): OrderDetailsOrderDetailsProductStock.fromJson,
		(OrderListEntity).toString(): OrderListEntity.fromJson,
		(OrderListOrders).toString(): OrderListOrders.fromJson,
		(ProductDetailsEntity).toString(): ProductDetailsEntity.fromJson,
		(ProductDetailsProducts).toString(): ProductDetailsProducts.fromJson,
		(ProductDetailsProductsProductImages).toString(): ProductDetailsProductsProductImages.fromJson,
		(ProductDetailsProductsProductStock).toString(): ProductDetailsProductsProductStock.fromJson,
		(ProductImageEntity).toString(): ProductImageEntity.fromJson,
		(ProductlistEntity).toString(): ProductlistEntity.fromJson,
		(ProductlistProducts).toString(): ProductlistProducts.fromJson,
		(ProductlistProductsProductImages).toString(): ProductlistProductsProductImages.fromJson,
		(ProductlistProductsProductStock).toString(): ProductlistProductsProductStock.fromJson,
		(ProductstockEntity).toString(): ProductstockEntity.fromJson,
		(ProductstockProductStocks).toString(): ProductstockProductStocks.fromJson,
		(SubCategoryListEntity).toString(): SubCategoryListEntity.fromJson,
		(SubCategoryListSubcategories).toString(): SubCategoryListSubcategories.fromJson,
		(VouchersEntity).toString(): VouchersEntity.fromJson,
		(VouchersCoupons).toString(): VouchersCoupons.fromJson,
		(WishlistEntity).toString(): WishlistEntity.fromJson,
		(WishlistData).toString(): WishlistData.fromJson,
		(WishlistDataProductImages).toString(): WishlistDataProductImages.fromJson,
		(WishlistDataProductStock).toString(): WishlistDataProductStock.fromJson,
	};

  T? convert<T>(dynamic value) {
    if (value == null) {
      return null;
    }
    return asT<T>(value);
  }

  List<T?>? convertList<T>(List<dynamic>? value) {
    if (value == null) {
      return null;
    }
    try {
      return value.map((dynamic e) => asT<T>(e)).toList();
    } catch (e, stackTrace) {
      debugPrint('asT<$T> $e $stackTrace');
      return <T>[];
    }
  }

  List<T>? convertListNotNull<T>(dynamic value) {
    if (value == null) {
      return null;
    }
    try {
      return (value as List<dynamic>).map((dynamic e) => asT<T>(e)!).toList();
    } catch (e, stackTrace) {
      debugPrint('asT<$T> $e $stackTrace');
      return <T>[];
    }
  }

  T? asT<T extends Object?>(dynamic value) {
    if (value is T) {
      return value;
    }
    final String type = T.toString();
    try {
      final String valueS = value.toString();
      if (type == "String") {
        return valueS as T;
      } else if (type == "int") {
        final int? intValue = int.tryParse(valueS);
        if (intValue == null) {
          return double.tryParse(valueS)?.toInt() as T?;
        } else {
          return intValue as T;
        }
      } else if (type == "double") {
        return double.parse(valueS) as T;
      } else if (type == "DateTime") {
        return DateTime.parse(valueS) as T;
      } else if (type == "bool") {
        if (valueS == '0' || valueS == '1') {
          return (valueS == '1') as T;
        }
        return (valueS == 'true') as T;
      } else if (type == "Map" || type.startsWith("Map<")) {
        return value as T;
      } else {
        if (_convertFuncMap.containsKey(type)) {
          return _convertFuncMap[type]!(value) as T;
        } else {
          throw UnimplementedError('$type unimplemented');
        }
      }
    } catch (e, stackTrace) {
      debugPrint('asT<$T> $e $stackTrace');
      return null;
    }
  }

	//list is returned by type
	static M? _getListChildType<M>(List<Map<String, dynamic>> data) {
		if(<AddressEntity>[] is M){
			return data.map<AddressEntity>((Map<String, dynamic> e) => AddressEntity.fromJson(e)).toList() as M;
		}
		if(<AddressData>[] is M){
			return data.map<AddressData>((Map<String, dynamic> e) => AddressData.fromJson(e)).toList() as M;
		}
		if(<BannerEntity>[] is M){
			return data.map<BannerEntity>((Map<String, dynamic> e) => BannerEntity.fromJson(e)).toList() as M;
		}
		if(<BannerData>[] is M){
			return data.map<BannerData>((Map<String, dynamic> e) => BannerData.fromJson(e)).toList() as M;
		}
		if(<CartEntity>[] is M){
			return data.map<CartEntity>((Map<String, dynamic> e) => CartEntity.fromJson(e)).toList() as M;
		}
		if(<CartCartItems>[] is M){
			return data.map<CartCartItems>((Map<String, dynamic> e) => CartCartItems.fromJson(e)).toList() as M;
		}
		if(<CartCartItemsProductImages>[] is M){
			return data.map<CartCartItemsProductImages>((Map<String, dynamic> e) => CartCartItemsProductImages.fromJson(e)).toList() as M;
		}
		if(<CartCartItemsProductStock>[] is M){
			return data.map<CartCartItemsProductStock>((Map<String, dynamic> e) => CartCartItemsProductStock.fromJson(e)).toList() as M;
		}
		if(<CategoryListEntity>[] is M){
			return data.map<CategoryListEntity>((Map<String, dynamic> e) => CategoryListEntity.fromJson(e)).toList() as M;
		}
		if(<CategoryListCategories>[] is M){
			return data.map<CategoryListCategories>((Map<String, dynamic> e) => CategoryListCategories.fromJson(e)).toList() as M;
		}
		if(<DeliveryChargeDataEntity>[] is M){
			return data.map<DeliveryChargeDataEntity>((Map<String, dynamic> e) => DeliveryChargeDataEntity.fromJson(e)).toList() as M;
		}
		if(<NotificationListEntity>[] is M){
			return data.map<NotificationListEntity>((Map<String, dynamic> e) => NotificationListEntity.fromJson(e)).toList() as M;
		}
		if(<NotificationListData>[] is M){
			return data.map<NotificationListData>((Map<String, dynamic> e) => NotificationListData.fromJson(e)).toList() as M;
		}
		if(<OrderDetailsEntity>[] is M){
			return data.map<OrderDetailsEntity>((Map<String, dynamic> e) => OrderDetailsEntity.fromJson(e)).toList() as M;
		}
		if(<OrderDetailsOrderDetails>[] is M){
			return data.map<OrderDetailsOrderDetails>((Map<String, dynamic> e) => OrderDetailsOrderDetails.fromJson(e)).toList() as M;
		}
		if(<OrderDetailsOrderDetailsProductImages>[] is M){
			return data.map<OrderDetailsOrderDetailsProductImages>((Map<String, dynamic> e) => OrderDetailsOrderDetailsProductImages.fromJson(e)).toList() as M;
		}
		if(<OrderDetailsOrderDetailsProductStock>[] is M){
			return data.map<OrderDetailsOrderDetailsProductStock>((Map<String, dynamic> e) => OrderDetailsOrderDetailsProductStock.fromJson(e)).toList() as M;
		}
		if(<OrderListEntity>[] is M){
			return data.map<OrderListEntity>((Map<String, dynamic> e) => OrderListEntity.fromJson(e)).toList() as M;
		}
		if(<OrderListOrders>[] is M){
			return data.map<OrderListOrders>((Map<String, dynamic> e) => OrderListOrders.fromJson(e)).toList() as M;
		}
		if(<ProductDetailsEntity>[] is M){
			return data.map<ProductDetailsEntity>((Map<String, dynamic> e) => ProductDetailsEntity.fromJson(e)).toList() as M;
		}
		if(<ProductDetailsProducts>[] is M){
			return data.map<ProductDetailsProducts>((Map<String, dynamic> e) => ProductDetailsProducts.fromJson(e)).toList() as M;
		}
		if(<ProductDetailsProductsProductImages>[] is M){
			return data.map<ProductDetailsProductsProductImages>((Map<String, dynamic> e) => ProductDetailsProductsProductImages.fromJson(e)).toList() as M;
		}
		if(<ProductDetailsProductsProductStock>[] is M){
			return data.map<ProductDetailsProductsProductStock>((Map<String, dynamic> e) => ProductDetailsProductsProductStock.fromJson(e)).toList() as M;
		}
		if(<ProductImageEntity>[] is M){
			return data.map<ProductImageEntity>((Map<String, dynamic> e) => ProductImageEntity.fromJson(e)).toList() as M;
		}
		if(<ProductlistEntity>[] is M){
			return data.map<ProductlistEntity>((Map<String, dynamic> e) => ProductlistEntity.fromJson(e)).toList() as M;
		}
		if(<ProductlistProducts>[] is M){
			return data.map<ProductlistProducts>((Map<String, dynamic> e) => ProductlistProducts.fromJson(e)).toList() as M;
		}
		if(<ProductlistProductsProductImages>[] is M){
			return data.map<ProductlistProductsProductImages>((Map<String, dynamic> e) => ProductlistProductsProductImages.fromJson(e)).toList() as M;
		}
		if(<ProductlistProductsProductStock>[] is M){
			return data.map<ProductlistProductsProductStock>((Map<String, dynamic> e) => ProductlistProductsProductStock.fromJson(e)).toList() as M;
		}
		if(<ProductstockEntity>[] is M){
			return data.map<ProductstockEntity>((Map<String, dynamic> e) => ProductstockEntity.fromJson(e)).toList() as M;
		}
		if(<ProductstockProductStocks>[] is M){
			return data.map<ProductstockProductStocks>((Map<String, dynamic> e) => ProductstockProductStocks.fromJson(e)).toList() as M;
		}
		if(<SubCategoryListEntity>[] is M){
			return data.map<SubCategoryListEntity>((Map<String, dynamic> e) => SubCategoryListEntity.fromJson(e)).toList() as M;
		}
		if(<SubCategoryListSubcategories>[] is M){
			return data.map<SubCategoryListSubcategories>((Map<String, dynamic> e) => SubCategoryListSubcategories.fromJson(e)).toList() as M;
		}
		if(<VouchersEntity>[] is M){
			return data.map<VouchersEntity>((Map<String, dynamic> e) => VouchersEntity.fromJson(e)).toList() as M;
		}
		if(<VouchersCoupons>[] is M){
			return data.map<VouchersCoupons>((Map<String, dynamic> e) => VouchersCoupons.fromJson(e)).toList() as M;
		}
		if(<WishlistEntity>[] is M){
			return data.map<WishlistEntity>((Map<String, dynamic> e) => WishlistEntity.fromJson(e)).toList() as M;
		}
		if(<WishlistData>[] is M){
			return data.map<WishlistData>((Map<String, dynamic> e) => WishlistData.fromJson(e)).toList() as M;
		}
		if(<WishlistDataProductImages>[] is M){
			return data.map<WishlistDataProductImages>((Map<String, dynamic> e) => WishlistDataProductImages.fromJson(e)).toList() as M;
		}
		if(<WishlistDataProductStock>[] is M){
			return data.map<WishlistDataProductStock>((Map<String, dynamic> e) => WishlistDataProductStock.fromJson(e)).toList() as M;
		}

		debugPrint("${M.toString()} not found");
	
		return null;
}

	static M? fromJsonAsT<M>(dynamic json) {
		if (json is List) {
			return _getListChildType<M>(json.map((e) => e as Map<String, dynamic>).toList());
		} else {
			return jsonConvert.asT<M>(json);
		}
	}
}