import 'package:auto_route/auto_route.dart';
import 'package:qwid/src/core/constants/filter_class.dart';
import 'package:qwid/src/features/create_listing/presentation/views/create_listing_screen.dart';
import 'package:qwid/src/features/create_listing/presentation/views/create_listing_wrapper_screen.dart';
import 'package:qwid/src/features/create_listing/presentation/widgets/select_brands.dart';
import 'package:qwid/src/features/create_listing/presentation/widgets/select_category.dart';
import 'package:qwid/src/features/create_listing/presentation/widgets/select_colours.dart';
import 'package:qwid/src/features/create_listing/presentation/widgets/select_condition.dart';
import 'package:qwid/src/features/create_listing/presentation/widgets/select_department.dart';
import 'package:qwid/src/features/create_listing/presentation/widgets/select_second_sub_category.dart';
import 'package:qwid/src/features/create_listing/presentation/widgets/select_sizes.dart';
import 'package:qwid/src/features/create_listing/presentation/widgets/select_sub_category.dart';
import 'package:qwid/src/features/filter/data/remote/dtos/filter_item_response.dart';
import 'package:qwid/src/features/filter/data/remote/dtos/filter_size_response.dart';
import 'package:qwid/src/features/filter/data/remote/dtos/get_category_response.dart';
import 'package:qwid/src/features/filter/presentation/views/filter_screen.dart';
import 'package:qwid/src/features/filter/presentation/views/filter_sort_screen.dart';
import 'package:qwid/src/features/filter/presentation/views/detail_filter_sort_screen.dart';
import 'package:qwid/src/features/filter/presentation/views/filter_wrapper_screen.dart';
import 'package:qwid/src/features/filter/presentation/widgets/filter_brand.dart';
import 'package:qwid/src/features/filter/presentation/widgets/your_filter_size.dart';
import 'package:qwid/src/features/home/presentation/home_screen.dart';
import 'package:qwid/src/features/home/presentation/home_wrapper_screen.dart';
import 'package:qwid/src/features/item_detail/data/remote/dtos/listing_detail_response.dart';
import 'package:qwid/src/features/item_detail/data/remote/dtos/listing_detail_response.dart';
import 'package:qwid/src/features/item_detail/presentation/views/item_detail_screen.dart';
import 'package:qwid/src/features/item_detail/presentation/views/item_detail_wrapper_screen.dart';
import 'package:qwid/src/features/item_detail/presentation/widgets/preview_image.dart';
import 'package:qwid/src/features/payment/presentation/payment_screen.dart';
import 'package:qwid/src/features/payment/presentation/webview/payment_webview.dart';
import 'package:qwid/src/features/profile/presentation/views/drafts_screen.dart';
import 'package:qwid/src/features/payment/presentation/payment_wrapper_screen.dart';
import 'package:qwid/src/features/profile/presentation/views/seller_screen.dart';
import 'package:qwid/src/features/qwid_demo/home/add_funds.dart';
import 'package:qwid/src/features/qwid_demo/home/bank_transfer.dart';
import 'package:qwid/src/features/qwid_demo/home/beneficiaries_screen.dart';
import 'package:qwid/src/features/qwid_demo/home/convert_funds.dart';
import 'package:qwid/src/features/qwid_demo/home/currency_and_rate_screen.dart';
import 'package:qwid/src/features/qwid_demo/home/qwid_home_screen.dart';
import 'package:qwid/src/features/qwid_demo/profile/account_detail.dart';
import 'package:qwid/src/features/qwid_demo/profile/kyc/tier1/bank_verification_number_screen.dart';
import 'package:qwid/src/features/qwid_demo/profile/kyc/tier1/facial_verification_screen.dart';
import 'package:qwid/src/features/qwid_demo/profile/kyc/tier1/identity_verification_screen.dart';
import 'package:qwid/src/features/qwid_demo/profile/kyc/tier1/kyc_screen.dart';
import 'package:qwid/src/features/qwid_demo/profile/kyc/tier1/nation_identification_screen.dart';
import 'package:qwid/src/features/qwid_demo/profile/kyc/tier1/take_a_selfie_screen.dart';
import 'package:qwid/src/features/qwid_demo/profile/kyc/tier1/tier1_verification_screen.dart';
import 'package:qwid/src/features/qwid_demo/profile/kyc/tier1/user_information_screen.dart';
import 'package:qwid/src/features/qwid_demo/profile/kyc/tier2/document_upload_screen.dart';
import 'package:qwid/src/features/qwid_demo/profile/kyc/tier2/driver_license_screen.dart';
import 'package:qwid/src/features/qwid_demo/profile/kyc/tier2/international_passport_screen.dart';
import 'package:qwid/src/features/qwid_demo/profile/kyc/tier2/take_a_passport_picture_screen.dart';
import 'package:qwid/src/features/qwid_demo/profile/kyc/tier2/take_driver_license_picture_screen.dart';
import 'package:qwid/src/features/qwid_demo/profile/kyc/tier2/tier2_verification_screen.dart';
import 'package:qwid/src/features/qwid_demo/profile/kyc/tier3/proof_of_address_screen.dart';
import 'package:qwid/src/features/qwid_demo/profile/kyc/tier3/take_proof_of_address_picture_screen.dart';
import 'package:qwid/src/features/qwid_demo/profile/kyc/tier3/tier3_verification_screen.dart';
import 'package:qwid/src/features/qwid_demo/signup/business_account/business_basic_information.dart';
import 'package:qwid/src/features/qwid_demo/signup/business_account/company_information.dart';
import 'package:qwid/src/features/qwid_demo/signup/business_account/create_business_account_screen.dart';
import 'package:qwid/src/features/qwid_demo/signup/business_account/create_business_account_success.dart';
import 'package:qwid/src/features/qwid_demo/signup/business_account/create_password_screen.dart';
import 'package:qwid/src/features/qwid_demo/signup/personal_account/account_type_screen.dart';
import 'package:qwid/src/features/qwid_demo/signup/personal_account/account_verification.dart';
import 'package:qwid/src/features/qwid_demo/signup/personal_account/account_verification_by_phone.dart';
import 'package:qwid/src/features/qwid_demo/signup/personal_account/basic_information.dart';
import 'package:qwid/src/features/qwid_demo/signup/personal_account/confirm_pin.dart';
import 'package:qwid/src/features/qwid_demo/signup/personal_account/contact_information.dart';
import 'package:qwid/src/features/qwid_demo/signup/personal_account/create_personal_account_screen.dart';
import 'package:qwid/src/features/qwid_demo/signup/personal_account/login.dart';
import 'package:qwid/src/features/qwid_demo/signup/personal_account/onboarding_screen.dart';
import 'package:qwid/src/features/qwid_demo/signup/personal_account/personal_information.dart';
import 'package:qwid/src/features/qwid_demo/signup/personal_account/security_and_pin.dart';
import 'package:qwid/src/features/qwid_demo/signup/personal_account/security_question.dart';
import 'package:qwid/src/features/qwid_demo/signup/personal_account/setup_in_success.dart';
import 'package:qwid/src/features/qwid_demo/signup/personal_account/setup_pin.dart';
import 'package:qwid/src/features/qwid_demo/transaction_history/transaction_history_screen.dart';
import 'package:qwid/src/features/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qwid/src/core/di/injections.dart';
import 'package:qwid/src/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:qwid/src/features/authentication/presentation/views/forgot_password_screen.dart';
import 'package:qwid/src/features/authentication/presentation/views/register/register_screen.dart';
import 'package:qwid/src/features/banner/presentation/cubit/banner_cubit.dart';
import 'package:qwid/src/features/authentication/presentation/views/signin_screen.dart';
import 'package:qwid/src/features/profile/presentation/views/profile_screen.dart';
import 'package:qwid/src/features/profile/presentation/views/wallet_screen.dart';
import 'package:qwid/src/features/setting/presentation/views/setting_screen.dart';
import 'package:qwid/src/router/routes/guards/secure_guards.dart';
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
part 'routes/qwid_routes.dart';

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
          // AutoRoute(path: 'preview_image', page: PreviewImageScreenRoute.page),
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
