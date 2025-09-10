import 'package:qwid/src/core/network/response/array_response.dart';
import 'package:qwid/src/core/network/response/object_response.dart';
import 'package:qwid/src/features/authentication/data/remote/dtos/login_response.dart';
import 'package:qwid/src/features/authentication/data/remote/dtos/register/category/category_size_response.dart';
import 'package:qwid/src/features/authentication/data/remote/dtos/register/response/code_sending_response.dart';
import 'package:qwid/src/features/authentication/data/remote/dtos/register/response/code_verification_response.dart';
import 'package:qwid/src/features/authentication/data/remote/dtos/register/response/email_validation_response.dart';
import 'package:qwid/src/features/authentication/data/remote/dtos/register/response/size_sync_response.dart';
import 'package:qwid/src/features/authentication/data/remote/dtos/register/response/user_validation_response.dart';
import 'package:qwid/src/features/authentication/data/remote/dtos/register/response/username_creation_response.dart';
import 'package:qwid/src/features/authentication/data/remote/dtos/register/response/username_validation_response.dart';
import 'package:qwid/src/features/authentication/data/remote/dtos/register_dto.dart';
import 'package:qwid/src/features/create_listing/data/remote/dtos/get_brands_response.dart';
import 'package:qwid/src/features/helper/dtos/currency_rate_response.dart';
import 'package:qwid/src/features/filter/data/remote/dtos/filter_search_response.dart';
import 'package:qwid/src/features/helper/dtos/get_startup_response.dart';
import 'package:qwid/src/features/home/data/remote/dtos/movie_dto.dart';
import 'package:qwid/src/features/home/data/remote/dtos/recombee_session.dart';
import 'package:qwid/src/features/home/data/remote/dtos/recommended_item.dart';
import 'package:qwid/src/features/home/data/remote/dtos/site_setting/site_setting_item.dart';
import 'package:qwid/src/features/item_detail/data/remote/dtos/all_question_response.dart';
import 'package:qwid/src/features/item_detail/data/remote/dtos/listing_detail_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'no_token_service.g.dart';

@RestApi()
abstract class NoTokenService {
  factory NoTokenService(Dio dio) = _NoTokenService;

  @POST('/api/auth/login')
  Future<LoginResponse> signIn(@Body() Map<String, dynamic> body,
      @CancelRequest() CancelToken cancelToken);

  @POST('/api/client_auth/register')
  Future<ObjectResponse<RegisterDTO>> register(
      @Body() Map<String, dynamic> body,
      @CancelRequest() CancelToken cancelToken);

  @POST('/api/client_auth/forgot-password')
  Future<ObjectResponse<dynamic>> forgotPassword(
      @Body() Map<String, dynamic> body,
      @CancelRequest() CancelToken cancelToken);

  @GET('/api/movie')
  Future<ArrayResponse<MovieDto>> getTopPage(
      @Query("date") String date); // dd/MM/yyyy

  @GET('/api/helper/startup')
  Future<GetStartupResponse> loadStartup();

  @GET('/api/helper/startup')
  Future<GetBrandsResponse> loadStartupBrands(
      @Query("data_type") String? dataType,
      @Query("locality") String? locality,
      @Query("brand_fields") String? brandFields);

  @GET('/api/helper/startup')
  Future<CategorySizeResponse> loadStartupCategories(
      @Query("data_type") String dataType,
      @Query("locality") String locality,
      @Query("brand_fields") String brandFields);

  @POST('/api/recombee/session')
  Future<RecombeeSession> loadRecombeeSession();

  @GET('/api/recombee/recommend-items')
  Future<RecommendedItems> loadRecommendedItems(
    @Query("scenario") String scenario,
    @Query("locale") String locale, {
    @Query("item_id") int? itemId,
  });

  @GET('/api/recombee/recommend-next-items')
  Future<RecommendedItems> loadNextItems(@Query("recomm_id") String recommId);

  @GET('/api/helper/site-settings/all')
  Future<SiteSettingItem> loadAllSiteSettings();

  @GET('/api/search')
  Future<FilterSearchResponse> search({
    @Query('page') int? page,
    @Query('perPage') int? perPage,
    @Query('query') String? textSearch,
    @Query('sort') String? sort,
    @Query('categories[]') String? categories,

    /// ['adidas', 'henne']
    @Query('brands[]') List<String>? brands,

    /// 32,39,41
    @Query('sizes') String? sizes,

    /// ['Red', 'Orange']
    @Query('colours[]') List<String>? colours,

    /// 1-null | null-2 | 3-4
    @Query('priceRanges') String? priceRanges,
    @Query('minDiscount') String? minDiscount,

    /// ['nwt', 'preLoved']
    @Query('condition') List<String>? condition,
    @Query('location') String? location,
    @Query('user') String? user,
    @Query('categories') int? categoriesId,
  });

  @GET('/api/auth/validate/email/{email}')
  Future<EmailValidationResponse> validateEmail(@Path("email") String email);

  @GET('/api/auth/validate/username/{username}')
  Future<UsernameValidationResponse> validateUserName(
      @Path("username") String username);

  @POST('/api/user/valid')
  Future<UserValidationResponse> validateUser(
      @Body() Map<String, dynamic> body);

  @POST('/api/sms-verification/send-code')
  Future<CodeSendingResponse> sendCode(@Body() Map<String, dynamic> body);

  @POST('/api/sms-verification/verify')
  Future<CodeVerificationResponse> verifyCode(
      @Body() Map<String, dynamic> body);

  @POST('/api/user/create')
  Future<UsernameCreationResponse> createUser(
      @Body() Map<String, dynamic> body);

  @PUT('/api/user/me/sizes/sync')
  Future<SizeSyncResponse> syncSize(@Body() Map<String, dynamic> body);

  @GET('/api/helper/currency-rate')
  Future<CurrencyRateResponse> getCurrencyRate();

  @GET('/api/listing/{id}')
  Future<ListingDetailResponse> getListingDetail(
    @Path('id') int id,
    @Query('include') String? include,
  );

  @GET('/api/listing/{id}/questions/all')
  Future<AllQuestionResponse> getAllQuestion(@Path('id') int id);
}
