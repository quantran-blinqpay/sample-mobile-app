import 'package:qwid/src/features/home/data/remote/dtos/brands_by_category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'complete_purchase_response.g.dart';

@JsonSerializable()
class CompletePurchaseResponse {
  final OrderData? data;

  CompletePurchaseResponse({this.data});

  factory CompletePurchaseResponse.fromJson(Map<String, dynamic> json) =>
      _$CompletePurchaseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CompletePurchaseResponseToJson(this);
}

@JsonSerializable()
class OrderData {
  final int? id;
  final int? user_id;
  final String? status;
  final String? shipping_code;
  final String? shipping_display;
  final int? user_address_id;
  final String? delivery_instructions;
  final String? order_currency;
  final double? order_total;
  final double? order_total_paid;
  final double? listing_sold_price_include_shipping;
  final double? shipping_fee;
  final double? listing_sold_price_without_shipping;
  final String? buyer_protection_status;
  final DateObject? buyer_protection_expiry;
  final String? sendbird_channel_url;
  final String? notes;
  final DateObject? created_at;
  final String? updated_at;
  final String? type;
  final String? backup_details;
  final String? rental_date;
  final bool? has_been_returned;
  final bool? can_add_bus;
  final bool? has_rental_delivery_bag;
  final bool? has_locker_pickup;
  final int? has_rural_cost;
  final UserWrapper? User;
  final AddressWrapper? DeliveryAddress;
  final AddressWrapper? BuyersDisplayDeliveryAddress;
  final OrderListingsWrapper? OrderListings;
  final PaymentTransactionsWrapper? PaymentTransactions;
  final OrderItemsWrapper? OrderItems;

  OrderData({
    this.id,
    this.user_id,
    this.status,
    this.shipping_code,
    this.shipping_display,
    this.user_address_id,
    this.delivery_instructions,
    this.order_currency,
    this.order_total,
    this.order_total_paid,
    this.listing_sold_price_include_shipping,
    this.shipping_fee,
    this.listing_sold_price_without_shipping,
    this.buyer_protection_status,
    this.buyer_protection_expiry,
    this.sendbird_channel_url,
    this.notes,
    this.created_at,
    this.updated_at,
    this.type,
    this.backup_details,
    this.rental_date,
    this.has_been_returned,
    this.can_add_bus,
    this.has_rental_delivery_bag,
    this.has_locker_pickup,
    this.has_rural_cost,
    this.User,
    this.DeliveryAddress,
    this.BuyersDisplayDeliveryAddress,
    this.OrderListings,
    this.PaymentTransactions,
    this.OrderItems,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) =>
      _$OrderDataFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDataToJson(this);
}

@JsonSerializable()
class DateObject {
  final String? date;

  DateObject({this.date});

  factory DateObject.fromJson(Map<String, dynamic> json) =>
      _$DateObjectFromJson(json);

  Map<String, dynamic> toJson() => _$DateObjectToJson(this);
}

@JsonSerializable()
class UserWrapper {
  final UserData? data;

  UserWrapper({this.data});

  factory UserWrapper.fromJson(Map<String, dynamic> json) =>
      _$UserWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$UserWrapperToJson(this);
}

@JsonSerializable()
class UserData {
  final int? id;
  final String? first_name;
  final String? last_name;
  final String? display_name;
  final String? username;
  final String? email;
  final String? country;
  final String? profile_picture;
  final String? display_profile_picture;
  final int? is_safe_seller;
  final int? is_online;
  final int? following_count;
  final int? followers_count;
  final int? brands_count;
  final int? listing_count;
  final int? feedback_positive_count;
  final int? feedback_neutral_count;
  final int? feedback_negative_count;
  final int? feedback_percentage;
  final bool? can_send_messages;
  final bool? can_make_offers;
  final bool? is_holiday_mode;
  final String? start_holiday_date;
  final String? end_holiday_date;
  final bool? can_make_bulk_upload;
  final bool? can_make_bank_transfers;
  final String? feedback;
  final bool? is_following;
  final String? cover_photo;
  final bool? can_spotlight;
  final bool? is_spotlight;
  final String? spotlight_expired_at;
  final int? spotlight_minimum_require_listing;
  final String? spotlight_price;
  final int? number_listings_available;
  final bool? is_dw_store;

