import 'dart:async';
import 'dart:convert';

import 'package:qwid/src/core/constants/app_constants.dart';
import 'package:qwid/src/core/failures/failure.dart';
import 'package:qwid/src/core/network/response/enum/progress_status.dart';
import 'package:qwid/src/features/authentication/data/remote/dtos/register/category/category_size.dart';
import 'package:qwid/src/features/authentication/data/remote/dtos/register/category/generic_size.dart';
import 'package:qwid/src/features/authentication/data/remote/dtos/register/country/local_country.dart';
import 'package:qwid/src/features/authentication/data/remote/dtos/register/parameter/batch_update_frequency_parameter.dart';
import 'package:qwid/src/features/authentication/data/remote/dtos/register/parameter/brand_following_parameter.dart';
import 'package:qwid/src/features/authentication/data/remote/dtos/register/parameter/code_sending_parameter.dart';
import 'package:qwid/src/features/authentication/data/remote/dtos/register/parameter/size_sync_parameter.dart';
import 'package:qwid/src/features/authentication/data/remote/dtos/register/parameter/user_validation_parameter.dart';
import 'package:qwid/src/features/authentication/domain/repositories/register_repository.dart';
import 'package:qwid/src/features/home/domain/repositories/home_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.repository, this.homeRepository) : super(RegisterState());

  final RegisterRepository repository;
  final HomeRepository homeRepository;

  void updateFirstName(String text) {
    emit(state.copyWith(firstName: text));
  }

  void updateLastName(String text) {
    emit(state.copyWith(lastName: text));
  }

  void updateEmail(String text) {
    emit(state.copyWith(email: text));
  }

  void updateUsername(String text) {
    emit(state.copyWith(username: text));
  }

  void updatePassword(String text) {
    emit(state.copyWith(password: text));
  }

  void updateMonth(int number) {
    emit(state.copyWith(month: number));
  }

  void updateYear(int number) {
    emit(state.copyWith(year: number));
  }

  void updateReferralCode(String text) {
    emit(state.copyWith(referralCode: text));
  }

  void updateCountry(LocalCountry country) {
    emit(state.copyWith(country: country, phoneCode: country.phoneCode));
  }

  void updateCity(String city) {
    emit(state.copyWith(city: city));
  }

  void updatePhoneCode(String phoneCode) {
    emit(state.copyWith(phoneCode: phoneCode));
  }

  void updatePhone(String phone) {
    emit(state.copyWith(phone: phone));
  }

  void updateOTP(String otp) {
    emit(state.copyWith(otp: otp));
  }

  void updateFrequency(String frequency) {
    emit(state.copyWith(frequency: frequency));
  }

  void updateIds(List<BrandTag> ids) {
    emit(state.copyWith(updateIdxStatus: ProgressStatus.inProgress));
    emit(state.copyWith(ids: ids));
    emit(state.copyWith(updateIdxStatus: ProgressStatus.success));
  }

  void updateOriginalIds(List<BrandTag> ids) {
    emit(state.copyWith(updateIdxStatus: ProgressStatus.inProgress));
    emit(state.copyWith(originalIds: ids));
    emit(state.copyWith(updateIdxStatus: ProgressStatus.success));
  }

  void initIds(List<BrandTag> ids) {
    emit(state.copyWith(initIdsStatus: ProgressStatus.inProgress));
    emit(state.copyWith(originalIds: ids));
    emit(state.copyWith(ids: []));
    emit(state.copyWith(initIdsStatus: ProgressStatus.success));
  }

  void updateSelectedUsualSizes(List<GenericSize> sizes) {
    emit(state.copyWith(updateSizesStatus: ProgressStatus.inProgress));
    emit(state.copyWith(selectedUsualSizes: sizes));
    emit(state.copyWith(updateSizesStatus: ProgressStatus.success));
  }

  void updateSelectedWaistSizes(List<GenericSize> sizes) {
    emit(state.copyWith(updateSizesStatus: ProgressStatus.inProgress));
    emit(state.copyWith(selectedWaistSizes: sizes));
    emit(state.copyWith(updateSizesStatus: ProgressStatus.success));
  }

  void updateSelectedShoeSizes(List<GenericSize> sizes) {
    emit(state.copyWith(updateSizesStatus: ProgressStatus.inProgress));
    emit(state.copyWith(selectedShoeSizes: sizes));
    emit(state.copyWith(updateSizesStatus: ProgressStatus.success));
  }

  void initSizes() {
    emit(state.copyWith(updateSizesStatus: ProgressStatus.inProgress));
    emit(state.copyWith(selectedUsualSizes: []));
    emit(state.copyWith(selectedWaistSizes: []));
    emit(state.copyWith(selectedShoeSizes: []));
    emit(state.copyWith(updateSizesStatus: ProgressStatus.success));
  }

  Future<void> validatePhone(String email) async {
    emit(state.copyWith(phoneValidationStatus: ProgressStatus.inProgress));
    final phoneRegex = RegExp(AppConstants.phoneRegex);
    final phoneNumber = '${state.phoneCode}${state.phone}';
    if (!phoneRegex.hasMatch(phoneNumber)) {
      emit(state.copyWith(
          isPhoneValid: false, phoneValidationStatus: ProgressStatus.failure));
    } else {
      emit(state.copyWith(
        isPhoneValid: true,
        phoneValidationStatus: ProgressStatus.success,
      ));
    }
  }

  Future<void> validateCode(String code) async {
    emit(state.copyWith(codeValidationStatus: ProgressStatus.inProgress));
    final codeRegex = RegExp(AppConstants.codeRegex);
    if (!codeRegex.hasMatch(code)) {
      emit(state.copyWith(
          isOTPValid: false, codeValidationStatus: ProgressStatus.failure));
    } else {
      emit(state.copyWith(
        isOTPValid: true,
        codeValidationStatus: ProgressStatus.success,
      ));
    }
  }

  Future<void> validateEmail(String email) async {
    emit(state.copyWith(emailValidationStatus: ProgressStatus.inProgress));
    final response = await repository.validateEmail(email: email);
    response.fold((error) {
      emit(state.copyWith(emailValidationStatus: ProgressStatus.failure));
    }, (data) async {
      emit(state.copyWith(
        isEmailValid: data.status == false,
        emailValidationStatus: ProgressStatus.success,
      ));
    });
  }

  Future<void> validateUsername(String username) async {
    emit(state.copyWith(usernameValidationStatus: ProgressStatus.inProgress));
    final response = await repository.validateUserName(username: username);
    response.fold((error) {
      emit(state.copyWith(usernameValidationStatus: ProgressStatus.failure));
    }, (data) async {
      emit(state.copyWith(
        isUsernameValid: data.status == false,
        usernameValidationStatus: ProgressStatus.success,
      ));
    });
  }

  Future<void> validateUser() async {
    debugPrint('quanth: register firstName = ${state.firstName}');
    debugPrint('quanth: register lastName= ${state.lastName}');
    debugPrint('quanth: register email= ${state.email}');
    debugPrint('quanth: register username= ${state.username}');
    debugPrint('quanth: register password= ${state.password}');
    debugPrint('quanth: register gender= ${state.gender}');
    debugPrint('quanth: register month= ${state.month}');
    debugPrint('quanth: register year= ${state.year}');
    debugPrint('quanth: register country= ${state.country?.countryName ?? ''}');
    debugPrint('quanth: register country= ${state.city}');
    debugPrint('quanth: register referralCode= ${state.referralCode}');
    debugPrint('quanth: register referredFrom= ${state.referredFrom}');
    debugPrint('quanth: register city= ${state.city}');
    debugPrint('quanth: register term= ${state.term}');
    emit(state.copyWith(userValidationStatus: ProgressStatus.inProgress));
    final response = await repository.validateUser(
        param: UserValidationParameter(
            firstName: state.firstName,
            lastName: state.lastName,
            email: state.email,
            username: state.username,
            password: state.password,
            gender: state.gender ?? 'female',
            month: state.month,
            year: state.year,
            country: state.country?.countryName,
            city: state.city,
            terms: state.term ?? 1,
            referredFrom: 'https://login-test.designerwardrobe.co.nz/',
            categories: []));
    response.fold((error) {
      emit(state.copyWith(
          userValidationStatus: ProgressStatus.failure,
          errorMessage: (error as DetailFailure).message));
    }, (data) async {
      emit(state.copyWith(userValidationStatus: ProgressStatus.success));
    });
  }

  Future<void> sendCode() async {
    emit(state.copyWith(sendingCodeStatus: ProgressStatus.inProgress));
    final response = await repository.sendCode(
        param: CodeSendingParameter(
      phone: '${state.phoneCode}${state.phone}',
      country: state.country?.countryName,
      taskSlug: 'user_signup',
      secondParam: state.email,
    ));
    response.fold((error) {
      emit(state.copyWith(
          sendingCodeStatus: ProgressStatus.failure,
          errorMessage: (error as DetailFailure).message));
    }, (data) async {
      emit(state.copyWith(sendingCodeStatus: ProgressStatus.success));
    });
  }

  Future<void> batchUpdateFrequency() async {
    emit(state.copyWith(batchUpdateFrequencyStatus: ProgressStatus.inProgress));
    final response = await repository.followBrand(
        param: BrandFollowingParameter(
      brandIds: state.ids?.map((e) => e.id.toString()).toList().join(','),
    ));
    response.fold((error) {
      emit(state.copyWith(
        batchUpdateFrequencyStatus: ProgressStatus.failure,
        errorMessage: (error as DetailFailure).message,
      ));
    }, (data) async {
      if (data.data?.isNotEmpty ?? false) {
        final response = await repository.batchUpdateFrequency(
            param: BatchUpdateFrequencyParameter(
                ids: data.data?.map((e) => e.id!).toList(),
                frequency: state.frequency?.toLowerCase()));
        response.fold((error) {
          emit(state.copyWith(
              batchUpdateFrequencyStatus: ProgressStatus.failure,
              errorMessage: (error as DetailFailure).message));
        }, (data) async {
          emit(state.copyWith(
              batchUpdateFrequencyStatus: ProgressStatus.success));
        });
      } else {
        emit(state.copyWith(
            batchUpdateFrequencyStatus: ProgressStatus.failure,
            errorMessage: 'Unknown problem'));
      }
    });
  }

  Future<void> syncSize() async {
    emit(state.copyWith(sizeSynchronizationStatus: ProgressStatus.inProgress));
    final sizes = List<GenericSize>.from([])
      ..addAll(state.selectedUsualSizes ?? [])
      ..addAll(state.selectedWaistSizes ?? [])
      ..addAll(state.selectedShoeSizes ?? []);
    final response = await repository.syncSize(
        param: SizeSyncParameter(
            dressSize: state.selectedUsualSizes
                ?.map((e) => e.id.toString())
                .toList()
                .join(','),
            waistSize: state.selectedWaistSizes
                ?.map((e) => e.id.toString())
                .toList()
                .join(','),
            shoeSize: state.selectedShoeSizes
                ?.map((e) => e.id.toString())
                .toList()
                .join(','),
            sizes: sizes.map((e) => e.id.toString()).toList().join(',')));
    response.fold((error) {
      emit(state.copyWith(
          sizeSynchronizationStatus: ProgressStatus.failure,
          errorMessage: (error as DetailFailure).message));
    }, (data) async {
      emit(state.copyWith(sizeSynchronizationStatus: ProgressStatus.success));
    });
  }

  Future<void> loadCountries() async {
    try {
      String content = await rootBundle.loadString("assets/cfg/countries.json");
      var myData = json.decode(content);
      var cities = myData
          .map<LocalCountry>((jsonElement) =>
              LocalCountry.fromJson(jsonElement as Map<String, dynamic>))
          .toList();
      emit(state.copyWith(localCountries: cities));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> loadAllSiteSettings() async {
    emit(state.copyWith(fetchSiteSettingStatus: ProgressStatus.inProgress));
    final response = await homeRepository.loadAllSiteSettings();
    response.fold((error) {
      emit(state.copyWith(fetchSiteSettingStatus: ProgressStatus.failure));
    }, (data) {
      /// for NZ
      List<BrandTag> brandNZs = List<BrandTag>.from([]);
      final List<String> valueNZs = (data?.global?.nzBrand?.toJson() ?? {})
          .values
          .map((e) => e.toString())
          .toList();
      for (int i = 0; i < valueNZs.length; i++) {
        List<String> parts = valueNZs[i].split('@@');
        brandNZs.add(BrandTag(idx: i, id: parts[0], name: parts[1]));
      }

      /// for Au
      List<BrandTag> brandAUs = List<BrandTag>.from([]);
      final List<String> valueAUs = (data?.global?.auBrand?.toJson() ?? {})
          .values
          .whereType<String>()
          .toList();
      for (int i = 0; i < valueAUs.length; i++) {
        List<String> parts = valueAUs[i].split('@@');
        brandAUs.add(BrandTag(idx: i, id: parts[0], name: parts[1]));
      }

      emit(state.copyWith(
          fetchSiteSettingStatus: ProgressStatus.success,
          localNZBrands: brandNZs,
          localAuBrands: brandAUs));
    });
  }

  Future<void> loadStartupCategories() async {
    emit(state.copyWith(fetchCategoriesStatus: ProgressStatus.inProgress));
    final response = await repository.loadStartupCategories();
    response.fold((error) {
      emit(state.copyWith(fetchCategoriesStatus: ProgressStatus.failure));
    }, (data) {
      /// for usualSizes
      CategorySize? usualCategorySize =
          data?.categories?.firstWhere((e) => e.urlTitle == 'womens-dresses');
      final List<GenericSize> usualSizes = List<GenericSize>.from([])
        ..addAll(usualCategorySize?.genericSizes ?? []);

      /// for waistSizes
      CategorySize? waistCategorySize = data?.categories
          ?.firstWhere((e) => e.urlTitle == 'womens-bottoms-jeans');
      final List<GenericSize> waistSizes = List<GenericSize>.from([])
        ..addAll(waistCategorySize?.genericSizes ?? []);

      /// for shoeSizes
      CategorySize? shoeCategorySize =
          data?.categories?.firstWhere((e) => e.urlTitle == 'womens-footwear');
      final List<GenericSize> shoeSizes = List<GenericSize>.from([])
        ..addAll(shoeCategorySize?.genericSizes ?? []);

      emit(state.copyWith(
        fetchCategoriesStatus: ProgressStatus.success,
        usualSizes: usualSizes,
        waistSizes: waistSizes,
        shoeSizes: shoeSizes,
      ));
    });
  }
}
