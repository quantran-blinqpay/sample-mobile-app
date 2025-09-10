import 'package:auto_route/auto_route.dart';
import 'package:qwid/src/configs/app_themes/app_styles.dart';
import 'package:qwid/src/core/network/response/enum/progress_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qwid/src/components/button/app_button.dart';
import 'package:qwid/src/configs/app_themes/app_colors.dart';
import 'package:qwid/src/core/di/injections.dart';
import 'package:qwid/src/router/route_names.dart';
import '../../../../components/appbar/custom_app_bar.dart';
import '../../../../components/text_field/custom_text_field.dart';
import '../cubit/auth_cubit.dart';

// ignore_for_file: must_be_immutable
@RoutePage(name: forgotPasswordScreenName)
class ForgotPasswordScreen extends StatelessWidget implements AutoRouteWrapper {
  ForgotPasswordScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<AuthCubit>(create: ((context) => di<AuthCubit>()))
    ], child: this);
  }

  final _userNameController =
      TextEditingController(text: 'manhptit123@gmail.com');

  late BuildContext _currentContext;
  late AppColors? appColors;

  @override
  Widget build(BuildContext context) {
    _currentContext = context;
    appColors = Theme.of(context).extension<AppColors>();
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (prev, current) => prev.forgotPasswordStatus != current.forgotPasswordStatus,
      listener: (context, state) {
        /*if (state) {
          _showMessage(message: "Email invalid", context: context);
        } else */
        if (state.forgotPasswordStatus == ProgressStatus.success) {
          _showMessage(message: "Forgot password success", context: context);
        } else if (state.forgotPasswordStatus == ProgressStatus.failure) {
          _showMessage(message: state.errorMessage ?? '', context: context);
        }
      },
      child: _buildBodyWidget(context),
    );
  }

  Widget _buildBodyWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors!.forgotPasswordBackground,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                _buildBanner(),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextField(
                    controller: _userNameController,
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'Email hoặc số điện thoại',
                    hintStyle: AppStyles.of(context).copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColorss.borderColor),
                    enabledBorderColor: appColors!.forgotPasswordSeparateColor,
                    focusedBorderColor: appColors!.forgotPasswordFocusColor,
                    closeColor: appColors!.forgotPasswordBackground,
                  ),
                ),
                const SizedBox(height: 32),
                BlocBuilder<AuthCubit, AuthState>(
                  buildWhen: (prev, current) => prev.forgotPasswordStatus != current.forgotPasswordStatus,
                  builder: (context, state) {
                    final isLoading = state.forgotPasswordStatus == ProgressStatus.inProgress;
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: AppButton(
                        title: 'Tạo mật khẩu mới',
                        onPressed: isLoading ? null : _forgotPassword,
                        isLoading: isLoading,
                        backgroundColor: appColors!.forgotPasswordButtonColor,
                        textColor: appColors!.forgotPasswordTextButtonColor,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          CustomAppBar(
              title: "Quên mật khẩu",
              brightness: false,
              onPressed: () => _currentContext.router.pop()),
        ],
      ),
    );
  }

  Widget _buildBanner() {
    var statusBarHeight = MediaQuery.of(_currentContext).viewPadding.top;
    return Container(
      width: MediaQuery.of(_currentContext).size.width,
      height: statusBarHeight + 48,
      color: appColors!.forgotPasswordAppbar,
    );
  }

  void _forgotPassword() {
    final userName = _userNameController.text;
    bool validEmail = _currentContext.read<AuthCubit>().checkEmail(userName);
    if (validEmail) {
      _currentContext.read<AuthCubit>().forgotPassword(userName);
    }
  }

  void _showMessage({required String message, required BuildContext context}) {
    var snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
