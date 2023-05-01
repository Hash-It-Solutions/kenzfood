import 'package:kenz_market_new/generated/json/base/json_convert_content.dart';
import 'package:kenz_market_new/models/vouchers_entity.dart';

VouchersEntity $VouchersEntityFromJson(Map<String, dynamic> json) {
	final VouchersEntity vouchersEntity = VouchersEntity();
	final List<VouchersCoupons>? coupons = jsonConvert.convertListNotNull<VouchersCoupons>(json['coupons']);
	if (coupons != null) {
		vouchersEntity.coupons = coupons;
	}
	return vouchersEntity;
}

Map<String, dynamic> $VouchersEntityToJson(VouchersEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['coupons'] =  entity.coupons.map((v) => v.toJson()).toList();
	return data;
}

VouchersCoupons $VouchersCouponsFromJson(Map<String, dynamic> json) {
	final VouchersCoupons vouchersCoupons = VouchersCoupons();
	final bool? activeStatus = jsonConvert.convert<bool>(json['active_status']);
	if (activeStatus != null) {
		vouchersCoupons.activeStatus = activeStatus;
	}
	final String? couponCode = jsonConvert.convert<String>(json['coupon_code']);
	if (couponCode != null) {
		vouchersCoupons.couponCode = couponCode;
	}
	final int? couponId = jsonConvert.convert<int>(json['coupon_id']);
	if (couponId != null) {
		vouchersCoupons.couponId = couponId;
	}
	final String? couponName = jsonConvert.convert<String>(json['coupon_name']);
	if (couponName != null) {
		vouchersCoupons.couponName = couponName;
	}
	final dynamic? createdAt = jsonConvert.convert<dynamic>(json['created_at']);
	if (createdAt != null) {
		vouchersCoupons.createdAt = createdAt;
	}
	final int? quantity = jsonConvert.convert<int>(json['quantity']);
	if (quantity != null) {
		vouchersCoupons.quantity = quantity;
	}
	final double? reductionAmount = jsonConvert.convert<double>(json['reduction_amount']);
	if (reductionAmount != null) {
		vouchersCoupons.reductionAmount = reductionAmount;
	}
	return vouchersCoupons;
}

Map<String, dynamic> $VouchersCouponsToJson(VouchersCoupons entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['active_status'] = entity.activeStatus;
	data['coupon_code'] = entity.couponCode;
	data['coupon_id'] = entity.couponId;
	data['coupon_name'] = entity.couponName;
	data['created_at'] = entity.createdAt;
	data['quantity'] = entity.quantity;
	data['reduction_amount'] = entity.reductionAmount;
	return data;
}