part of 'payment_cubit.dart';

class PaymentState extends Equatable {

  final List<LocalCountry>? localCountries;
  final LocalCountry? country;
  final String? city;
  final String? phoneCode;
  final String? phone;

  final List<AddressData>? addresses;
  final AddressData? selectedAddress;

  final ProgressStatus getMyAddressStatus;
  final int? listingId;

  final ProgressStatus getWindcaveCardsStatus;
  final List<WindcaveCardData>? cards;
  final WindcaveCardData? selectedCards;

  final ProgressStatus? getPaymentInfoStatus;
  final PaymentInfoResponse? paymentInfo;
  final ProgressStatus? getPaymentInfoInSilenceStatus;

  final ListingDetailResponseData? productInfo;
  final CurrencyRateResponse? dataCurrencyRate;
  final ProgressStatus fetchCurrencyStatus;

  final String? promoCode;
  final String? giftCardCode;
  final bool useDWCash;

  final ProgressStatus completePurchaseStatus;
  final profile.UserData? userProfile;
  final ProgressStatus? fetchUserProfileStatus;

  final ProgressStatus? submitCreditCardStatus;
  final ProgressStatus? addCreditCardsStatus;
  final ProgressStatus? addAddressStatus;
  final String? errorMessage;

  @override
  List<Object?> get props => [
    localCountries,
    country,
    city,
    phoneCode,
    phone,
    addresses,
    selectedAddress,
    listingId,
    getWindcaveCardsStatus,
    cards,
    selectedCards,
    getPaymentInfoStatus,
    paymentInfo,
    productInfo,
    dataCurrencyRate,
    fetchCurrencyStatus,
    promoCode,
    completePurchaseStatus,
    userProfile,
    fetchUserProfileStatus,
    getPaymentInfoInSilenceStatus,
    promoCode,
    giftCardCode,
    useDWCash,
    addCreditCardsStatus,
    errorMessage,
    addAddressStatus
  ];

  const PaymentState(
      {this.localCountries,
      this.country,
      this.city,
      this.phoneCode,
      this.phone,
      this.addresses,
      this.selectedAddress,
      this.getMyAddressStatus = ProgressStatus.initial,
      this.listingId,
      this.getWindcaveCardsStatus = ProgressStatus.initial,
      this.cards,
      this.selectedCards,
      this.getPaymentInfoStatus,
      this.paymentInfo,
      this.productInfo,
      this.dataCurrencyRate,
      this.fetchCurrencyStatus = ProgressStatus.initial,
      this.completePurchaseStatus = ProgressStatus.initial,
      this.userProfile,
      this.fetchUserProfileStatus = ProgressStatus.initial,
      this.promoCode,
      this.giftCardCode,
      this.useDWCash = false,
      this.getPaymentInfoInSilenceStatus = ProgressStatus.initial,
      this.submitCreditCardStatus = ProgressStatus.initial,
      this.addCreditCardsStatus = ProgressStatus.initial,
      this.errorMessage,
      this.addAddressStatus,
  });

  PaymentState copyWith({
    List<LocalCountry>? localCountries,
    LocalCountry? country,
    String? city,
    String? phoneCode,
    String? phone,
    List<AddressData>? addresses,
    AddressData? selectedAddress,
    ProgressStatus? getMyAddressStatus,
    int? listingId,
    ProgressStatus? getWindcaveCardsStatus,
    List<WindcaveCardData>? cards,
    WindcaveCardData? selectedCards,
    ProgressStatus? getPaymentInfoStatus,
    PaymentInfoResponse? paymentInfo,
    ProgressStatus? getPaymentInfoInSilenceStatus,
    ListingDetailResponseData? productInfo,
    CurrencyRateResponse? dataCurrencyRate,
    ProgressStatus? fetchCurrencyStatus,
    String? promoCode,
    String? giftCardCode,
    bool? useDWCash,
    ProgressStatus? completePurchaseStatus,
    profile.UserData? userProfile,
    ProgressStatus? fetchUserProfileStatus,
    ProgressStatus? submitCreditCardStatus,
    ProgressStatus? addCreditCardsStatus,
    ProgressStatus? addAddressStatus,
    String? errorMessage,
  }) {
    return PaymentState(
      localCountries: localCountries ?? this.localCountries,
      country: country ?? this.country,
      city: city ?? this.city,
      phoneCode: phoneCode ?? this.phoneCode,
      phone: phone ?? this.phone,
      addresses: addresses ?? this.addresses,
      selectedAddress: selectedAddress ?? this.selectedAddress,
      getMyAddressStatus: getMyAddressStatus ?? this.getMyAddressStatus,
      listingId: listingId ?? this.listingId,
      getWindcaveCardsStatus:
          getWindcaveCardsStatus ?? this.getWindcaveCardsStatus,
      cards: cards ?? this.cards,
      selectedCards: selectedCards ?? this.selectedCards,
      getPaymentInfoStatus: getPaymentInfoStatus ?? this.getPaymentInfoStatus,
      paymentInfo: paymentInfo ?? this.paymentInfo,
      getPaymentInfoInSilenceStatus:
          getPaymentInfoInSilenceStatus ?? this.getPaymentInfoInSilenceStatus,
      productInfo: productInfo ?? this.productInfo,
      dataCurrencyRate: dataCurrencyRate ?? this.dataCurrencyRate,
      fetchCurrencyStatus: fetchCurrencyStatus ?? this.fetchCurrencyStatus,
      promoCode: promoCode ?? this.promoCode,
      giftCardCode: giftCardCode ?? this.giftCardCode,
      useDWCash: useDWCash ?? this.useDWCash,
      completePurchaseStatus:
          completePurchaseStatus ?? this.completePurchaseStatus,
      userProfile: userProfile ?? this.userProfile,
      fetchUserProfileStatus:
          fetchUserProfileStatus ?? this.fetchUserProfileStatus,
      submitCreditCardStatus:
          submitCreditCardStatus ?? this.submitCreditCardStatus,
      addCreditCardsStatus: addCreditCardsStatus ?? this.addCreditCardsStatus,
      addAddressStatus: addAddressStatus ?? this.addAddressStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  bool get isWindcave => paymentInfo?.availablePaymentMethods?.windcave ?? false;
  bool get isBraintree => paymentInfo?.availablePaymentMethods?.braintree ?? false;
}
