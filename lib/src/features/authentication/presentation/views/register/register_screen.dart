// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:designerwardrobe/gen/assets.gen.dart';
import 'package:designerwardrobe/src/components/appbar/custom_app_bar.dart';
import 'package:designerwardrobe/src/components/bottom_sheet/bottom_sheet.dart';
import 'package:designerwardrobe/src/components/date_picker/month_picker.dart';
import 'package:designerwardrobe/src/components/scaffold/app_scaffold.dart';
import 'package:designerwardrobe/src/components/switch/custom_switch.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_themes.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_styles.dart';
import 'package:designerwardrobe/src/core/constants/app_constants.dart';
import 'package:designerwardrobe/src/core/constants/filter_class.dart';
import 'package:designerwardrobe/src/core/network/response/enum/progress_status.dart';
import 'package:designerwardrobe/src/features/authentication/data/remote/dtos/register/category/generic_size.dart';
import 'package:designerwardrobe/src/features/authentication/data/remote/dtos/register/parameter/batch_update_frequency_parameter.dart';
import 'package:designerwardrobe/src/features/authentication/domain/repositories/register_repository.dart';
import 'package:designerwardrobe/src/features/authentication/presentation/cubit/register_cubit.dart';
import 'package:designerwardrobe/src/features/authentication/presentation/widgets/closest_town_bottom_sheet.dart';
import 'package:designerwardrobe/src/features/authentication/presentation/widgets/country_bottom_sheet.dart';
import 'package:designerwardrobe/src/features/authentication/presentation/widgets/notification_preferences_bottom_sheet.dart';
import 'package:designerwardrobe/src/features/home/domain/repositories/home_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:designerwardrobe/src/components/button/app_button.dart';
import 'package:designerwardrobe/src/core/di/injections.dart';
import 'package:designerwardrobe/src/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:designerwardrobe/src/router/route_names.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../../../components/text_field/custom_text_field.dart';
import '../../../../../configs/app_themes/app_colors.dart';

part 'step_one.dart';
part 'step_two.dart';
part 'step_three.dart';
part 'step_four.dart';

@RoutePage(name: registerScreenName)
class RegisterScreen extends StatefulWidget implements AutoRouteWrapper {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<AuthCubit>(create: ((context) => di<AuthCubit>())),
      BlocProvider<RegisterCubit>(create: ((context) => RegisterCubit(
          di<RegisterRepository>(), di<HomeRepository>())
        ..initSizes()
        ..loadCountries()
        ..loadAllSiteSettings()
        ..loadStartupCategories()))
    ], child: this);
  }
}

