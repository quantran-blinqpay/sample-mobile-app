import 'dart:convert';
import 'dart:io';

import 'package:designerwardrobe/src/features/payment/data/remote/dtos/response/complete_purchase_response.dart';
import 'package:designerwardrobe/src/features/payment/data/remote/dtos/response/create_address_response.dart';
import 'package:designerwardrobe/src/features/payment/data/remote/dtos/response/get_client_token_response.dart';
import 'package:designerwardrobe/src/features/payment/data/remote/dtos/response/lookup_address_response.dart';
import 'package:designerwardrobe/src/features/payment/data/remote/dtos/response/my_address_response.dart';
import 'package:designerwardrobe/src/features/payment/data/remote/dtos/response/payment_info_response.dart';
import 'package:designerwardrobe/src/features/payment/data/remote/dtos/response/submit_credit_card_response.dart';
import 'package:designerwardrobe/src/features/payment/data/remote/dtos/response/verify_stock_response.dart';
import 'package:designerwardrobe/src/features/payment/data/remote/dtos/response/windcave_card_response.dart';
import 'package:designerwardrobe/src/features/payment/data/remote/dtos/response/windcave_session_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'payment_service.g.dart';

@RestApi()
abstract class PaymentService {
  factory PaymentService(Dio dio) = _PaymentService;

  @POST('/api/purchase/complete')
  Future<CompletePurchaseResponse> completePurchase(
      @Body() Map<String, dynamic> body);

  @GET('/api/purchase/verify-stock')
  Future<VerifyStockResponse> verifyStock(
      @Query("listing_id") int listingId);

  @GET('/api/purchase/{listing_id}/information') // application/vnd.dw.v1.4+json
  Future<PaymentInfoResponse> getPaymentInfo(
      @Path("listing_id") int listingId,
      @Query("user_address_id") int userAddressId,
      @Query("gift_card_code") String? giftCardCode,
      @Query("promo_code") String? promoCode,
      @Query("use_dw_cash") bool? useDWCash,
  );

  @GET('/api/user/me/addresses') // application/vnd.dw.v1.4+json
  Future<MyAddressResponse> loadShippingAddress();

  @POST('/api/windcave/cards') // application/vnd.dw.v1.4+json
  Future<WindcaveCardResponse> loadWindCaveCards();

  @POST('/api/windcave/session') // application/vnd.dw.v1.4+json
  Future<WindcaveSessionResponse> loadWindCaveSession(
      @Body() Map<String, dynamic> body);

  @POST("")
  Future<SubmitCreditCardResponse> submitCreditCard(
      @Body() Map<String, dynamic> body);

  @GET('/api/helper/address/lookup') // application/vnd.dw.v1+json
  Future<LookupAddressResponse> lookupAddress(
      @Body() Map<String, dynamic> body);

  @POST('/api/user/me/addresses/create-from-address-id') // application/vnd.dw.v1+json
  Future<CreateAddressResponse> createAddress(
      @Body() Map<String, dynamic> body);

  @GET('/api/payment/get-client-token')
  Future<GetClientTokenResponse> getClientToken();

}
