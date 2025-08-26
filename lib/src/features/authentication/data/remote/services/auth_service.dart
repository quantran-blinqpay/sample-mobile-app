import 'dart:io';

import 'package:designerwardrobe/src/core/network/response/default_response.dart';
import 'package:designerwardrobe/src/features/authentication/data/remote/dtos/logout_response.dart';
import 'package:designerwardrobe/src/features/create_listing/data/remote/dtos/build_desc_by_ai_response.dart';
import 'package:designerwardrobe/src/features/create_listing/data/remote/dtos/create_listing_response.dart';
import 'package:designerwardrobe/src/features/create_listing/data/remote/dtos/get_commission_response.dart';
import 'package:designerwardrobe/src/features/create_listing/data/remote/dtos/get_dwpost_freight_response.dart';
import 'package:designerwardrobe/src/features/create_listing/data/remote/dtos/get_free_bump_response.dart';
import 'package:designerwardrobe/src/features/create_listing/data/remote/dtos/get_price_recommend_response.dart';
import 'package:designerwardrobe/src/features/create_listing/data/remote/dtos/search_brands_response.dart';
import 'package:designerwardrobe/src/features/create_listing/data/remote/dtos/upload_image_response.dart';
import 'package:designerwardrobe/src/features/create_listing/domain/models/create_listing_model.dart';
import 'package:designerwardrobe/src/features/create_listing/domain/models/save_draft_model.dart';
import 'package:designerwardrobe/src/features/filter/data/remote/dtos/get_condition_response.dart';
import 'package:designerwardrobe/src/features/filter/data/remote/dtos/my_size_response.dart';
import 'package:designerwardrobe/src/features/filter/domain/models/my_size_model.dart';
import 'package:designerwardrobe/src/features/authentication/data/remote/dtos/register/category/brand_following_response.dart';
import 'package:designerwardrobe/src/features/home/data/remote/dtos/offer/response/make_offer_response.dart';
import 'package:designerwardrobe/src/features/home/data/remote/dtos/watchlist/watchlist_item.dart';
import 'package:designerwardrobe/src/features/authentication/data/remote/dtos/register/response/batch_update_frequency_response.dart';
import 'package:designerwardrobe/src/features/authentication/data/remote/dtos/register/response/size_sync_response.dart';
import 'package:designerwardrobe/src/features/item_detail/data/remote/dtos/ask_question_response.dart';
import 'package:designerwardrobe/src/features/item_detail/data/remote/dtos/listing_detail_response.dart';
import 'package:designerwardrobe/src/features/profile/domain/model/get_drafts_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:designerwardrobe/src/core/network/response/object_response.dart';
import 'package:designerwardrobe/src/features/authentication/data/remote/dtos/profile_dto.dart';

part 'auth_service.g.dart';

@RestApi()
abstract class AuthService {
  factory AuthService(Dio dio) = _AuthService;

  @POST('/api/auth/logout')
  Future<LogoutResponse> signOut(@CancelRequest() CancelToken cancelToken);

  @GET('/api/client_auth/refresh')
  Future<ObjectResponse<ProfileDTO>> refreshToken();

  @GET('/api/user/me/sizes')
  Future<MySizeResponse> getMySizes();

  @PUT('/api/user/me/sizes/sync')
  Future<MySizeResponse> saveSizes(@Body() MySizeModel body);

  @GET('/api/user/me/watchlist')
  Future<WatchlistItem> loadWatchList(@CancelRequest() CancelToken cancelToken);

  @POST('/api/user-saved-searches/batch-update-frequency')
  Future<BatchUpdateFrequencyResponse> batchUpdateFrequency(
      @Body() Map<String, dynamic> body);

  @PUT('/api/user/me/sizes/sync')
  Future<SizeSyncResponse> syncSize(@Body() Map<String, dynamic> body);

  @POST('/api/user-saved-searches/follow/brand')
  Future<BrandFollowingResponse> followBrand(@Body() Map<String, dynamic> body);

  @GET('/api/listing/watch/{id}')
  Future<DefaultResponse> addToFav(@Path('id') int id);

  @GET('/api/listing/unwatch/{id}')
  Future<DefaultResponse> removeFromFav(@Path('id') int id);

  @POST('/api/listing/{id}/questions/add')
  Future<AskQuestionResponse> askQuestion(
    @Path('id') int id,
    @Body() Map<String, dynamic> body,
  );

  @POST('/api/listing_offer/create') // application/vnd.dw.v1+json
  Future<MakeOfferResponse> makeOffer(@Body() Map<String, dynamic> body);

  @GET('/api/listing/{id}')
  Future<ListingDetailResponse> getListingDetail(
    @Path('id') int id,
    @Query('include') String? include,
  );

  @POST('/api/counter_offer/create') // application/vnd.dw.v1+json
  Future<dynamic> counterOffer(@Body() Map<String, dynamic> body);

  @POST('/api/listing_image/create')
  @MultiPart()
  Future<UploadImageResponse> uploadImage(
    @Part(name: 'uploadImage') File? file,
  );

  @POST('/api/listing_image/delete')
  Future<DefaultResponse> deleteImage(
    @Body() Map<String, dynamic> body,
  );

  @POST('/api/listing_image/rotate')
  Future<UploadImageResponse> rotateImage(
    @Body() Map<String, dynamic> body,
  );

  @POST('/api/listing-ai/build-description')
  Future<BuildDescByAiResponse> buildDescByAI(
      @Body() Map<String, dynamic> body);

  @POST('/api/listing/price-recommendation')
  Future<GetPriceRecommendResponse> getPriceRecommendation(
      @Body() Map<String, dynamic> body);

  @GET('/api/search/brands')
  Future<List<SearchBrandsResponse>> searchBrands({
    @Query('category_id') int? categoryId,
    @Query('query') String? textSearch,
  });

  @GET('/api/category/{id}/conditions')
  Future<GetConditionResponse> getConditions({
    @Path('id') int? id,
  });

  @GET('/api/dwpost/freight/{id}')
  Future<GetDwpostFreightResponse> getDwpostFreight({
    @Path('id') int? id,
    @Query('include_au') bool? includeAu,
  });

  @GET('/api/user/me/free-bump')
  Future<GetFreeBumpResponse> getFreeBump();

  @GET('/api/helper/commission')
  Future<GetCommissionResponse> getCommission({
    @Query('sell_price') String? sellPrice,
    @Query('shipping_price') String? shippingPrice,
    @Query('is_rental') bool? isRental,
  });

  @POST('/api/listing/create')
  Future<CreateListingResponse> createListing({
    @Body() CreateListingModel? body,
  });

  @POST('/api/listing/edit')
  Future<CreateListingResponse> editListing({
    @Body() CreateListingModel? body,
  });

  @POST('/api/user/me/selling/draft')
  Future<dynamic> saveDraft({
    @Body() SaveDraftModel? body,
  });

  @GET('/api/user/me/selling/drafts')
  Future<GetDraftsResponse> getDrafts(
    @Query('page') int? page,
    @Query('include') String? include,
  );
}