class _RegisterScreenState extends State<RegisterScreen> {
  late BuildContext _currentContext;
  final _firstNameController = TextEditingController(text: '');
  final _lastNameController = TextEditingController(text: '');
  final _emailController = TextEditingController(text: '');
  final _userNameController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');
  final _birthdayController = TextEditingController(text: '');
  final _countryController = TextEditingController(text: '');
  final _cityController = TextEditingController(text: '');
  final _codeController = TextEditingController(text: '');
  final _referralCodeController = TextEditingController(text: '');
  final _phoneController = TextEditingController(text: '');
  final _searchController = TextEditingController(text: '');
  late AppColors? appColors;
  late final PageController pageController;
  double currentPage = 1.0;
  bool isDone = false;
  // 1. Define the GlobalKey
  final GlobalKey<StepTwoState> _stepTwoKey = GlobalKey<StepTwoState>();

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _currentContext = context;
    appColors = Theme.of(context).extension<AppColors>();
    return MultiBlocListener(listeners: [
      BlocListener<AuthCubit, AuthState>(
        listenWhen: (prev, current) => prev.registerStatus != current.registerStatus,
        listener: (context, state) {
          if (state.registerStatus == ProgressStatus.success) {
            _showMessage(message: "Register success", context: context);
          } else if (state.registerStatus == ProgressStatus.failure) {
            _showMessage(message: "Register fail", context: context);
          }
        },
      ),
      BlocListener<RegisterCubit, RegisterState>(
        listenWhen: (prev, current) => prev.userValidationStatus != current.userValidationStatus,
        listener: (context, state) {
          if (state.userValidationStatus == ProgressStatus.success) {
            _onNext();
          } else if (state.userValidationStatus == ProgressStatus.failure) {
            _showMessage(message: state.errorMessage.toString(), context: context);
          }
        },
      ),
      BlocListener<RegisterCubit, RegisterState>(
        listenWhen: (prev, current) => prev.sendingCodeStatus != current.sendingCodeStatus,
        listener: (context, state) {
          if (state.sendingCodeStatus == ProgressStatus.success) {
            _stepTwoKey.currentState?.swipeToEnterCode();
            _showMessage(message: 'Your OTP has been sent successfully!', context: context);
          } else if (state.sendingCodeStatus == ProgressStatus.failure) {
            _showMessage(message: state.errorMessage.toString(), context: context);
          }
        },
      ),
      BlocListener<AuthCubit, AuthState>(
        listenWhen: (prev, current) => prev.signInStatus != current.signInStatus,
        listener: (context, state) {
          if (state.signInStatus == ProgressStatus.success) {
            FocusManager.instance.primaryFocus?.unfocus();
            _onNext();
          } else if (state.signInStatus == ProgressStatus.failure) {
            _showMessage(message: state.errorMessage.toString(), context: context);
            // TODO: fake code
            // FocusManager.instance.primaryFocus?.unfocus();
            // _onNext();
          }
        },
      ),
      BlocListener<RegisterCubit, RegisterState>(
        listenWhen: (prev, current) =>
          prev.batchUpdateFrequencyStatus != current.batchUpdateFrequencyStatus,
        listener: (context, state) {
          if (state.batchUpdateFrequencyStatus == ProgressStatus.success) {
            _showMessage(message: 'Your notification preferences have been successfully updated!', context: context);
            FocusManager.instance.primaryFocus?.unfocus();
            _onNext();
          } else if (state.batchUpdateFrequencyStatus == ProgressStatus.failure) {
            _showMessage(message: state.errorMessage.toString(), context: context);
            // TODO: fake code
            // _onNext();
          }
        },
      ),
      BlocListener<RegisterCubit, RegisterState>(
        listenWhen: (prev, current) => prev.sizeSynchronizationStatus != current.sendingCodeStatus,
        listener: (context, state) {
          if (state.sizeSynchronizationStatus == ProgressStatus.success) {
            _showMessage(message: 'Your registration has been done. Welcome to our app!', context: context);
            context.router.pop();
          } else if (state.sizeSynchronizationStatus == ProgressStatus.failure) {
            _showMessage(message: state.errorMessage.toString(), context: context);
          }
        },
      ),
    ], child: BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return AppScaffold(
          isLoading: state.userValidationStatus == ProgressStatus.inProgress,
          backgroundColor: appColors!.lavender,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            toolbarHeight: 48,
            backgroundColor: Colors.white,
            leading: IconButton(
              padding: EdgeInsets.all(5),
              icon: SvgPicture.asset(
                currentPage == 1 ? Assets.svgs.icClose : Assets.svgs.icArrowBack,
                width: currentPage == 1 ? null : 18,
                height: currentPage == 1 ? null : 18,
              ),
              onPressed: _onBack,
            ),
            title: Center(
              child: Text(
                currentPage < 3 ? "SIGN UP" : 'GET STARTED',
                style: AppStyles.of(context).copyWith(
                  color: Colors.black,
                  fontSize: 14,
                  height: 13 / 14,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            actions: [
              if (currentPage == 3)
                TextButton(
                  onPressed: () {
                    _onNext();
                  },
                  child: Text(
                    'Skip',
                    style: AppStyles.of(context).copyWith(
                      color: appColors!.outerSpace,
                      fontSize: 13,
                    ),
                  ),
                )
                else if (currentPage == 4)
                TextButton(
                  onPressed: () {
                    _currentContext.router.pop();
                  },
                  child: Text(
                    'Skip',
                    style: AppStyles.of(context).copyWith(
                      color: appColors!.outerSpace,
                      fontSize: 13,
                    ),
                  ),
                )
              else IgnorePointer(
                ignoring: true,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    '',
                    style: AppStyles.of(context).copyWith(
                      color: appColors!.outerSpace,
                      fontSize: 13,
                    ),
                  ),
                ),
              )
            ],
          ),
          body: _buildRegisterWidget(),
        );
      },
    ));

  }

  String handleTitleBottomButton() {
    if (currentPage == 2) {
      return 'Send Code';
    }
    if (currentPage == 3) {
      return 'Save Brands';
    }

    if (isDone) {
      return 'Get Started';
    }

    return 'Save Sizes';
  }

  void handleOnPressedBottomButton() {
    // if (currentPage == 2) {
    //   return _onSend();
    // }
    // if (currentPage == 3) {
    //   return _onSaveBrands();
    // }
    // return _onSaveSizes();
  }

  Widget _buildRegisterWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBanner(),
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 10, 40, 12),
          child: Row(
            children: [
              Expanded(
                child: LinearPercentIndicator(
                  lineHeight: 6.0,
                  padding: EdgeInsets.zero,
                  percent: currentPage / 4,
                  animation: true,
                  animateFromLastPercent: true,
                  alignment: MainAxisAlignment.center,
                  backgroundColor: Colors.white,
                  progressColor: appColors!.vividBlue,
                  barRadius: const Radius.circular(8),
                ),
              ),
              SizedBox(width: 21),
              Text(
                "${currentPage.toInt()}/4",
                style: AppStyles.of(context).copyWith(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              StepOne(
                parentContext: _currentContext,
                appColors: appColors!,
                firstNameController: _firstNameController,
                lastNameController: _lastNameController,
                emailController: _emailController,
                userNameController: _userNameController,
                passwordController: _passwordController,
                birthdayController: _birthdayController,
                countryController: _countryController,
                referralCodeController: _referralCodeController,
                cityController: _cityController,
                codeController: _codeController,
              ),
              StepTwo(
                appColors: appColors!,
                phoneController: _phoneController,
                codeController: _codeController,
                key: _stepTwoKey,
              ),
              BlocBuilder<RegisterCubit, RegisterState>(
                builder: (context, state) {
                  return StepThree(
                    appColors: appColors!,
                    searchController: _searchController,
                    brandTags: state.country?.countryName == null
                        ? []
                        : state.country?.countryName == 'New Zealand'
                          ? state.localNZBrands ?? []
                          : state.localAuBrands ?? [],
                  );
                },
              ),
              BlocBuilder<RegisterCubit, RegisterState>(
                builder: (context, state) {
                  return StepFour(
                    usualSizes: state.usualSizes,
                    waistSizes: state.waistSizes,
                    shoeSizes: state.shoeSizes,
                  );
                },
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBanner() {
    var statusBarHeight = MediaQuery.of(_currentContext).viewPadding.top;
    return Container(
      width: MediaQuery.of(_currentContext).size.width,
      height: statusBarHeight + 48,
      color: Colors.white,
    );
  }

  void _onBack() {
    if (currentPage == 1.0) {
      _currentContext.router.maybePop();
    } else {
      pageController
          .previousPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeIn,
      )
          .then(
        (value) {
          setState(() {
            currentPage = (pageController.page ?? 0.0) + 1;
          });
        },
      );
    }
  }

  void _onNext() {
    pageController
        .nextPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeIn,
    )
        .then(
      (value) {
        setState(() {
          currentPage = (pageController.page ?? 0.0) + 1;
        });
      },
    );
  }

  void _showMessage({required String message, required BuildContext context}) {
    var snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
