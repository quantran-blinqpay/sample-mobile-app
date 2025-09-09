import 'package:auto_route/auto_route.dart';
import 'package:designerwardrobe/src/core/constants/filter_class.dart';
import 'package:designerwardrobe/src/features/authentication/presentation/views/onboarding/account_type.dart';
import 'package:designerwardrobe/src/features/authentication/presentation/views/onboarding/account_verification.dart';
import 'package:designerwardrobe/src/features/authentication/presentation/views/onboarding/account_verification_by_phone.dart';
import 'package:designerwardrobe/src/features/authentication/presentation/views/onboarding/basic_information.dart';
import 'package:designerwardrobe/src/features/authentication/presentation/views/onboarding/confirm_pin.dart';
import 'package:designerwardrobe/src/features/authentication/presentation/views/onboarding/contact_information.dart';
import 'package:designerwardrobe/src/features/authentication/presentation/views/onboarding/create_personal_account_screen.dart';
import 'package:designerwardrobe/src/features/authentication/presentation/views/onboarding/login.dart';
import 'package:designerwardrobe/src/features/authentication/presentation/views/onboarding/onboarding.dart';
import 'package:designerwardrobe/src/features/authentication/presentation/views/onboarding/personal_information.dart';
import 'package:designerwardrobe/src/features/authentication/presentation/views/home/qwid_home_screen.dart';
import 'package:designerwardrobe/src/features/authentication/presentation/views/onboarding/security_and_pin.dart';
import 'package:designerwardrobe/src/features/authentication/presentation/views/onboarding/setup_pin.dart';
import 'package:designerwardrobe/src/features/authentication/presentation/views/onboarding/security_question.dart';
import 'package:designerwardrobe/src/features/authentication/presentation/views/onboarding/wallet_carousel.dart';
import 'package:designerwardrobe/src/features/create_listing/presentation/views/create_listing_screen.dart';
import 'package:designerwardrobe/src/features/create_listing/presentation/views/create_listing_wrapper_screen.dart';
import 'package:designerwardrobe/src/features/create_listing/presentation/widgets/select_brands.dart';
import 'package:designerwardrobe/src/features/create_listing/presentation/widgets/select_category.dart';
import 'package:designerwardrobe/src/features/create_listing/presentation/widgets/select_colours.dart';
import 'package:designerwardrobe/src/features/create_listing/presentation/widgets/select_condition.dart';
import 'package:designerwardrobe/src/features/create_listing/presentation/widgets/select_department.dart';
import 'package:designerwardrobe/src/features/create_listing/presentation/widgets/select_second_sub_category.dart';
import 'package:designerwardrobe/src/features/create_listing/presentation/widgets/select_sizes.dart';
import 'package:designerwardrobe/src/features/create_listing/presentation/widgets/select_sub_category.dart';
import 'package:designerwardrobe/src/features/filter/data/remote/dtos/filter_item_response.dart';
import 'package:designerwardrobe/src/features/filter/data/remote/dtos/filter_size_response.dart';
import 'package:designerwardrobe/src/features/filter/data/remote/dtos/get_category_response.dart';
import 'package:designerwardrobe/src/features/filter/presentation/views/filter_screen.dart';
import 'package:designerwardrobe/src/features/filter/presentation/views/filter_sort_screen.dart';
import 'package:designerwardrobe/src/features/filter/presentation/views/detail_filter_sort_screen.dart';
import 'package:designerwardrobe/src/features/filter/presentation/views/filter_wrapper_screen.dart';
import 'package:designerwardrobe/src/features/filter/presentation/widgets/filter_brand.dart';
import 'package:designerwardrobe/src/features/filter/presentation/widgets/your_filter_size.dart';
import 'package:designerwardrobe/src/features/home/presentation/home_screen.dart';
import 'package:designerwardrobe/src/features/home/presentation/home_wrapper_screen.dart';
import 'package:designerwardrobe/src/features/item_detail/data/remote/dtos/listing_detail_response.dart';
import 'package:designerwardrobe/src/features/item_detail/data/remote/dtos/listing_detail_response.dart';
import 'package:designerwardrobe/src/features/item_detail/presentation/views/item_detail_screen.dart';
import 'package:designerwardrobe/src/features/item_detail/presentation/views/item_detail_wrapper_screen.dart';
import 'package:designerwardrobe/src/features/item_detail/presentation/widgets/preview_image.dart';
import 'package:designerwardrobe/src/features/payment/presentation/payment_screen.dart';
import 'package:designerwardrobe/src/features/payment/presentation/webview/payment_webview.dart';
import 'package:designerwardrobe/src/features/profile/presentation/views/drafts_screen.dart';
import 'package:designerwardrobe/src/features/payment/presentation/payment_wrapper_screen.dart';
import 'package:designerwardrobe/src/features/profile/presentation/views/seller_screen.dart';
import 'package:designerwardrobe/src/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:designerwardrobe/src/core/di/injections.dart';
import 'package:designerwardrobe/src/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:designerwardrobe/src/features/authentication/presentation/views/forgot_password_screen.dart';
import 'package:designerwardrobe/src/features/authentication/presentation/views/register/register_screen.dart';
import 'package:designerwardrobe/src/features/banner/presentation/cubit/banner_cubit.dart';
import 'package:designerwardrobe/src/features/authentication/presentation/views/signin_screen.dart';
import 'package:designerwardrobe/src/features/profile/presentation/views/profile_screen.dart';
import 'package:designerwardrobe/src/features/profile/presentation/views/wallet_screen.dart';
import 'package:designerwardrobe/src/features/setting/presentation/views/setting_screen.dart';
import 'package:designerwardrobe/src/router/routes/guards/secure_guards.dart';
import 'package:collection/collection.dart';

import '../features/profile/presentation/views/change_password_screen.dart';

part './routes/home_routes.dart';
part 'routes/auth_routes.dart';
part 'routes/profile_routes.dart';
part 'routes/setting_routes.dart';
part 'routes/filter_routes.dart';
part 'routes/item_detail_routes.dart';
part 'routes/create_listing_routes.dart';
part 'routes/payment_routes.dart';

part 'router.gr.dart';

@AutoRouterConfig(generateForDir: ['lib/src'], replaceInRouteName: 'Page,Route')
class RootRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: '/', page: RootWrapperPageRoute.page, children: [
          ..._homeRoutes,
          ..._filterRoutes,
          ..._profileRoutes,
          ..._settingRoutes,
          ..._itemDetailRoutes,
          ..._createListingRoutes,
          ..._paymentRoutes,
          AutoRoute(path: 'preview_image', page: PreviewImageScreenRoute.page),
        ]),
      ];
}

@RoutePage(name: 'RootWrapperPageRoute')
class RootWrapperPage extends StatelessWidget {
  const RootWrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<BannerCubit>(
          create: (context) => di<BannerCubit>()..getBanner()),
      BlocProvider<AuthCubit>(
          create: (context) => di<AuthCubit>()..initData()),
    ], child: const AutoRouter());
  }
}
