import 'package:designerwardrobe/src/core/shared_prefs/country_storage.dart';
import 'package:designerwardrobe/src/core/shared_prefs/profile_storage.dart';
import 'package:designerwardrobe/src/core/shared_prefs/username_storage.dart';
import 'package:designerwardrobe/src/features/create_listing/domain/respositories/create_listing_repository.dart';
import 'package:designerwardrobe/src/features/create_listing/presentation/cubit/create_listing_cubit.dart';
import 'package:designerwardrobe/src/features/filter/domain/respositories/filter_repository.dart';
import 'package:designerwardrobe/src/features/helper/respositories/helper_repository.dart';
import 'package:designerwardrobe/src/features/filter/presentation/cubit/filter_sort_cubit.dart';
import 'package:designerwardrobe/src/features/authentication/domain/repositories/register_repository.dart';
import 'package:designerwardrobe/src/features/helper/cubit/helper_cubit.dart';
import 'package:designerwardrobe/src/features/home/domain/repositories/home_repository.dart';
import 'package:designerwardrobe/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:designerwardrobe/src/features/home/presentation/cubit/main_tab_cubit.dart';
import 'package:designerwardrobe/src/features/item_detail/domain/respositories/item_detail_repository.dart';
import 'package:designerwardrobe/src/features/item_detail/presentation/cubit/item_detail_cubit.dart';
import 'package:designerwardrobe/src/features/payment/domain/repositories/payment_repository.dart';
import 'package:designerwardrobe/src/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:designerwardrobe/src/configs/app_configs/app_config.dart';
import 'package:designerwardrobe/src/core/network/client/client_provider.dart';
import 'package:designerwardrobe/src/core/shared_prefs/access_token_storage.dart';
import 'package:designerwardrobe/src/core/shared_prefs/theme_mode_storage.dart';
import 'package:designerwardrobe/src/features/banner/domain/repositories/banner_repository.dart';
import 'package:designerwardrobe/src/features/banner/presentation/cubit/banner_cubit.dart';
import 'package:designerwardrobe/src/features/home/domain/repositories/movie_repository.dart';
import 'package:designerwardrobe/src/features/home/presentation/cubit/movie_data_cubit.dart';
import 'package:designerwardrobe/src/features/home/presentation/cubit/movie_selector_cubit.dart';
import 'package:designerwardrobe/src/features/profile/domain/repositories/profile_repository.dart';
import 'package:designerwardrobe/src/features/profile/presentation/cubit/change_password/change_password_cubit.dart';
import 'package:designerwardrobe/src/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:designerwardrobe/src/features/setting/presentation/cubit/setting_cubit.dart';
import 'package:designerwardrobe/src/features/setting/presentation/views/widgets/language/cubit/language_cubit.dart';
import 'package:designerwardrobe/src/features/setting/presentation/views/widgets/theme/cubit/theme_cubit.dart';
import 'package:designerwardrobe/src/router/router.dart';
import 'package:designerwardrobe/src/features/authentication/domain/repositories/auth_repository.dart';
import 'package:designerwardrobe/src/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:designerwardrobe/src/features/autumn_collection/domain/repositories/autumn_collection_repository.dart';
import 'package:designerwardrobe/src/features/autumn_collection/data/repositories/autumn_collection_repository_impl.dart';
import 'package:designerwardrobe/src/features/autumn_collection/presentation/cubit/autumn_collection_cubit.dart';

part 'banner_di.dart';
part 'movie_di.dart';
part 'home_di.dart';
part 'payment_di.dart';

final di = GetIt.instance;

Future<void> initDependencies() async {
  di
    ..registerSingleton<AppConfig>(AppConfig.init())
    ..registerFactory<AccessTokenStorage>(AccessTokenStorage.new)
    ..registerFactory<UsernameStorage>(UsernameStorage.new)
    ..registerFactory<CountryStorage>(CountryStorage.new)
    ..registerFactory<ProfileStorage>(ProfileStorage.new)
    ..registerFactory<ThemeModeStorage>(ThemeModeStorage.new)
    ..registerSingleton<AppDio>(AppDio.init(di<AppConfig>()))
    ..registerSingleton<RootRouter>(RootRouter())
    ..registerSingleton<AuthRepository>(AuthRepositoryImpl())
    ..registerSingleton<RegisterRepository>(RegisterRepositoryImpl())
    ..registerSingleton<ProfileRepository>(
      ProfileRepositoryImpl(),
    )
    ..registerSingleton<PaymentRepository>(
      PaymentRepositoryImpl(),
    )
    ..registerFactory<AuthCubit>(
      () => AuthCubit(di<AuthRepository>(), di<ProfileRepository>()),
    )
    ..registerSingleton<MovieRepository>(MovieRepositoryImpl())
    ..registerSingleton<FilterRepository>(FilterRepositoryImpl())
    ..registerSingleton<HelperRepository>(HelperRepositoryImpl())
    ..registerSingleton<ItemDetailRepository>(ItemDetailRepositoryImpl())
    ..registerSingleton<CreateListingRepository>(CreateListingRepositoryImpl())
    ..registerFactory<ProfileCubit>(
      () => ProfileCubit(di<ProfileRepository>()),
    )
    ..registerFactory<FilterSortCubit>(
      () => FilterSortCubit(di<FilterRepository>()),
    )
    ..registerSingleton<HelperCubit>(
      HelperCubit(di<HelperRepository>()),
    )
    ..registerFactory<ItemDetailCubit>(
      () => ItemDetailCubit(di<ItemDetailRepository>()),
    )
    ..registerFactory<CreateListingCubit>(
      () => CreateListingCubit(di<CreateListingRepository>()),
    )
    ..registerFactory<ChangePasswordCubit>(
      () => ChangePasswordCubit(di<ProfileRepository>()),
    )
    ..registerFactory<SettingCubit>(
      () => SettingCubit(),
    )
    ..registerFactory<LanguageCubit>(
      () => LanguageCubit(),
    )
    ..registerFactory<ThemeCubit>(
      () => ThemeCubit(),
    )
    ..registerSingleton<HomeRepository>(HomeRepositoryImpl())
    ..registerSingleton<AutumnCollectionRepository>(
      AutumnCollectionRepositoryImpl(homeRepository: di<HomeRepository>()),
    )
    ..registerFactory<AutumnCollectionCubit>(
      () => AutumnCollectionCubit(autumnCollectionRepository: di<AutumnCollectionRepository>()),
    );

  injectHomeDependencies(di);
  injectPaymentDependencies(di);
  initBanner(di);
  initMovie(di);
}
