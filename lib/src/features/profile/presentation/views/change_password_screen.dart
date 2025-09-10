import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qwid/src/components/button/app_button.dart';
import 'package:qwid/src/core/di/injections.dart';
import 'package:qwid/src/router/route_names.dart';
import '../../../../components/appbar/custom_app_bar.dart';
import '../../../../components/text_field/custom_text_field.dart';
import '../../../../configs/app_themes/app_colors.dart';
import '../cubit/change_password/change_password_cubit.dart';

@RoutePage(name: changePasswordScreenName)
class ChangePasswordScreen extends StatelessWidget implements AutoRouteWrapper {
  ChangePasswordScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<ChangePasswordCubit>(
          create: ((context) => di<ChangePasswordCubit>()))
    ], child: this);
  }

  late BuildContext _currentContext;
  final _passwordController = TextEditingController(text: '');
  final _newPasswordController = TextEditingController(text: '');
  final _repeatPasswordController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    _currentContext = context;
    return Scaffold(
      backgroundColor: AppColorss.brown,
      body: Stack(
        children: [
          _buildRegisterWidget(),
          CustomAppBar(
              brightness: false,
              title: "Đổi mật khẩu",
              onPressed: () => _currentContext.router.pop()),
        ],
      ),
    );
  }

  Widget _buildRegisterWidget() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBanner(),
          const SizedBox(height: 36),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildDescription()),
          const SizedBox(height: 12),
          Container(height: 12, color: Colors.white),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            color: Colors.white,
            child: CustomTextField(
              controller: _passwordController,
              keyboardType: TextInputType.emailAddress,
              hintText: 'Mật khẩu hiện tại',
              obscureText: true,
              hintStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColorss.borderColor),
            ),
          ),
          Container(height: 12, color: Colors.white),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            color: Colors.white,
            child: CustomTextField(
              controller: _newPasswordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              hintText: 'Mật khẩu mới',
              hintStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColorss.borderColor),
            ),
          ),
          Container(height: 12, color: Colors.white),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            color: Colors.white,
            child: CustomTextField(
              controller: _repeatPasswordController,
              keyboardType: TextInputType.emailAddress,
              hintText: 'Nhập lại mật khẩu mới',
              obscureText: true,
              hintStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColorss.borderColor),
            ),
          ),
          const SizedBox(height: 32),
          BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
            listener: (context, state) {
              if (state is ChangePasswordSuccess) {
                _currentContext.router.pop();
                _showMessage(
                    message: "Đổi mật khẩu thành công", context: context);
              } else if (state is ChangePasswordFail) {
                _showMessage(message: state.message, context: context);
              } else if (state is PasswordInvalid) {
                print("password invalid");
              } else if (state is NewPasswordInvalid) {
                print("new password invalid");
              } else if (state is RepeatPasswordInvalid) {
                print("repeat password invalid");
              }
            },
            builder: (context, state) {
              final isLoading = state is ChangePasswordLoading;
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AppCrimsonButton(
                  title: 'Đổi mật khẩu',
                  onPressed: isLoading ? null : _changePassword,
                  isLoading: isLoading,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBanner() {
    var statusBarHeight = MediaQuery.of(_currentContext).viewPadding.top;
    return Container(
      width: MediaQuery.of(_currentContext).size.width,
      height: statusBarHeight + 48,
      color: AppColorss.crimson,
    );
  }

  Widget _buildDescription() {
    return const Text(
      "Mật khẩu đăng nhập",
      style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: AppColorss.darkBrown),
    );
  }

  void _changePassword() {
    final password = _passwordController.text;
    final newPassword = _newPasswordController.text;
    final repeatPassword = _repeatPasswordController.text;

    bool validPassword =
        _currentContext.read<ChangePasswordCubit>().checkPassword(password);
    bool validNewPassword = _currentContext
        .read<ChangePasswordCubit>()
        .checkNewPassword(password: password, newPassword: newPassword);
    bool validRepeatPassword = _currentContext
        .read<ChangePasswordCubit>()
        .checkRepeatPassword(
            newPassword: newPassword, repeatPassword: repeatPassword);

    if (validPassword && validNewPassword && validRepeatPassword) {
      _currentContext
          .read<ChangePasswordCubit>()
          .changePassword(password: password, newPassword: newPassword);
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
