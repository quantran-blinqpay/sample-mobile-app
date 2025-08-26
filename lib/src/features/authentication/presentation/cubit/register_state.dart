part of 'register_cubit.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.firstName,
    this.lastName,
    this.email,
    this.username,
    this.password,
    this.gender,
    this.month,
    this.year,
    this.country,
    this.referralCode,
    this.referredFrom,
    this.city,
    this.term,
    this.emailValidationStatus = ProgressStatus.initial,
    this.usernameValidationStatus = ProgressStatus.initial,
    this.userValidationStatus = ProgressStatus.initial,
    this.sendingCodeStatus = ProgressStatus.initial,
    this.phoneValidationStatus = ProgressStatus.initial,
    this.isEmailValid,
    this.isUsernameValid,
    this.localCountries,
    this.errorMessage,
    this.phone,
    this.isPhoneValid,
    this.phoneCode,
    this.otp,
    this.codeValidationStatus,
    this.isOTPValid,
    this.batchUpdateFrequencyStatus = ProgressStatus.initial,
    this.sizeSynchronizationStatus = ProgressStatus.initial,
    this.ids,
    this.frequency,
    this.fetchSiteSettingStatus,
    this.localAuBrands,
    this.localNZBrands,
    this.fetchCategoriesStatus,
    this.usualSizes,
    this.waistSizes,
    this.shoeSizes,
    this.selectedUsualSizes,
    this.selectedWaistSizes,
    this.selectedShoeSizes,
    this.updateSizesStatus = ProgressStatus.initial,
    this.updateIdxStatus = ProgressStatus.initial,
    this.originalIds,
    this.initIdsStatus = ProgressStatus.initial,
  });

  final String? firstName;
  final String? lastName;
  final String? email;
  final String? username;
  final String? password;
  final String? gender;
  final int? month;
  final int? year;
  final LocalCountry? country;
  final String? referralCode;
  final String? referredFrom;
  final String? city;
  final int? term;

  final ProgressStatus? emailValidationStatus;
  final bool? isEmailValid;
  final ProgressStatus? usernameValidationStatus;
  final bool? isUsernameValid;

  final ProgressStatus? userValidationStatus;
  final String? errorMessage;

  final ProgressStatus? sendingCodeStatus;
  final String? phone;
  final String? phoneCode;
  final ProgressStatus? phoneValidationStatus;
  final bool? isPhoneValid;

  final String? otp;
  final ProgressStatus? codeValidationStatus;
  final bool? isOTPValid;

  final ProgressStatus? batchUpdateFrequencyStatus;
  final List<BrandTag>? ids;
  final List<BrandTag>? originalIds;
  final String? frequency;

  final ProgressStatus? sizeSynchronizationStatus;
  final ProgressStatus? fetchSiteSettingStatus;

  final List<LocalCountry>? localCountries;
  final List<BrandTag>? localAuBrands;
  final List<BrandTag>? localNZBrands;

  final ProgressStatus? fetchCategoriesStatus;
  final List<GenericSize>? usualSizes;
  final List<GenericSize>? waistSizes;
  final List<GenericSize>? shoeSizes;
  /// seleted code
  final List<GenericSize>? selectedUsualSizes;
  final List<GenericSize>? selectedWaistSizes;
  final List<GenericSize>? selectedShoeSizes;

  final ProgressStatus? updateSizesStatus;
  final ProgressStatus? updateIdxStatus;
  final ProgressStatus? initIdsStatus;

  @override
  List<Object?> get props => [
    firstName,
    lastName,
    email,
    username,
    password,
    gender,
    month,
    year,
    country,
    referralCode,
    referredFrom,
    city,
    term,
    emailValidationStatus,
    isEmailValid,
    usernameValidationStatus,
    isUsernameValid,
    localCountries,
    userValidationStatus,
    errorMessage,
    sendingCodeStatus,
    phone,
    isPhoneValid,
    phoneCode,
    phoneValidationStatus,
    otp,
    codeValidationStatus,
    isOTPValid,
    batchUpdateFrequencyStatus,
    sizeSynchronizationStatus,
    ids,
    frequency,
    fetchSiteSettingStatus,
    localNZBrands,
    localAuBrands,
    fetchCategoriesStatus,
    usualSizes,
    waistSizes,
    shoeSizes,
    selectedUsualSizes,
    selectedWaistSizes,
    selectedShoeSizes,
    updateSizesStatus,
    updateIdxStatus,
    originalIds,
    initIdsStatus,
  ];

  RegisterState copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? username,
    String? password,
    String? gender,
    int? month,
    int? year,
    LocalCountry? country,
    String? referralCode,
    String? referredFrom,
    String? city,
    int? term,
    ProgressStatus? emailValidationStatus,
    bool? isEmailValid,
    ProgressStatus? usernameValidationStatus,
    bool? isUsernameValid,
    ProgressStatus? userValidationStatus,
    String? errorMessage,
    ProgressStatus? sendingCodeStatus,
    String? phone,
    String? phoneCode,
    ProgressStatus? phoneValidationStatus,
    bool? isPhoneValid,
    String? otp,
    ProgressStatus? codeValidationStatus,
    bool? isOTPValid,
    ProgressStatus? batchUpdateFrequencyStatus,
    List<BrandTag>? ids,
    String? frequency,
    ProgressStatus? sizeSynchronizationStatus,
    ProgressStatus? fetchSiteSettingStatus,
    List<LocalCountry>? localCountries,
    List<BrandTag>? localAuBrands,
    List<BrandTag>? localNZBrands,
    ProgressStatus? fetchCategoriesStatus,
    List<GenericSize>? usualSizes,
    List<GenericSize>? waistSizes,
    List<GenericSize>? shoeSizes,
    List<GenericSize>? selectedUsualSizes,
    List<GenericSize>? selectedWaistSizes,
    List<GenericSize>? selectedShoeSizes,
    ProgressStatus? updateSizesStatus,
    ProgressStatus? updateIdxStatus,
    List<BrandTag>? originalIds,
    ProgressStatus? initIdsStatus,
  }) {
    return RegisterState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      username: username ?? this.username,
      password: password ?? this.password,
      gender: gender ?? this.gender,
      month: month ?? this.month,
      year: year ?? this.year,
      country: country ?? this.country,
      referralCode: referralCode ?? this.referralCode,
      referredFrom: referredFrom ?? this.referredFrom,
      city: city ?? this.city,
      term: term ?? this.term,
      emailValidationStatus:
          emailValidationStatus ?? this.emailValidationStatus,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      usernameValidationStatus:
          usernameValidationStatus ?? this.usernameValidationStatus,
      isUsernameValid: isUsernameValid ?? this.isUsernameValid,
      userValidationStatus: userValidationStatus ?? this.userValidationStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      sendingCodeStatus: sendingCodeStatus ?? this.sendingCodeStatus,
      phone: phone ?? this.phone,
      phoneCode: phoneCode ?? this.phoneCode,
      phoneValidationStatus:
          phoneValidationStatus ?? this.phoneValidationStatus,
      isPhoneValid: isPhoneValid ?? this.isPhoneValid,
      otp: otp ?? this.otp,
      codeValidationStatus: codeValidationStatus ?? this.codeValidationStatus,
      isOTPValid: isOTPValid ?? this.isOTPValid,
      batchUpdateFrequencyStatus:
          batchUpdateFrequencyStatus ?? this.batchUpdateFrequencyStatus,
      ids: ids ?? this.ids,
      frequency: frequency ?? this.frequency,
      sizeSynchronizationStatus:
          sizeSynchronizationStatus ?? this.sizeSynchronizationStatus,
      fetchSiteSettingStatus:
          fetchSiteSettingStatus ?? this.fetchSiteSettingStatus,
      localCountries: localCountries ?? this.localCountries,
      localAuBrands: localAuBrands ?? this.localAuBrands,
      localNZBrands: localNZBrands ?? this.localNZBrands,
      fetchCategoriesStatus:
          fetchCategoriesStatus ?? this.fetchCategoriesStatus,
      usualSizes: usualSizes ?? this.usualSizes,
      waistSizes: waistSizes ?? this.waistSizes,
      shoeSizes: shoeSizes ?? this.shoeSizes,
      selectedUsualSizes: selectedUsualSizes ?? this.selectedUsualSizes,
      selectedWaistSizes: selectedWaistSizes ?? this.selectedWaistSizes,
      selectedShoeSizes: selectedShoeSizes ?? this.selectedShoeSizes,
      updateSizesStatus: updateSizesStatus ?? this.updateSizesStatus,
      updateIdxStatus: updateIdxStatus ?? this.updateIdxStatus,
      originalIds: originalIds ?? this.originalIds,
      initIdsStatus: initIdsStatus ?? this.initIdsStatus,
    );
  }
}
