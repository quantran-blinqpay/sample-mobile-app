import 'package:bloc/bloc.dart';
import 'package:designerwardrobe/src/core/network/response/enum/progress_status.dart';
import 'package:designerwardrobe/src/core/utils/card_util.dart';
import 'package:designerwardrobe/src/features/payment/data/remote/dtos/parameters/submit_credit_card_parameter.dart';
import 'package:designerwardrobe/src/features/payment/data/remote/dtos/parameters/windcave_session_parameter.dart';
import 'package:designerwardrobe/src/features/payment/data/remote/dtos/response/windcave_card_response.dart';
import 'package:designerwardrobe/src/features/payment/domain/repositories/payment_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';

part 'payment_card_state.dart';

class PaymentCardCubit extends Cubit<PaymentCardState> {
  PaymentCardCubit(this.repository) : super(PaymentCardState());
  final PaymentRepository repository;

  void updateCardNumber(String? cardNumber) {
    emit(state.copyWith(cardNumber: cardNumber));
  }

  void updateExpiredDate(String? expiredDate) {
    emit(state.copyWith(expiredDate: expiredDate));
  }

  void updateSecurityCode(String? securityCode) {
    emit(state.copyWith(securityCode: securityCode));
  }

  void updateNameOnCard(String? nameOnCard) {
    emit(state.copyWith(nameOnCard: nameOnCard));
  }

  Future<void> submitCreditCardToWindCave({
    required String cardNumber,
    required String expiredDate,
    required String securityCode,
    required String nameOnCard,
    required double totalToPay,
    required String currency,
  }) async {
    emit(state.copyWith(submitCreditCardStatus: ProgressStatus.inProgress));
    final sessionResponse = await repository.loadWindCaveSession(
        WindcaveSessionParameter(amount: totalToPay, currency: currency)
    );
    sessionResponse.fold((error) {
      emit(state.copyWith(submitCreditCardStatus: ProgressStatus.failure));
    }, (firstData) async {
      final month = expiredDate.split('/')[0];
      final year = expiredDate.split('/')[1];
      final submitCreditCardResponse = await repository.submitCreditCard(
          parameter: SubmitCreditCardParameter(
              card: CardInfo(
                dateExpiryMonth: month,
                cardNumber: cardNumber,
                dateExpiryYear: year,
                cvc2: securityCode,
              )
          ),
          baseUrl: firstData?.href ?? ''
      );
      submitCreditCardResponse.fold((error) {
        emit(state.copyWith(submitCreditCardStatus: ProgressStatus.failure));
      }, (secondData) async {
        if(secondData?.links?.isEmpty ?? true) {
          emit(state.copyWith(submitCreditCardStatus: ProgressStatus.failure));
        } else if(secondData?.links?.first.rel?.toLowerCase() == 'done') {
          String last4 = cardNumber.substring(cardNumber.length - 4);
          final newCard = WindcaveCardData(
            card_id: 0,
            last4: last4,
            image_url: null,
            card_type: 'VISA',
            expire_month: int.parse(month),
            expire_year: int.parse(year),
            card_holder_name: nameOnCard,
            token: secondData?.id,
          );
          emit(state.copyWith(
            submitCreditCardStatus: ProgressStatus.success,
            creditCard: newCard,
          ));
        } else if(secondData?.links?.first.rel?.toLowerCase() == '3ds') {
          String last4 = cardNumber.substring(cardNumber.length - 4);
          final newCard = WindcaveCardData(
            card_id: 0,
            last4: last4,
            image_url: null,
            card_type: CardUtils.fromCardNumber(cardNumber).cardType,
            expire_month: int.parse(month),
            expire_year: int.parse(year),
            card_holder_name: nameOnCard,
            token: secondData?.id,
          );
          emit(state.copyWith(
              submitCreditCardStatus: ProgressStatus.direct,
              href: secondData?.links?.first.href,
              temporaryToken: secondData?.id,
              temporaryCreditCard: newCard,
          ));
        } else {
          emit(state.copyWith(submitCreditCardStatus: ProgressStatus.failure));
        }
      });
    });
  }

  Future<void> approveTemporaryCreditCard() async {
    emit(state.copyWith(
      submitCreditCardStatus: ProgressStatus.success,
      creditCard: state.temporaryCreditCard,
    ));
  }

  Future<void> getClientToken() async {
    emit(state.copyWith(getClientTokenStatus: ProgressStatus.inProgress));
    final response = await repository.getClientToken();
    response.fold((error) {
      emit(state.copyWith(getClientTokenStatus: ProgressStatus.failure));
    }, (data) async {
      emit(state.copyWith(
          clientToken: data?.clientToken,
          getClientTokenStatus: ProgressStatus.failure));
    });
  }

  Future<void> submitCreditCardToBraintree({
    required String cardNumber,
    required String expiredDate,
    required String securityCode,
    required String nameOnCard,
  }) async {
    emit(state.copyWith(submitCreditCardStatus: ProgressStatus.inProgress));
    final clientTokenResponse = await repository.getClientToken();
    clientTokenResponse.fold((error) {
      emit(state.copyWith(submitCreditCardStatus: ProgressStatus.failure));
    }, (data) async {
      final tokenizationKey = data?.clientToken ?? '';
      final month = expiredDate.split('/')[0];
      final year = expiredDate.split('/')[1];
      final request = BraintreeCreditCardRequest(
        cardNumber: cardNumber,
        expirationMonth: month.toString(),
        expirationYear: year.toString(),
        cvv: securityCode,
      );
      final result = await Braintree.tokenizeCreditCard(
        tokenizationKey,
        request,
      );
      if (result != null) {
        String last4 = cardNumber.substring(cardNumber.length - 4);
        final newCard = WindcaveCardData(
          card_id: 0,
          last4: last4,
          image_url: null,
          card_type: CardUtils.fromCardNumber(cardNumber).cardType,
          expire_month: int.parse(month),
          expire_year: int.parse(year),
          card_holder_name: nameOnCard,
          token: result.nonce,
        );
        emit(state.copyWith(
          submitCreditCardStatus: ProgressStatus.success,
          creditCard: newCard,
        ));
      } else {
        emit(state.copyWith(submitCreditCardStatus: ProgressStatus.failure));
      }
    });
  }
}
