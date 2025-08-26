part of '../register/register_screen.dart';

class StepTwo extends StatefulWidget {
  final AppColors appColors;

  final TextEditingController phoneController;
  final TextEditingController codeController;

  const StepTwo({
    required this.appColors,
    required this.phoneController,
    required this.codeController,
    super.key,
  });

  @override
  State<StepTwo> createState() => StepTwoState();
}

class StepTwoState extends State<StepTwo> {
  bool _shouldEnterCode = false;

  void swipeToEnterCode(){
    setState(() {
      _shouldEnterCode = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return !_shouldEnterCode
        ? _buildEnterPhone(context)
        : _buildEnterCode(context);
  }

  Widget _buildResendWidget(BuildContext context){
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text:
              'Didn\'t get the code? ',
              style: AppStyles.of(context).copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: widget.appColors.outerSpace,
              ),
            ),
            TextSpan(
              recognizer: TapGestureRecognizer()..onTap = () {
                FocusManager.instance.primaryFocus?.unfocus();
                context.read<RegisterCubit>().sendCode();
              },
              text: 'Resend',
              style: AppStyles.of(context).copyWith(
                fontSize: 14,
                color: widget.appColors.vividBlue,
                decoration: TextDecoration.underline,
              ),
            ),
            TextSpan(
              text: '.',
              style: AppStyles.of(context).copyWith(
                fontSize: 11,
                color: widget.appColors.outerSpace,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEnterPhone(BuildContext context){
    final appColors = Theme.of(context).extension<AppColors>()!;
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return AppScaffold(
            isLoading: state.sendingCodeStatus == ProgressStatus.inProgress,
            backgroundColor: widget.appColors.lavender,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 12),
                  /**
                   * Nếu country là NZ thì đầu số là ['20', '21', '22', '27', '28', '29']. Cho phép nhập số 0 ở trước. Ví dụ 020 hay 20 là đều được.
                   * Nếu country là AU thì đầu số là ['4', '5']. Cho phép nhập số 0 ở trước. Ví dụ 04 hay 4 là đều được.
                   * Sau mã quốc gia thì có từ 6 đến 8 số. */
                  Text(
                    "Enter your mobile",
                    style: AppStyles.of(context).copyWith(
                      fontSize: 24,
                      height: 31 / 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "We’ll send you a one-time verification code\nto keep your account secure",
                    style: AppStyles.of(context).copyWith(
                      fontSize: 14,
                      height: 18 / 14,
                      fontWeight: FontWeight.w400,
                      color: widget.appColors.outerSpace,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                              ),
                              child: BlocBuilder<RegisterCubit, RegisterState>(
                                builder: (context, state) {
                                  return Row(
                                    children: [
                                      Text(
                                        state.country?.phoneCode ?? '',
                                        style: AppStyles.of(context).copyWith(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(width: 22),
                                      Text(
                                        state.country?.flag ?? '',
                                        style: AppStyles.of(context).copyWith(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            SizedBox(width: 11),
                            Expanded(
                              child: CustomTextFormField(
                                controller: widget.phoneController,
                                keyboardType: TextInputType.phone,
                                hintText: 'Enter phone number',
                                onChanged: (phone) {
                                  context.read<RegisterCubit>().updatePhone(phone);
                                  context.read<RegisterCubit>().validatePhone(phone);
                                },
                              ),
                            ),
                          ],
                        ),
                        BlocBuilder<RegisterCubit, RegisterState>(
                          builder: (context, state) {
                            if(state.phoneValidationStatus == ProgressStatus.inProgress){
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  'Checking ...',
                                  style: AppStyles.of(context)
                                      .copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: widget.appColors.black),
                                ),
                              );
                            }

                            final phoneRegex = RegExp(r'^\+(64|61)\d{8,9}$');

                            // null -> don't show anything
                            if (state.phone == null) {
                              return SizedBox.shrink();
                            }

                            // empty -> show "Required"
                            if (state.phone?.isEmpty ?? true) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  'Required',
                                  style: AppStyles.of(context)
                                      .copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: widget.appColors.red),
                                ),
                              );
                            }

                            final phoneNumber = '${state.phoneCode}${state.phone}';
                            // not match regex -> 'The otp field must be numeric and may contain decimal points'
                            if (!phoneRegex.hasMatch(phoneNumber)) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  'The phone field must be numeric and may contain decimal points',
                                  style: AppStyles.of(context)
                                      .copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: widget.appColors.red),
                                ),
                              );
                            }

                            // chech with server -> invalid
                            if (state.isPhoneValid == false) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  'The phone has already been taken',
                                  style: AppStyles.of(context)
                                      .copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: widget.appColors.red),
                                ),
                              );
                            }

                            return SizedBox.shrink();
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              padding: const EdgeInsets.symmetric(horizontal: 37, vertical: 30),
              child: BlocBuilder<RegisterCubit, RegisterState>(
                builder: (context, state) {
                  final isActivated = (state.phone?.isNotEmpty ?? false) && (state.isPhoneValid ?? false);
                  return AppButton(
                    title: 'Send Code',
                    onPressed: !isActivated ? null : () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      context.read<RegisterCubit>().sendCode();
                    },
                    backgroundColor: isActivated 
                        ? appColors.registerButtonColor
                        : appColors.registerUnactivatedButtonColor,
                    textColor: appColors.registerTextButtonColor,
                  );
                },
              ),
            )
        );
      },
    );
  }

  Widget _buildEnterCode(BuildContext context){
    final appColors = Theme.of(context).extension<AppColors>()!;
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return AppScaffold(
            isLoading: state.signInStatus == ProgressStatus.inProgress,
            backgroundColor: widget.appColors.lavender,
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BlocBuilder<RegisterCubit, RegisterState>(
                    builder: (context, state) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 12),
                            Text(
                              "Enter your code",
                              style: AppStyles.of(context).copyWith(
                                fontSize: 24,
                                height: 31 / 24,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              "We've sent an SMS code to ${state.phoneCode}${state.phone}",
                              style: AppStyles.of(context).copyWith(
                                fontSize: 14,
                                height: 18 / 14,
                                fontWeight: FontWeight.w400,
                                color: widget.appColors.outerSpace,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextFormField(
                                    controller: widget.codeController,
                                    keyboardType: TextInputType.phone,
                                    hintText: 'Enter verification code',
                                    onChanged: (otp) {
                                      context.read<RegisterCubit>().updateOTP(otp);
                                      context.read<RegisterCubit>().validatePhone(otp);
                                    },
                                  ),
                                  BlocBuilder<RegisterCubit, RegisterState>(
                                    builder: (context, state) {
                                      if(state.codeValidationStatus == ProgressStatus.inProgress){
                                        return Padding(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            'Checking ...',
                                            style: AppStyles.of(context)
                                                .copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: widget.appColors.black),
                                          ),
                                        );
                                      }

                                      final codeRegex = RegExp(AppConstants.codeRegex);;

                                      // null -> don't show anything
                                      if (state.otp == null) {
                                        return SizedBox.shrink();
                                      }

                                      // empty -> show "Required"
                                      if (state.otp?.isEmpty ?? true) {
                                        return Padding(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            'Required',
                                            style: AppStyles.of(context)
                                                .copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: widget.appColors.red),
                                          ),
                                        );
                                      }

                                      // not match regex -> 'The otp field must be numeric and may contain decimal points'
                                      if (!codeRegex.hasMatch(state.otp ?? '')) {
                                        return Padding(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            'The otp field must be numeric and may contain decimal points',
                                            style: AppStyles.of(context)
                                                .copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: widget.appColors.red),
                                          ),
                                        );
                                      }

                                      // check with server -> invalid
                                      if (state.isOTPValid == false) {
                                        return Padding(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            'This code is invalid',
                                            style: AppStyles.of(context)
                                                .copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: widget.appColors.red),
                                          ),
                                        );
                                      }

                                      return SizedBox.shrink();
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 32),
                          ],
                        ),
                      );
                    },
                  ),
                  _buildResendWidget(context),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              padding: const EdgeInsets.symmetric(horizontal: 37, vertical: 30),
              child: BlocBuilder<RegisterCubit, RegisterState>(
                builder: (context, state) {
                  final isActivated = (state.otp?.isNotEmpty ?? false);
                  return AppButton(
                    title: 'Submit',
                    onPressed: !isActivated ? null : () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      context.read<AuthCubit>().verifyCode(
                        phone: '${state.phoneCode}${state.phone}',
                        otp: state.otp ?? '',
                        email: state.email ?? '',
                        firstName: state.firstName ?? '',
                        lastName: state.lastName ?? '',
                        username: state.username ?? '',
                        password: state.password ?? '',
                        gender: state.gender ?? 'female',
                        month: state.month,
                        year: state.year,
                        country: state.country?.countryName ?? '',
                        referralCode: state.referralCode,
                        referredFrom: state.referredFrom,
                        city: state.city ?? '',
                        terms: 1,
                      );
                    },
                    backgroundColor: isActivated
                        ? appColors.registerButtonColor
                        : appColors.registerUnactivatedButtonColor,
                    textColor: appColors.registerTextButtonColor,
                  );
                },
              ),
            )
        );
      },
    );
  }
}
