import 'package:kenz_market_new/generated/json/base/json_field.dart';
import 'package:kenz_market_new/generated/json/vouchers_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class VouchersEntity {

	late List<VouchersCoupons> coupons=[];
  
  VouchersEntity();

  factory VouchersEntity.fromJson(Map<String, dynamic> json) => $VouchersEntityFromJson(json);

  Map<String, dynamic> toJson() => $VouchersEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class VouchersCoupons {

	@JSONField(name: "active_status")
	late bool activeStatus=false;
	@JSONField(name: "coupon_code")
	late String couponCode="";
	@JSONField(name: "coupon_id")
	late int couponId=0;
	@JSONField(name: "coupon_name")
	late String couponName="";
	@JSONField(name: "created_at")
	dynamic createdAt="";
	late int quantity=0;
	@JSONField(name: "reduction_amount")
	late double reductionAmount=0;
  
  VouchersCoupons();

  factory VouchersCoupons.fromJson(Map<String, dynamic> json) => $VouchersCouponsFromJson(json);

  Map<String, dynamic> toJson() => $VouchersCouponsToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}