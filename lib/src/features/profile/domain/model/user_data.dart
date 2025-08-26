import 'package:json_annotation/json_annotation.dart';
part 'user_data.g.dart';
@JsonSerializable()
class UserDataResponse {
  @JsonKey()
  UserData? data;

  UserDataResponse({
    this.data,
  });

  factory UserDataResponse.fromJson(Map<String, dynamic> json) => _$UserDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataResponseToJson(this);
}

@JsonSerializable()
class UserData {
  @JsonKey()
  int? id;
  @JsonKey(name: "first_name")
  String? firstName;
  @JsonKey(name: "last_name")
  String? lastName;
  @JsonKey(name: "display_name")
  String? displayName;
  @JsonKey()
  String? username;
  @JsonKey()
  String? email;
  @JsonKey(name: 'mobile_phone')
  String? mobilePhone;
  @JsonKey()
  String? country;
  @JsonKey(name: 'country_code')
  String? countryCode;
  @JsonKey()
  String? gender;
  @JsonKey(name: 'profile_picture')
  String? profilePicture;
  @JsonKey(name: 'display_profile_picture')
  String? displayProfilePicture;
  @JsonKey(name: 'is_safe_seller')
  int? isSafeSeller;
  @JsonKey(name: 'is_online')
  int? isOnline;
  @JsonKey()
  String? balance;
  @JsonKey(name: 'sendbird_access_token')
  String? sendbirdAccessToken;
  @JsonKey(name: 'can_send_messages')
  bool? canSendMessages;
  @JsonKey(name: 'can_make_offers')
  bool? canMakeOffers;
  @JsonKey()
  bool? isAdmin;
  @JsonKey()
  int? isActive;
  @JsonKey(name: 'recombee_session_id')
  String? recombeeSessionId;
  @JsonKey(name: 'start_holiday_date')
  String? startHolidayDate;
  @JsonKey(name: 'end_holiday_date')
  String? endHolidayDate;
  @JsonKey(name: 'can_make_bulk_upload')
  bool? canMakeBulkUpload;
  @JsonKey(name: 'can_make_bank_transfers')
  bool? canMakeBankTransfers;
  @JsonKey()
  String? feedback;
  @JsonKey(name: 'is_following')
  bool? isFollowing;
  @JsonKey(name: 'is_dw_store')
  bool? isDwStore;
  @JsonKey(name: 'is_top_seller')
  bool? isTopSeller;
  @JsonKey(name: 'is_force_braintree')
  bool? isForceBraintree;
  @JsonKey(name: 'verified_email')
  bool? verifiedEmail;
  @JsonKey(name: 'verified_facebook')
  bool? verifiedFacebook;
  @JsonKey(name: 'Counts')
  CountDataCollection? countData;

  UserData(
      this.id,
      this.firstName,
      this.lastName,
      this.displayName,
      this.username,
      this.email,
      this.mobilePhone,
      this.country,
      this.countryCode,
      this.gender,
      this.profilePicture,
      this.displayProfilePicture,
      this.isSafeSeller,
      this.isOnline,
      this.balance,
      this.sendbirdAccessToken,
      this.canSendMessages,
      this.canMakeOffers,
      this.isAdmin,
      this.isActive,
      this.recombeeSessionId,
      this.startHolidayDate,
      this.endHolidayDate,
      this.canMakeBulkUpload,
      this.canMakeBankTransfers,
      this.feedback,
      this.isFollowing,
      this.isDwStore,
      this.isTopSeller,
      this.isForceBraintree,
      this.verifiedEmail,
      this.verifiedFacebook,
      this.countData);

  factory UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}

@JsonSerializable()
class CountDataCollection {
  @JsonKey()
  CountData? data;

  CountDataCollection(this.data);

  factory CountDataCollection.fromJson(Map<String, dynamic> json) => _$CountDataCollectionFromJson(json);

  Map<String, dynamic> toJson() => _$CountDataCollectionToJson(this);
}

@JsonSerializable()
class CountData {
  @JsonKey(name: 'following_count')
  int? followingCount;
  @JsonKey(name: 'followers_count')
  int? followersCount;
  @JsonKey(name: 'brands_count')
  int? brandsCount;
  @JsonKey(name: 'listing_count')
  int? listingCount;
  @JsonKey(name: 'consignment_listing_count')
  int? consignmentListingCount;
  @JsonKey(name: 'feedback_positive_count')
  int? feedbackPositiveCount;
  @JsonKey(name: 'feedback_neutral_count')
  int? feedbackNeutralCount;
  @JsonKey(name: 'feedback_negative_count')
  int? feedbackNegativeCount;

  CountData(
      this.followingCount,
      this.followersCount,
      this.brandsCount,
      this.listingCount,
      this.consignmentListingCount,
      this.feedbackPositiveCount,
      this.feedbackNeutralCount,
      this.feedbackNegativeCount);

  factory CountData.fromJson(Map<String, dynamic> json) => _$CountDataFromJson(json);

  Map<String, dynamic> toJson() => _$CountDataToJson(this);
}
