part of '../router.dart';

final _authRoutes = [
  AutoRoute(path: 'register', page: RegisterScreenRoute.page),
  AutoRoute(path: 'forgot_password', page: ForgotPasswordScreenRoute.page),
  CustomRoute(
    page: SignInScreenRoute.page,
    path: 'sign-in',
    transitionsBuilder: TransitionsBuilders.slideBottom,
    duration: Duration(milliseconds: 300),
  ),
  AutoRoute(path: 'onboarding_one', page: OnboardingOneScreenRoute.page),
  AutoRoute(path: 'account_type', page: AccountTypeScreenRoute.page),
  AutoRoute(path: 'create_personal_account', page: CreatePersonalAccountScreenRoute.page),
  AutoRoute(path: 'create_personal_account', page: BasicInformationScreenRoute.page),
  AutoRoute(path: 'account_verification_screen', page: AccountVerificationScreenRoute.page),

];

@RoutePage(name: 'AuthWrapperPageRoute')
class AuthWrapperPage extends StatelessWidget {
  const AuthWrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<AuthCubit>(
          create: ((context) => di<AuthCubit>()..initData()))
    ], child: const AutoRouter());
  }
}
