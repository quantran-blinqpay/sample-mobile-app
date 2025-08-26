import 'dart:convert';

import 'package:designerwardrobe/src/core/failures/failure.dart';
import 'package:designerwardrobe/src/core/network/response/enum/progress_status.dart';
import 'package:designerwardrobe/src/features/authentication/data/remote/dtos/register/country/local_country.dart';
import 'package:designerwardrobe/src/features/helper/dtos/currency_rate_response.dart';
import 'package:designerwardrobe/src/features/item_detail/data/remote/dtos/listing_detail_response.dart';
import 'package:designerwardrobe/src/features/payment/data/remote/dtos/parameters/complete_purchase_parameter.dart';
import 'package:designerwardrobe/src/features/payment/data/remote/dtos/response/my_address_response.dart';
import 'package:designerwardrobe/src/features/payment/data/remote/dtos/response/payment_info_response.dart';
import 'package:designerwardrobe/src/features/payment/data/remote/dtos/response/windcave_card_response.dart';
import 'package:designerwardrobe/src/features/payment/domain/repositories/payment_repository.dart';
import 'package:designerwardrobe/src/features/profile/domain/repositories/profile_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:designerwardrobe/src/features/profile/domain/model/user_data.dart'
    as profile;
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.repository, this.profileRepository) : super(PaymentState());

  final PaymentRepository repository;
  final ProfileRepository profileRepository;

  TextEditingController promoCodeController = TextEditingController();

  TextEditingController giftCardController = TextEditingController();

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

  void updatePromoCode(String promoCode) {
    emit(state.copyWith(promoCode: promoCode));
  }

  void updateUseDWCash() {
    emit(state.copyWith(useDWCash: !state.useDWCash));
  }

  void updateGiftCard(String giftCardCode) {
    emit(state.copyWith(giftCardCode: giftCardCode));
  }

  void selectAddress(AddressData address) {
    emit(state.copyWith(selectedAddress: address));
  }

  void selectWindcaveCard(WindcaveCardData card) {
    emit(state.copyWith(selectedCards: card));
  }

  void updateListingId(int listingId) {
    emit(state.copyWith(listingId: listingId));
  }

  void updateProductInfo(ListingDetailResponseData? productInfo) {
    emit(state.copyWith(productInfo: productInfo));
  }

  void updateCreditCard(WindcaveCardData creditCard) {
    emit(state.copyWith(addCreditCardsStatus: ProgressStatus.inProgress));
    final cards = List<WindcaveCardData>.from(state.cards ?? [])..add(creditCard);
    emit(state.copyWith(cards: cards, addCreditCardsStatus: ProgressStatus.success));
  }

  void updateAddress(AddressData address) {
    emit(state.copyWith(addAddressStatus: ProgressStatus.inProgress));
    final addresses = List<AddressData>.from(state.addresses ?? [])..add(address);
    emit(state.copyWith(addresses: addresses, addAddressStatus: ProgressStatus.success));
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
      updateCountry(cities.first);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> loadShippingAddress() async {
    try {
      emit(state.copyWith(getMyAddressStatus: ProgressStatus.inProgress));
      final response = await repository.loadShippingAddress();
      response.fold((error) {
        emit(state.copyWith(getMyAddressStatus: ProgressStatus.failure));
      }, (data) {
        AddressData? defaultAddress =
            data.data?.firstWhere((e) => e.isDefault == true);

        emit(state.copyWith(
          addresses: data.data,
          selectedAddress: defaultAddress,
          getMyAddressStatus: ProgressStatus.success,
        ));
        getPaymentInfo(inSilence: false);
      });
    } catch (e) {
      emit(state.copyWith(getMyAddressStatus: ProgressStatus.failure));
    }
  }

  Future<void> loadWindCaveCards() async {
    try {
      emit(state.copyWith(getWindcaveCardsStatus: ProgressStatus.inProgress));
      final response = await repository.loadWindCaveCards();
      response.fold((error) {
        emit(state.copyWith(getWindcaveCardsStatus: ProgressStatus.failure));
      }, (data) {
        // AddressData? defaultAddress = data.data?.firstWhere((e)=> e.isDefault == true);
        emit(state.copyWith(
          cards: data.data,
          // selectedAddress: defaultAddress,
          getWindcaveCardsStatus: ProgressStatus.success,
        ));
      });
    } catch (e) {
      emit(state.copyWith(getWindcaveCardsStatus: ProgressStatus.failure));
    }
  }

  Future<void> getPaymentInfo({bool inSilence = true}) async {
    try {
      if (inSilence) {
        emit(state.copyWith(
            getPaymentInfoInSilenceStatus: ProgressStatus.inProgress));
      } else {
        emit(state.copyWith(getPaymentInfoStatus: ProgressStatus.inProgress));
      }

      final response = (state.useDWCash == false)
          ? await repository.getPaymentInfo(
              listingId: state.listingId ?? -1,
              userAddressId: state.selectedAddress?.id,
              giftCardCode: state.giftCardCode,
              promoCode: state.promoCode,
            )
          : await repository.getPaymentInfo(
              listingId: state.listingId ?? -1,
              userAddressId: state.selectedAddress?.id,
              giftCardCode: state.giftCardCode,
              promoCode: state.promoCode,
              useDWCash: state.useDWCash,
            );
      response.fold((error) {
        if (inSilence) {
          emit(state.copyWith(
              getPaymentInfoInSilenceStatus: ProgressStatus.failure));
        } else {
          emit(state.copyWith(getPaymentInfoStatus: ProgressStatus.failure));
        }
      }, (data) {
        if (inSilence) {
          emit(state.copyWith(
            paymentInfo: data,
            getPaymentInfoInSilenceStatus: ProgressStatus.success,
          ));
        } else {
          emit(state.copyWith(
            paymentInfo: data,
            getPaymentInfoStatus: ProgressStatus.success,
          ));
        }
      });
    } catch (e) {
      if (inSilence) {
        emit(state.copyWith(
            getPaymentInfoInSilenceStatus: ProgressStatus.failure));
      } else {
        emit(state.copyWith(getPaymentInfoStatus: ProgressStatus.failure));
      }
    }
  }

  Future<void> getCurrencyRate() async {
    emit(state.copyWith(fetchCurrencyStatus: ProgressStatus.inProgress));
    final response = await repository.getCurrencyRate();
    response.fold((error) {
      emit(state.copyWith(fetchCurrencyStatus: ProgressStatus.failure));
    }, (data) {
      emit(state.copyWith(
        dataCurrencyRate: data,
        fetchCurrencyStatus: ProgressStatus.success,
      ));
    });
  }

  Future<void> getMyProfile() async {
    emit(state.copyWith(fetchUserProfileStatus: ProgressStatus.inProgress));
    final response = await profileRepository.getMe();
    response.fold((error) {
      emit(state.copyWith(fetchUserProfileStatus: ProgressStatus.failure));
    }, (data) {
      emit(state.copyWith(
        userProfile: data,
        fetchUserProfileStatus: ProgressStatus.success,
      ));
    });
  }

  Future<void> completePurchase() async {
    emit(state.copyWith(completePurchaseStatus: ProgressStatus.inProgress));
    final List<PaymentInfo> paymentInfos = [];

    /// promo code
    if ((state.paymentInfo?.promoCode?.discount_to_use ?? 0.0) > 0) {
      paymentInfos.add(PaymentInfo(
        amount: state.paymentInfo?.promoCode?.discount_to_use,
        method: 'promo_code',
        code: state.paymentInfo?.promoCode?.code ?? '',
      ));
    }

    /// gift card
    if ((state.paymentInfo?.pricing?.giftCard?.amountToUse ?? 0.0) > 0) {
      paymentInfos.add(PaymentInfo(
        amount: state.paymentInfo?.pricing?.giftCard?.amountToUse,
        method: 'gift_card',
        code: state.paymentInfo?.pricing?.giftCard?.code ?? '',
      ));
    }

    /// DW Credit
    if ((state.paymentInfo?.pricing?.dwCreditAmount?.amountToUse ?? 0.0) > 0) {
      paymentInfos.add(PaymentInfo(
        amount: state.paymentInfo?.pricing?.dwCreditAmount?.amountToUse,
        method: 'dw_credit',
      ));
    }

    /// DW Cash
    if ((state.paymentInfo?.pricing?.dwCashAmount?.amountToUse ?? 0.0) > 0) {
      paymentInfos.add(PaymentInfo(
        amount: state.paymentInfo?.pricing?.dwCashAmount?.amountToUse,
        method: 'dw_cash',
      ));
    }

    if(state.selectedCards != null && (state.paymentInfo?.pricing?.totalToPay ?? 0) > 0){
      paymentInfos.add(PaymentInfo(
        amount: state.paymentInfo?.pricing?.totalToPay,
        method: 'credit_card',
        code: state.selectedCards?.token,
        action: state.isWindcave ? 'windcave': state.isBraintree ? 'braintree': '',
      ));
    }

    final parameter = CompletePurchaseParameter(
        action: state.isWindcave ? 'windcave': state.isBraintree ? 'braintree': '',
        payment: paymentInfos,
        listingId: state.listingId,
        shippingCode: "standard_shipping",
        userAddressId: state.selectedAddress?.id.toString(),
        paymentMethodNonce: state.selectedCards?.token,
        // deliveryInstructions: "NOTHING",
        mobilePhone: state.userProfile?.mobilePhone,
    );
    debugPrint('quanth: complete purchase action= ${parameter.action}');
    debugPrint('quanth: complete purchase paymentMethodNonce= ${parameter.paymentMethodNonce}');
    for(int i =0; i< (parameter.payment?.length ?? 0); i++) {
      debugPrint('quanth: complete purchase payment[$i].action= ${parameter.payment?[i].action}');
      debugPrint('quanth: complete purchase payment[$i].method= ${parameter.payment?[i].method}');
      debugPrint('quanth: complete purchase payment[$i].amount= ${parameter.payment?[i].amount}');
      debugPrint('quanth: complete purchase payment[$i].code= ${parameter.payment?[i].code}');
    }
    debugPrint('quanth: complete purchase listingId= ${parameter.listingId}');
    debugPrint('quanth: complete purchase shippingCode= ${parameter.shippingCode}');
    debugPrint('quanth: complete purchase userAddressId= ${parameter.userAddressId}');
    debugPrint('quanth: complete purchase deliveryInstructions= ${parameter.deliveryInstructions}');
    debugPrint('quanth: complete purchase mobilePhone= ${parameter.mobilePhone}');

    final response = await repository.completePurchase(parameter);
    response.fold((error) {
      emit(state.copyWith(
          completePurchaseStatus: ProgressStatus.failure,
          errorMessage: (error as DetailFailure).message));
    }, (data) {
      emit(state.copyWith(
        completePurchaseStatus: ProgressStatus.success,
      ));
    });
  }
}
