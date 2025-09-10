import 'package:qwid/src/core/di/injections.dart';
import 'package:qwid/src/core/network/client/client_provider.dart';
import 'package:qwid/src/features/authentication/data/remote/services/no_token_service.dart';
import 'package:qwid/src/features/helper/dtos/currency_rate_response.dart';
import 'package:qwid/src/features/payment/data/remote/dtos/parameters/complete_purchase_parameter.dart';
import 'package:qwid/src/features/payment/data/remote/dtos/parameters/create_address_parameter.dart';
import 'package:qwid/src/features/payment/data/remote/dtos/parameters/lookup_address_parameter.dart';
import 'package:qwid/src/features/payment/data/remote/dtos/parameters/submit_credit_card_parameter.dart';
import 'package:qwid/src/features/payment/data/remote/dtos/parameters/windcave_session_parameter.dart';
import 'package:qwid/src/features/payment/data/remote/dtos/response/complete_purchase_response.dart';
import 'package:qwid/src/features/payment/data/remote/dtos/response/create_address_response.dart';
import 'package:qwid/src/features/payment/data/remote/dtos/response/get_client_token_response.dart';
import 'package:qwid/src/features/payment/data/remote/dtos/response/lookup_address_response.dart';
import 'package:qwid/src/features/payment/data/remote/dtos/response/payment_info_response.dart';
import 'package:qwid/src/features/payment/data/remote/dtos/response/submit_credit_card_response.dart';
import 'package:qwid/src/features/payment/data/remote/dtos/response/windcave_card_response.dart';
import 'package:qwid/src/features/payment/data/remote/dtos/response/windcave_session_response.dart';
import 'package:qwid/src/features/payment/data/remote/services/payment_service.dart';
import 'package:qwid/src/core/failures/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../data/remote/dtos/response/my_address_response.dart';

abstract class PaymentRepository {
  Future<Either<Failure, MyAddressResponse>> loadShippingAddress();

  Future<Either<Failure, WindcaveCardResponse>> loadWindCaveCards();

  Future<Either<Failure, PaymentInfoResponse>> getPaymentInfo({
    required int listingId,
    int? userAddressId,
    String? giftCardCode,
    String? promoCode,
    bool? useDWCash,
  });

  Future<Either<Failure, CurrencyRateResponse?>> getCurrencyRate();

  Future<Either<Failure, CompletePurchaseResponse?>> completePurchase(
      CompletePurchaseParameter parameter);

  Future<Either<Failure, WindcaveSessionResponse?>> loadWindCaveSession(
      WindcaveSessionParameter parameter);

  Future<Either<Failure, SubmitCreditCardResponse?>> submitCreditCard({
      required SubmitCreditCardParameter parameter,
      required String baseUrl,
  });

  Future<Either<Failure, LookupAddressResponse?>> lookupAddress({
    required LookupAddressParameter parameter,
  });

  Future<Either<Failure, CreateAddressResponse?>> createAddress({
    required CreateAddressParameter parameter,
  });

  Future<Either<Failure, GetClientTokenResponse?>> getClientToken();
  /// cancel token
  void cancelRequest();
}

class PaymentRepositoryImpl implements PaymentRepository {
  @override
  PaymentRepositoryImpl();

