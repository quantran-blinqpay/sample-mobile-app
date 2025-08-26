// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:designerwardrobe/src/components/scaffold/app_scaffold.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_colors.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_styles.dart';
import 'package:designerwardrobe/src/core/network/response/enum/progress_status.dart';
import 'package:designerwardrobe/gen/assets.gen.dart';
import 'package:designerwardrobe/src/components/checkbox/custom_checkbox.dart';
import 'package:flutter/foundation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:designerwardrobe/src/components/button/app_button.dart';
import 'package:designerwardrobe/src/router/router.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../components/appbar/custom_app_bar.dart';
import '../../../../components/text_field/custom_text_field.dart';
import '../../../../router/route_names.dart';
import '../cubit/auth_cubit.dart';

@RoutePage(name: signInScreenRoute)
class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final _usernameController =
      TextEditingController(text: kDebugMode ? 'dmquang321+1@gmail.com' : '');
  final _passwordController =
      TextEditingController(text: kDebugMode ? 'Test123!' : '');

  late BuildContext _currentContext;
  late AppColors? appColors;

  @override
  Widget build(BuildContext context) {
    _currentContext = context;
    appColors = Theme.of(context).extension<AppColors>();
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (prev, current) => prev.signInStatus != current.signInStatus,
      listener: (context, state) {
        if (state.signInStatus == ProgressStatus.failure) {
          _showMessage(message: 'Login fail', context: context);
        } else if (state.signInStatus == ProgressStatus.success) {
          _currentContext.router.maybePop();
        }
        // else if (state is GetTokenSuccess) {
        //   if (state.token.isNotEmpty) {
        //     _showMessage(message: state.token, context: context);
        //   }
        // } else if (state is UserNameInvalid) {
        //   _showMessage(message: "User name invalid", context: context);
        // } else if (state is PasswordInvalid) {
        //   _showMessage(message: "Password invalid", context: context);
        // }
      },
      child: _buildBodyWidget(),
    );
  }

  Widget buildSignInWidget() {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return AppScaffold(
          isBackBtnVisible: false,
          isLoading: state.signInStatus == ProgressStatus.inProgress,
          body: Column(
            children: [
              _buildBanner(),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, anim) =>
                        FadeTransition(opacity: anim, child: child),
                    child: state.signInStatus == ProgressStatus.failure
                        ? Container(
                            key: const ValueKey('error'),
                            margin: EdgeInsets.fromLTRB(16, 20, 16, 0),
                            padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 24,
                                  backgroundColor: appColors!.cherryRed,
                                  child: SvgPicture.asset(Assets.svgs.icInfo),
                                ),
                                SizedBox(width: 16),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Invalid email or password',
                                        style: AppStyles.of(context).copyWith(
                                          fontSize: 12.6,
                                          fontWeight: FontWeight.w600,
                                          color: appColors!.outerSpace,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ', please try again.',
                                        style: AppStyles.of(context).copyWith(
                                          fontSize: 12.6,
                                          fontWeight: FontWeight.w400,
                                          color: appColors!.outerSpace,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(key: ValueKey('empty')),
                  );
                },
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(16, 21, 16, 32),
                    padding: const EdgeInsets.fromLTRB(0, 32, 0, 32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'sign_in.log_in'.tr(),
                          style: AppStyles.of(context).copyWith(
                            fontSize: 24,
                            height: 31 / 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 21),
                          child: CustomTextField(
                            controller: _usernameController,
                            keyboardType: TextInputType.emailAddress,
                            hintText: 'sign_in.email'.tr(),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 21),
                          child: CustomTextField(
                            controller: _passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            hintText: 'sign_in.password'.tr(),
                          ),
                        ),
                        const SizedBox(height: 21),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: BlocBuilder<AuthCubit, AuthState>(
                                        builder: (context, state) {
                                          return CustomCheckbox(
                                            value: state.rememberMe ?? false,
                                            onChanged: (value) {
                                              _currentContext
                                                  .read<AuthCubit>()
                                                  .toggleRememberMe(value!);
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    Text(
                                      'sign_in.remember_me'.tr(),
                                      style: AppStyles.of(context).copyWith(
                                        fontSize: 14,
                                        height: 18 / 14,
                                        fontWeight: FontWeight.w400,
                                        color: appColors!.mediumGray,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: () => {
                                  _currentContext
                                      .pushRoute(ForgotPasswordScreenRoute())
                                },
                                child: Text(
                                  'sign_in.forgot_password'.tr(),
                                  style: AppStyles.of(context).copyWith(
                                    fontSize: 14,
                                    height: 18 / 14,
                                    fontWeight: FontWeight.w400,
                                    color: appColors!.mediumGray,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(21, 21, 21, 0),
                          child: AppButton(
                            title: 'sign_in.log_in'.tr(),
                            onPressed: _signIn,
                            backgroundColor: appColors!.signInButtonColor,
                            textColor: appColors!.signInTextButtonColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 21),
                          child: Text(
                            'sign_in.or_sign_in_with'.tr(),
                            style: AppStyles.of(context).copyWith(
                              fontSize: 14,
                              height: 18 / 14,
                              fontWeight: FontWeight.w400,
                              color: appColors!.mediumGray,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(21, 0, 21, 32),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildSocialButton(
                                context,
                                () {},
                                SvgPicture.asset(
                                  Assets.svgs.icGoogle,
                                  width: 18,
                                  height: 18,
                                ),
                                'sign_in.google'.tr(),
                              ),
                              SizedBox(width: 7.2),
                              _buildSocialButton(
                                context,
                                () {},
                                SvgPicture.asset(
                                  Assets.svgs.icFacebook,
                                  width: 18,
                                  height: 18,
                                ),
                                'sign_in.facebook'.tr(),
                              ),
                              if (Platform.isIOS) ...[
                                SizedBox(width: 7.2),
                                _buildSocialButton(
                                  context,
                                  () {},
                                  Icon(
                                    Icons.apple,
                                    color: Colors.black,
                                    size: 24,
                                  ),
                                  'sign_in.apple'.tr(),
                                  isApple: true,
                                ),
                              ],
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 21),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      '${'sign_in.dont_have_an_account_yet'.tr()} ',
                                  style: AppStyles.of(context).copyWith(
                                    fontSize: 14,
                                    height: 18 / 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      _currentContext
                                          .pushRoute(RegisterScreenRoute());
                                    },
                                  text: 'sign_in.sign_up'.tr(),
                                  style: AppStyles.of(context).copyWith(
                                    fontSize: 14,
                                    height: 18 / 14,
                                    fontWeight: FontWeight.w600,
                                    color: appColors!.signInButtonColor,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  ElevatedAppButton _buildSocialButton(
    BuildContext context,
    Function()? onPressed,
    Widget icon,
    String title, {
    bool isApple = false,
  }) {
    return ElevatedAppButton(
      onPressed: onPressed,
      bgColor: Colors.white,
      padding: EdgeInsets.zero,
      radius: 27,
      child: Container(
        padding: EdgeInsets.all(isApple ? 13 : 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(27),
          border: Border.all(color: appColors!.lightGray),
        ),
        child: Row(
          children: [
            icon,
            SizedBox(width: 8),
            Text(
              title,
              style: AppStyles.of(context).copyWith(
                fontSize: 12.6,
                fontWeight: FontWeight.w500,
                color: appColors!.darkSlateBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return Scaffold(
      backgroundColor: appColors!.lavender,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(48),
        child: CustomAppBar(
          title: 'sign_in.log_in'.tr(),
          brightness: false,
          useCloseIcon: true,
          onPressed: () => _currentContext.router.maybePop(),
        ),
      ),
      body: buildSignInWidget(),
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

  void _signIn() {
    FocusManager.instance.primaryFocus?.unfocus();
    final username = _usernameController.text;
    final password = _passwordController.text;
    // bool validUser = _currentContext.read<AuthCubit>().checkUserName(username);
    // bool validPassword =
    //     _currentContext.read<AuthCubit>().checkPassword(password);
    // if (validUser && validPassword) {
    _currentContext.read<AuthCubit>().signIn(username, password);
    // }
  }

  void _showMessage({required String message, required BuildContext context}) {
    var snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
