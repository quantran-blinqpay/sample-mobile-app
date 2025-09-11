part of '../router.dart';

final _qwidRoutes = [
  AutoRoute(path: 'onboarding_one', page: OnboardingScreenRoute.page),
  AutoRoute(path: 'account_type', page: AccountTypeScreenRoute.page),
  AutoRoute(path: 'create_personal_account', page: CreatePersonalAccountScreenRoute.page),
  AutoRoute(path: 'create_personal_account', page: BasicInformationScreenRoute.page),
  AutoRoute(path: 'account_verification', page: AccountVerificationScreenRoute.page),
  AutoRoute(path: 'personal_information', page: PersonalInformationScreenRoute.page),
  AutoRoute(path: 'contact_information', page: ContactInformationScreenRoute.page),
  AutoRoute(path: 'security_and_pin', page: SecurityAndPinScreenRoute.page),
  AutoRoute(path: 'setup_pin', page: SetupPinScreenRoute.page),
  AutoRoute(path: 'confirm_pin', page: ConfirmPinScreenRoute.page),
  AutoRoute(path: 'security_questions', page: SecurityQuestionsScreenRoute.page),
  AutoRoute(path: 'verification_by_phone', page: AccountVerificationByPhoneScreenRoute.page),
  AutoRoute(path: 'qwid_home', page: QwidHomeScreenRoute.page),
  AutoRoute(path: 'sign_in', page: LoginScreenRoute.page),
  AutoRoute(path: 'account_detail', page: AccountDetailScreenRoute.page),
];