  @override
  Future<Either<Failure, MyAddressResponse>> loadShippingAddress() async {
    try {
      final service = PaymentService(di<AppDio>().getAuthDio(
        apiContentType: 'application/vnd.dw.v1+json',
      ));
      final result = await service.loadShippingAddress();
      if (result.data != null) {
        return Right(result);
      } else {
        return Left(DetailFailure(message: 'Can\'t fetch recommended items'));
      }
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, WindcaveCardResponse>> loadWindCaveCards() async {
    try {
      final service = PaymentService(di<AppDio>().getAuthDio(
        apiContentType: 'application/vnd.dw.v1.4+json',
      ));
      final result = await service.loadWindCaveCards();
      if (result.data != null) {
        return Right(result);
      } else {
        return Left(DetailFailure(message: 'Can\'t fetch recommended items'));
      }
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PaymentInfoResponse>> getPaymentInfo({
    required int listingId,
    int? userAddressId,
    String? giftCardCode,
    String? promoCode,
    bool? useDWCash,
  }) async {
    try {
      final service = PaymentService(di<AppDio>().getAuthDio(
        apiContentType: 'application/vnd.dw.v1.4+json',
      ));
      final result = await service.getPaymentInfo(
        listingId,
        userAddressId ?? -1,
        giftCardCode,
        promoCode,
        useDWCash,
      );
      return Right(result);
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CurrencyRateResponse?>> getCurrencyRate() async {
    try {
      final service = NoTokenService(di<AppDio>().getNoTokenDio(
        apiContentType: 'application/vnd.dw.v1.4+json',
      ));
      var result = await service.getCurrencyRate();
      return Right(result);
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CompletePurchaseResponse?>> completePurchase(
      CompletePurchaseParameter parameter) async {
    try {
      final service = PaymentService(di<AppDio>().getAuthDio(
        apiContentType: 'application/vnd.dw.v1.4+json',
      ));
      var result = await service.completePurchase(parameter.toJson());
      if (result.data == null) {
        return Left(DetailFailure(message: 'completing purchase\'s failed!'));
      } else {
        return Right(result);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        // Server responded with an error
        return Left(DetailFailure(message: e.message));
      } else {
        // No response (e.g., timeout, no internet)
        return Left(DetailFailure(message: e.toString()));
      }

    }
  }

  @override
  Future<Either<Failure, WindcaveSessionResponse?>> loadWindCaveSession(
      WindcaveSessionParameter parameter) async {
    try {
      final service = PaymentService(di<AppDio>().getAuthDio(
        apiContentType: 'application/vnd.dw.v1.4+json',
      ));
      var result = await service.loadWindCaveSession(parameter.toJson());
      if (result.href == null) {
        return Left(DetailFailure(message: 'Loading WindCave Session\'s failed!'));
      } else {
        return Right(result);
      }
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, SubmitCreditCardResponse?>> submitCreditCard({
      required SubmitCreditCardParameter parameter,
      required String baseUrl,
  }) async {
    try {
      final service = PaymentService(di<AppDio>().getSimpleDio(baseUrl: baseUrl));
      var result = await service.submitCreditCard(parameter.toJson());
      if (result.links?.isEmpty ?? true) {
        return Left(DetailFailure(message: 'Submitting Credit Card\'s failed!'));
      } else {
        return Right(result);
      }
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, LookupAddressResponse?>> lookupAddress({
    required LookupAddressParameter parameter,
  }) async {
    try {
      final service = PaymentService(di<AppDio>().getAuthDio(
          apiContentType: 'application/vnd.dw.v1+json'));
      var result = await service.lookupAddress(parameter.toJson());
      if (result.success != true) {
        return Left(DetailFailure(message: 'Looking up address has failed!'));
      } else {
        return Right(result);
      }
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  void cancelRequest() {
    // do nothing
  }

  @override
  Future<Either<Failure, CreateAddressResponse?>> createAddress({
    required CreateAddressParameter parameter}) async {
    try {
      final service = PaymentService(di<AppDio>().getAuthDio(
          apiContentType: 'application/vnd.dw.v1+json'));
      var result = await service.createAddress(parameter.toJson());
      if (result.data?.id != null) {
        return Right(result);
      } else {
        return Left(DetailFailure(message: 'Create address has failed!'));
      }
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, GetClientTokenResponse?>> getClientToken() async {
    try {
      final service = PaymentService(di<AppDio>().getAuthDio(
          apiContentType: 'application/vnd.dw.v1+json'));
      var result = await service.getClientToken();
      if (result.message == 'success') {
        return Right(result);
      } else {
        return Left(DetailFailure(message: 'Getting client token has failed!'));
      }
    } catch (e) {
      return Left(DetailFailure(message: e.toString()));
    }
  }
}
