import 'package:designerwardrobe/src/features/home/data/remote/dtos/brands_by_category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'complete_purchase_parameter.g.dart';

@JsonSerializable()
class CompletePurchaseParameter {
  @JsonKey()
  final String? action;
  @JsonKey(name: 'payment_method_nonce')
  final String? paymentMethodNonce;
  @JsonKey()
  final List<PaymentInfo>? payment;
  @JsonKey(name: 'kount_device_data')
  final String? kountDeviceData;
  @JsonKey(name: 'listing_id')
  final int? listingId;
  @JsonKey(name: 'shipping_code')
  final String? shippingCode;
  @JsonKey(name: 'user_address_id')
  final String? userAddressId;
  @JsonKey(name: 'check_rural')
  final bool? checkRural;
  @JsonKey(name: 'store_pickup_id')
  final String? storePickupId;
  @JsonKey(name: 'delivery_instructions')
  final String? deliveryInstructions;
  @JsonKey(name: 'use_credit')
  final bool? useCredit;
  @JsonKey(name: 'listing_rental_start_date')
  final String? listingRentalStartDate;
  @JsonKey(name: 'listing_rental_end_date')
  final String? listingRentalEndDate;
  @JsonKey(name: 'promo_code')
  final String? promoCode;
  @JsonKey(name: 'mobile_phone')
  final String? mobilePhone;
  @JsonKey(name: 'purchase_size')
  final String? purchaseSize;
  @JsonKey(name: 'rental_insurance')
  final String? rentalInsurance;
  @JsonKey(name: 'nipple_covers')
  final bool? nippleCovers;
  @JsonKey(name: 'fabric_tape')
  final bool? fabricTape;
  @JsonKey(name: 'booby_tape')
  final bool? boobyTape;
  @JsonKey(name: 'booby_tape_colour')
  final String? boobyTapeColour;
  @JsonKey(name: 'stick_ons')
  final bool? stickOns;
  @JsonKey(name: 'self_tan_mousse')
  final bool? selfTanMousse;
  @JsonKey(name: 'tanning_mitt')
  final bool? tanningMitt;
  @JsonKey(name: 'face_tan_mist')
  final bool? faceTanMist;
  @JsonKey(name: 'include_rental_return_bag')
  final String? includeRentalReturnBag;
  @JsonKey(name: 'include_rental_delivery_bag')
  final String? includeRentalDeliveryBag;
  @JsonKey(name: 'rental_pickup')
  final String? rentalPickup;
  @JsonKey(name: 'rental_drop_off')
  final String? rentalDropOff;
  @JsonKey(name: 'store_dropoff_id')
  final String? storeDropoffId;
  @JsonKey(name: 'is_instore')
  final bool? isInstore;
  @JsonKey(name: 'kiosk_store')
  final String? kioskStore;
  @JsonKey(name: 'kiosk_number')
  final String? kioskNumber;
  @JsonKey(name: 'eftpos_card_details')
  final String? eftposCardDetails;
  @JsonKey(name: 'has_pp_sms_reminder')
  final bool? hasPpSmsReminder;

  CompletePurchaseParameter({

    this.action,
    this.paymentMethodNonce,
    this.payment,
    this.kountDeviceData,
    this.listingId,
    this.shippingCode,
    this.userAddressId,
    this.checkRural,
    this.storePickupId,
    this.deliveryInstructions,
    this.useCredit,
    this.listingRentalStartDate,
    this.listingRentalEndDate,
    this.promoCode,
    this.mobilePhone,
    this.purchaseSize,
    this.rentalInsurance,
    this.nippleCovers,
    this.fabricTape,
    this.boobyTape,
    this.boobyTapeColour,
    this.stickOns,
    this.selfTanMousse,
    this.tanningMitt,
    this.faceTanMist,
    this.includeRentalReturnBag,
    this.includeRentalDeliveryBag,
    this.rentalPickup,
    this.rentalDropOff,
    this.storeDropoffId,
    this.isInstore,
    this.kioskStore,
    this.kioskNumber,
    this.eftposCardDetails,
    this.hasPpSmsReminder
  });

  factory CompletePurchaseParameter.fromJson(Map<String, dynamic> json) => _$CompletePurchaseParameterFromJson(json);

  Map<String, dynamic> toJson() => _$CompletePurchaseParameterToJson(this);
}

@JsonSerializable()
class PaymentInfo {
  @JsonKey()
  final String? action;
  @JsonKey()
  final String? method;
  @JsonKey()
  final double? amount;
  @JsonKey()
  final String? code;

  PaymentInfo({
    this.action,
    this.method,
    this.amount,
    this.code,
  });

  factory PaymentInfo.fromJson(Map<String, dynamic> json) => _$PaymentInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentInfoToJson(this);

  @override
  String toString() {
    return '{action: $action, method: $method, amount: $amount, code: $code}';
  }
}

// {
//   "action": "windcave",
//   "payment_method_nonce": "000004001227709104150fe307a2c6a1",
//   "payment": [
//     {
//       "action": "windcave",
//       "method": "credit_card",
//       "amount": 300,
//       "code": "000004001227709104150fe307a2c6a1"
//     }
//   ],
//   "kount_device_data": null,
//   "listing_id": 3396348,
//   "shipping_code": "standard_shipping",
//   "user_address_id": 320147,
//   "check_rural": false,
//   "store_pickup_id": null,
//   "delivery_instructions": "NOTHING",
//   "use_credit": false,
//   "listing_rental_start_date": "",
//   "listing_rental_end_date": "",
//   "promo_code": null,
//   "mobile_phone": "0287601421",
//   "purchase_size": null,
//   "rental_insurance": null,
//   "nipple_covers": false,
//   "fabric_tape": false,
//   "booby_tape": false,
//   "booby_tape_colour": null,
//   "stick_ons": false,
//   "self_tan_mousse": false,
//   "tanning_mitt": false,
//   "face_tan_mist": false,
//   "include_rental_return_bag": null,
//   "include_rental_delivery_bag": null,
//   "rental_pickup": null,
//   "rental_drop_off": null,
//   "store_dropoff_id": null,
//   "is_instore": false,
//   "kiosk_store": null,
//   "kiosk_number": null,
//   "eftpos_card_details": null,
//   "has_pp_sms_reminder": true,
//   "rip_stain_insurance": "yes"
// }