  UserData({
    this.id,
    this.first_name,
    this.last_name,
    this.display_name,
    this.username,
    this.email,
    this.country,
    this.profile_picture,
    this.display_profile_picture,
    this.is_safe_seller,
    this.is_online,
    this.following_count,
    this.followers_count,
    this.brands_count,
    this.listing_count,
    this.feedback_positive_count,
    this.feedback_neutral_count,
    this.feedback_negative_count,
    this.feedback_percentage,
    this.can_send_messages,
    this.can_make_offers,
    this.is_holiday_mode,
    this.start_holiday_date,
    this.end_holiday_date,
    this.can_make_bulk_upload,
    this.can_make_bank_transfers,
    this.feedback,
    this.is_following,
    this.cover_photo,
    this.can_spotlight,
    this.is_spotlight,
    this.spotlight_expired_at,
    this.spotlight_minimum_require_listing,
    this.spotlight_price,
    this.number_listings_available,
    this.is_dw_store,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}

@JsonSerializable()
class AddressWrapper {
  final AddressDataRaw? data;

  AddressWrapper({this.data});

  factory AddressWrapper.fromJson(Map<String, dynamic> json) =>
      _$AddressWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$AddressWrapperToJson(this);
}

@JsonSerializable()
class AddressDataRaw {
  final int? id;
  final int? user_id;
  final int? address_id;
  final String? deliver_to;
  final String? company;
  final String? street;
  final String? suburb;
  final String? city;
  final String? postcode;
  final String? country;
  final bool? default_;
  final bool? allow_pickups;
  final bool? is_rural_delivery;
  final double? longitude;
  final double? latitude;
  final String? created_at;

  AddressDataRaw({
    this.id,
    this.user_id,
    this.address_id,
    this.deliver_to,
    this.company,
    this.street,
    this.suburb,
    this.city,
    this.postcode,
    this.country,
    this.default_,
    this.allow_pickups,
    this.is_rural_delivery,
    this.longitude,
    this.latitude,
    this.created_at,
  });

  factory AddressDataRaw.fromJson(Map<String, dynamic> json) =>
      _$AddressDataRawFromJson(json);

  Map<String, dynamic> toJson() => _$AddressDataRawToJson(this);
}

@JsonSerializable()
class OrderListingsWrapper {
  final List<OrderListing>? data;

  OrderListingsWrapper({this.data});

  factory OrderListingsWrapper.fromJson(Map<String, dynamic> json) =>
      _$OrderListingsWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$OrderListingsWrapperToJson(this);
}

@JsonSerializable()
class OrderListing {
  final int? id;
  final int? order_id;
  final int? listing_id;
  final String? listing_image;
  final String? listing_size_fit_text;
  final bool? is_primary;
  final String? description;
  final String? type;
  final double? listing_price;
  final double? shipping_price;
  final int? purchased_size_id;
  final String? created_at;
  final String? updated_at;

  OrderListing({
    this.id,
    this.order_id,
    this.listing_id,
    this.listing_image,
    this.listing_size_fit_text,
    this.is_primary,
    this.description,
    this.type,
    this.listing_price,
    this.shipping_price,
    this.purchased_size_id,
    this.created_at,
    this.updated_at,
  });

  factory OrderListing.fromJson(Map<String, dynamic> json) =>
      _$OrderListingFromJson(json);

  Map<String, dynamic> toJson() => _$OrderListingToJson(this);
}

@JsonSerializable()
class PaymentTransactionsWrapper {
  final List<PaymentTransaction>? data;

  PaymentTransactionsWrapper({this.data});

  factory PaymentTransactionsWrapper.fromJson(Map<String, dynamic> json) =>
      _$PaymentTransactionsWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentTransactionsWrapperToJson(this);
}

@JsonSerializable()
class PaymentTransaction {
  final int? id;
  final int? user_id;
  final int? order_id;
  final int? display_order_id;
  final String? braintree_transaction_id;
  final String? laybuy_order_id;
  final String? px_transaction_id;
  final String? credit_amount;
  final String? debit_amount;
  final double? balance;
  final String? type;
  final String? display_type;
  final String? description;
  final String? status;
  final DateObject? created_at;
  final DateObject? updated_at;
  final String? deleted_at;

  PaymentTransaction({
    this.id,
    this.user_id,
    this.order_id,
    this.display_order_id,
    this.braintree_transaction_id,
    this.laybuy_order_id,
    this.px_transaction_id,
    this.credit_amount,
    this.debit_amount,
    this.balance,
    this.type,
    this.display_type,
    this.description,
    this.status,
    this.created_at,
    this.updated_at,
    this.deleted_at,
  });

  factory PaymentTransaction.fromJson(Map<String, dynamic> json) =>
      _$PaymentTransactionFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentTransactionToJson(this);
}

@JsonSerializable()
class OrderItemsWrapper {
  final List<dynamic>? data;

  OrderItemsWrapper({this.data});

  factory OrderItemsWrapper.fromJson(Map<String, dynamic> json) =>
      _$OrderItemsWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemsWrapperToJson(this);
}

// {
//   "data": {
//     "id": 2506148,
//     "user_id": 215161,
//     "status": "success",
//     "shipping_code": "standard_shipping",
//     "shipping_display": "Tracked Shipping: Arranged by seller",
//     "user_address_id": 320147,
//     "delivery_instructions": "NOTHING",
//     "order_currency": "NZD",
//     "order_total": 300,
//     "order_total_paid": 300,
//     "listing_sold_price_include_shipping": 300,
//     "shipping_fee": 0,
//     "listing_sold_price_without_shipping": 300,
//     "buyer_protection_status": "active",
//     "buyer_protection_expiry": {
//       "date": "2025-08-24 15:08:07.000"
//     },
//     "sendbird_channel_url": null,
//     "notes": null,
//     "created_at": {
//       "date": "2025-08-14 15:07:59.000"
//     },
//     "updated_at": "2025-08-14 15:08:07",
//     "type": "purchase",
//     "backup_details": null,
//     "rental_date": null,
//     "has_been_returned": true,
//     "can_add_bus": false,
//     "has_rental_delivery_bag": false,
//     "has_locker_pickup": false,
//     "has_rural_cost": 0,
//     "User": {
//       "data": {
//         "id": 215161,
//         "first_name": "Tin",
//         "last_name": "nz001",
//         "display_name": "Tin N",
//         "username": "tinnz0069",
//         "email": "",
//         "country": "New Zealand",
//         "profile_picture": "https://designerwardrobe.co.nz/profile-pictures/default/cat_1.png",
//         "display_profile_picture": "https://designerwardrobe.co.nz/profile-pictures/default/cat_1.png",
//         "is_safe_seller": 0,
//         "is_online": 0,
//         "following_count": 0,
//         "followers_count": 0,
//         "brands_count": 0,
//         "listing_count": 0,
//         "feedback_positive_count": 0,
//         "feedback_neutral_count": 0,
//         "feedback_negative_count": 0,
//         "feedback_percentage": -1,
//         "can_send_messages": true,
//         "can_make_offers": true,
//         "is_holiday_mode": false,
//         "start_holiday_date": null,
//         "end_holiday_date": null,
//         "can_make_bulk_upload": false,
//         "can_make_bank_transfers": true,
//         "feedback": "No feedback received",
//         "is_following": false,
//         "cover_photo": "https://user-cover-photos.designerwardrobe.co.nz/tinnz001_2020-10-29-005647.jpg",
//         "can_spotlight": false,
//         "is_spotlight": false,
//         "spotlight_expired_at": "0000-00-00 00:00:00",
//         "spotlight_minimum_require_listing": 4,
//         "spotlight_price": "12.95",
//         "number_listings_available": 0,
//         "is_dw_store": false
//       }
//     },
//     "DeliveryAddress": {
//       "data": {
//         "id": 320147,
//         "user_id": 215161,
//         "address_id": 1295947,
//         "deliver_to": "Tin Huynh",
//         "company": "ICTS Custom Software",
//         "street": "123 Abbotts Way",
//         "suburb": "Remuera",
//         "city": "Auckland",
//         "postcode": "1050",
//         "country": "New Zealand",
//         "default": false,
//         "allow_pickups": false,
//         "is_rural_delivery": false,
//         "longitude": null,
//         "latitude": null,
//         "created_at": "2025-08-14 15:07:18"
//       }
//     },
//     "BuyersDisplayDeliveryAddress": {
//       "data": {
//         "id": 320147,
//         "user_id": 215161,
//         "address_id": 1295947,
//         "deliver_to": "Tin Huynh",
//         "company": "ICTS Custom Software",
//         "street": "123 Abbotts Way",
//         "suburb": "Remuera",
//         "city": "Auckland",
//         "postcode": "1050",
//         "country": "New Zealand",
//         "default": false,
//         "allow_pickups": false,
//         "is_rural_delivery": false,
//         "longitude": null,
//         "latitude": null,
//         "created_at": "2025-08-14 15:07:18"
//       }
//     },
//     "OrderListings": {
//       "data": [
//         {
//           "id": 1601013,
//           "order_id": 2506148,
//           "listing_id": 3396348,
//           "listing_image": "https://dwcdn.nz/dw-images/preloved-1/3396348/eb13762c06510ce5a7186af0a3d66234.jpg/",
//           "listing_size_fit_text": null,
//           "is_primary": true,
//           "description": "Purchase listing: Gucci card case",
//           "type": "purchase",
//           "listing_price": 300,
//           "shipping_price": 0,
//           "purchased_size_id": null,
//           "created_at": "2025-08-14 15:07:59",
//           "updated_at": "2025-08-14 15:07:59"
//         }
//       ]
//     },
//     "PaymentTransactions": {
//       "data": [
//         {
//           "id": 3881438,
//           "user_id": 215161,
//           "order_id": 2506148,
//           "display_order_id": 2506148,
//           "braintree_transaction_id": "000000040183f9f7",
//           "laybuy_order_id": null,
//           "px_transaction_id": null,
//           "credit_amount": "0.00",
//           "debit_amount": "300.00",
//           "balance": -300,
//           "type": "credit_card",
//           "display_type": "Credit Card",
//           "description": " Purchase listing: Gucci card case",
//           "status": "success",
//           "created_at": {
//             "date": "2025-08-14 15:08:00.000"
//           },
//           "updated_at": {
//             "date": "2025-08-14 15:08:07.000"
//           },
//           "deleted_at": null
//         }
//       ]
//     },
//     "OrderItems": {
//       "data": []
//     }
//   }
// }