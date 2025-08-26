part of 'payment_address_cubit.dart';

class PaymentAddressState extends Equatable {
  const PaymentAddressState({
    this.country,
    this.firstName,
    this.lastName,
    this.company,
    this.address,
    this.phone,
    this.localCountries,
    this.suggestions,
    this.selectedAddress,
    this.lookupAddressStatus = ProgressStatus.initial,
    this.createAddressStatus = ProgressStatus.initial,
    this.addressResponse,
  });

  final LocalCountry? country;
  final String? firstName;
  final String? lastName;
  final String? company;
  final String? address;
  final AddressItem? selectedAddress;
  final String? phone;
  final List<LocalCountry>? localCountries;
  final List<AddressItem>? suggestions;
  final ProgressStatus lookupAddressStatus;
  final ProgressStatus createAddressStatus;
  final CreateAddressResponse? addressResponse;

  @override
  List<Object?> get props =>[
    country,
    firstName,
    lastName,
    company,
    selectedAddress,
    phone,
    localCountries,
    suggestions,
    address,
    lookupAddressStatus,
    createAddressStatus,
    addressResponse,
  ];

  PaymentAddressState copyWith({
    LocalCountry? country,
    String? firstName,
    String? lastName,
    String? company,
    String? address,
    AddressItem? selectedAddress,
    String? phone,
    List<LocalCountry>? localCountries,
    List<AddressItem>? suggestions,
    ProgressStatus? lookupAddressStatus,
    ProgressStatus? createAddressStatus,
    CreateAddressResponse? addressResponse,
  }) {
    return PaymentAddressState(
      country: country ?? this.country,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      company: company ?? this.company,
      address: address ?? this.address,
      selectedAddress: selectedAddress ?? this.selectedAddress,
      phone: phone ?? this.phone,
      localCountries: localCountries ?? this.localCountries,
      suggestions: suggestions ?? this.suggestions,
      lookupAddressStatus: lookupAddressStatus ?? this.lookupAddressStatus,
      createAddressStatus: createAddressStatus ?? this.createAddressStatus,
      addressResponse: addressResponse ?? this.addressResponse,
    );
  }
}
