import 'package:json_annotation/json_annotation.dart';

part 'payment_info_response.g.dart';

@JsonSerializable()
class PaymentInfoResponse {
  @JsonKey(name: 'show_afterpay')
  final bool? showAfterpay;
  @JsonKey(name: 'delivery_options')
  final List<DeliveryOption>? deliveryOptions;
  @JsonKey(name: 'pricing')
  final Pricing? pricing;
  @JsonKey(name: 'available_payment_methods')
  final AvailablePaymentMethods? availablePaymentMethods;
  @JsonKey(name: 'promo_code')
  final PromoCode? promoCode;

  PaymentInfoResponse({
    this.showAfterpay,
    this.deliveryOptions,
    this.pricing,
    this.availablePaymentMethods,
    this.promoCode,
  });

  factory PaymentInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentInfoResponseToJson(this);
}

@JsonSerializable()
class DeliveryOption {
  final String? code;
  final String? name;
  final String? price;

  DeliveryOption({this.code, this.name, this.price});

  factory DeliveryOption.fromJson(Map<String, dynamic> json) =>
      _$DeliveryOptionFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryOptionToJson(this);
}

@JsonSerializable()
class Pricing {
  final String? currency;
  @JsonKey(name: 'listing_price')
  final double? listingPrice;
  @JsonKey(name: 'shipping_fee')
  final double? shippingFee;
  @JsonKey(name: 'rural_fee')
  final double? ruralFee;
  @JsonKey(name: 'dw_cash_amount')
  final DwAmount? dwCashAmount;
  @JsonKey(name: 'dw_credit_amount')
  final DwAmount? dwCreditAmount;
  @JsonKey(name: 'gift_card')
  final GiftCard? giftCard;
  @JsonKey(name: 'total_to_pay')
  final double? totalToPay;

  Pricing({
    this.currency,
    this.listingPrice,
    this.shippingFee,
    this.ruralFee,
    this.dwCashAmount,
    this.dwCreditAmount,
    this.giftCard,
    this.totalToPay,
  });

  factory Pricing.fromJson(Map<String, dynamic> json) =>
      _$PricingFromJson(json);

  Map<String, dynamic> toJson() => _$PricingToJson(this);
}

@JsonSerializable()
class DwAmount {
  final String? currency;
  final double? amount;
  @JsonKey(name: 'amount_to_use')
  final double? amountToUse;

  DwAmount({this.currency, this.amount, this.amountToUse});

  factory DwAmount.fromJson(Map<String, dynamic> json) =>
      _$DwAmountFromJson(json);

  Map<String, dynamic> toJson() => _$DwAmountToJson(this);
}

@JsonSerializable()
class GiftCard {
  final String? code;
  @JsonKey(name: 'available_amount')
  final double? availableAmount;
  @JsonKey(name: 'amount_to_use')
  final double? amountToUse;
  @JsonKey(name: 'can_be_redeemed')
  final bool? canBeRedeemed;
  @JsonKey(name: 'error_message')
  final String? errorMessage;

  GiftCard({
    this.code,
    this.availableAmount,
    this.amountToUse,
    this.canBeRedeemed,
    this.errorMessage,
  });

  factory GiftCard.fromJson(Map<String, dynamic> json) =>
      _$GiftCardFromJson(json);

  Map<String, dynamic> toJson() => _$GiftCardToJson(this);
}

@JsonSerializable()
class AvailablePaymentMethods {
  final bool? windcave;
  final bool? afterpay;
  final bool? zip;
  final bool? paypal;
  final bool? braintree;
  final bool? dw_credit;
  final bool? dw_cash;
  final bool? laybuy;
  final bool? online_eftpos;

  AvailablePaymentMethods({
    this.windcave,
    this.afterpay,
    this.zip,
    this.paypal,
    this.braintree,
    this.dw_credit,
    this.dw_cash,
    this.laybuy,
    this.online_eftpos,
  });

  factory AvailablePaymentMethods.fromJson(Map<String, dynamic> json) =>
      _$AvailablePaymentMethodsFromJson(json);

  Map<String, dynamic> toJson() => _$AvailablePaymentMethodsToJson(this);
}

@JsonSerializable()
class PromoCode {
  final String? code;
  final bool? is_valid;
  final bool? is_used;
  final bool? is_expired;
  final double? discount;
  final double? discount_to_use;
  final bool? dw_only;
  final bool? dwclearance_only;
  final bool? instore_only;

  PromoCode({
    this.code,
    this.is_valid,
    this.is_used,
    this.is_expired,
    this.discount,
    this.discount_to_use,
    this.dw_only,
    this.dwclearance_only,
    this.instore_only,
  });

  factory PromoCode.fromJson(Map<String, dynamic> json) =>
      _$PromoCodeFromJson(json);

  Map<String, dynamic> toJson() => _$PromoCodeToJson(this);
}

// {
//     "show_afterpay": true,
//     "delivery_options": [
//         {
//             "code": "standard_shipping",
//             "name": "Tracked Shipping: Arranged by Seller",
//             "price": "Included"
//         }
//     ],
//     "pricing": {
//         "currency": "NZD",
//         "listing_price": 300,
//         "shipping_fee": 0,
//         "rural_fee": 0,
//         "dw_cash_amount": {
//             "currency": "NZD",
//             "amount": 0,
//             "amount_to_use": 0
//         },
//         "dw_credit_amount": {
//             "currency": "NZD",
//             "amount": 0,
//             "amount_to_use": 0
//         },
//         "gift_card": {
//             "code": null,
//             "available_amount": 0,
//             "amount_to_use": 0,
//             "can_be_redeemed": false,
//             "error_message": null
//         },
//         "total_to_pay": 300
//     },
//     "available_payment_methods": {
//         "windcave": true,
//         "afterpay": true,
//         "zip": true,
//         "paypal": false,
//         "braintree": false,
//         "dw_credit": true,
//         "dw_cash": true,
//         "laybuy": true,
//         "online_eftpos": true
//     },
//     "promo_code": {
//         "code": null,
//         "is_valid": false,
//         "is_used": false,
//         "is_expired": false,
//         "discount": 0,
//         "discount_to_use": 0,
//         "dw_only": false,
//         "dwclearance_only": false,
//         "instore_only": false
//     }
// }