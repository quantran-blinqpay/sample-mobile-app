part of '../register/register_screen.dart';

class StepOne extends StatelessWidget {
  final BuildContext parentContext;
  final AppColors appColors;

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController userNameController;
  final TextEditingController passwordController;
  final TextEditingController birthdayController;
  final TextEditingController countryController;
  final TextEditingController cityController;
  final TextEditingController referralCodeController;
  final TextEditingController codeController;

  const StepOne({
    required this.parentContext,
    required this.appColors,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.userNameController,
    required this.passwordController,
    required this.birthdayController,
    required this.countryController,
    required this.cityController,
    required this.referralCodeController,
    required this.codeController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 12),
          Text(
            "Create your profile",
            style: AppStyles.of(context).copyWith(
              fontSize: 24,
              height: 31 / 24,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
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
                  "Google",
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
                  "Facebook",
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
                    "Apple",
                    isApple: true,
                  ),
                ],
              ],
            ),
          ),
          Text(
            "or sign up with your email",
            style: AppStyles.of(context).copyWith(
              fontSize: 14,
              height: 18 / 14,
              fontWeight: FontWeight.w400,
              color: appColors.outerSpace,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 18, 12, 0),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    controller: firstNameController,
                    keyboardType: TextInputType.name,
                    hintText: 'First name',
                    onChanged: (text) {
                      context.read<RegisterCubit>().updateFirstName(text);
                    },
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: CustomTextFormField(
                    controller: lastNameController,
                    keyboardType: TextInputType.name,
                    hintText: 'Last name',
                    onChanged: (text) {
                      context.read<RegisterCubit>().updateLastName(text);
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Email',
                  onChanged: (text) {
                    context.read<RegisterCubit>().updateEmail(text);
                    final emailRegex = RegExp(AppConstants.emailRegex);
                    if (emailRegex.hasMatch(text)) {
                      context.read<RegisterCubit>().validateEmail(text);
                    }
                  },
                ),
                BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (context, state) {
                    if (state.emailValidationStatus ==
                        ProgressStatus.inProgress) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Checking ...',
                          style: AppStyles.of(context).copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: appColors.black),
                        ),
                      );
                    }

                    final emailRegex = RegExp(AppConstants.emailRegex);

                    // null -> don't show anything
                    if (state.email == null) {
                      return SizedBox.shrink();
                    }

                    // empty -> show "Required"
                    if (state.email?.isEmpty ?? true) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Required',
                          style: AppStyles.of(context).copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: appColors.red),
                        ),
                      );
                    }

                    // not match regex -> 'The email must be a valid email address'
                    if (!emailRegex.hasMatch(state.email ?? '')) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'The email must be a valid email address',
                          style: AppStyles.of(context).copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: appColors.red),
                        ),
                      );
                    }

                    // chech with server -> invalid
                    if (state.isEmailValid == false) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'The email has already been taken',
                          style: AppStyles.of(context).copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: appColors.red),
                        ),
                      );
                    }

                    return SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFormField(
                  controller: userNameController,
                  keyboardType: TextInputType.name,
                  hintText: 'Username',
                  onChanged: (text) {
                    context.read<RegisterCubit>().updateUsername(text);
                    final usernameRegex = RegExp(AppConstants.userNameRegex);
                    if (usernameRegex.hasMatch(text)) {
                      context.read<RegisterCubit>().validateUsername(text);
                    }
                  },
                ),
                BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (context, state) {
                    if (state.usernameValidationStatus ==
                        ProgressStatus.inProgress) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Checking ...',
                          style: AppStyles.of(context).copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: appColors.black),
                        ),
                      );
                    }

                    final userNameRegex = RegExp(AppConstants.userNameRegex);

                    // null -> don't show anything
                    if (state.username == null) {
                      return SizedBox.shrink();
                    }

                    // empty -> show "Required"
                    if (state.username?.isEmpty ?? true) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Required',
                          style: AppStyles.of(context).copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: appColors.red),
                        ),
                      );
                    }

                    // not match regex -> 'The username field format is invalid'
                    if (!userNameRegex.hasMatch(state.username ?? '')) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'The username field format is invalid',
                          style: AppStyles.of(context).copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: appColors.red),
                        ),
                      );
                    }

                    // chech with server -> invalid
                    if (state.isUsernameValid == false) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'The username has already been taken',
                          style: AppStyles.of(context).copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: appColors.red),
                        ),
                      );
                    }

                    return SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: CustomTextFormField(
              controller: passwordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              maxLines: 1,
              hintText: 'Password',
              onChanged: (text) {
                context.read<RegisterCubit>().updatePassword(text);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: CustomTextFormField(
              onTap: () async {
                DateTime? dt;
                final formatDate = DateFormat(AppConstants.monthYearFormat);

                if (birthdayController.text.isNotEmpty) {
                  try {
                    dt = formatDate.parseStrict(birthdayController.text);
                  } catch (e) {
                    debugPrint('parseStrict birthdayController error: $e');
                  }
                }

                await showFMBS(
                  context: parentContext,
                  height: 248 + 16,
                  borderRadius: BorderRadius.zero,
                  builder: (builder) => MonthPicker(
                    selectedDateTime: dt,
                  ),
                ).then(
                  (value) {
                    if (value != null) {
                      var a = formatDate.format(value);
                      birthdayController.text = a;
                      context.read<RegisterCubit>().updateMonth(value.month);
                      context.read<RegisterCubit>().updateYear(value.year);
                    }
                  },
                );
              },
              controller: birthdayController,
              hintText: 'Birthday',
              readOnly: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: BlocBuilder<RegisterCubit, RegisterState>(
              builder: (context, state) {
                return CustomTextFormField(
                  onTap: () async {
                    await showFMBS(
                      context: parentContext,
                      builder: (builder) => CountryBottomSheet(
                        initialItem: state.country,
                        countries: state.localCountries ?? [],
                      ),
                    ).then(
                      (country) {
                        if (country != null) {
                          context.read<RegisterCubit>().updateCountry(country);
                          countryController.text = country.countryName;
                        }
                      },
                    );
                  },
                  controller: countryController,
                  hintText: 'Country',
                  readOnly: true,
                );
              },
            ),
          ),
          BlocBuilder<RegisterCubit, RegisterState>(
            builder: (context, state) {
              if (state.country == null) return SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                child: BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (context, state) {
                    return CustomTextFormField(
                      onTap: () async {
                        await showFMBS(
                          context: parentContext,
                          builder: (builder) => ClosestTownBottomSheet(
                            initialItem: state.city,
                            closestTowns: state.country?.closestTowns ?? [],
                          ),
                        ).then(
                          (city) {
                            if (city != null) {
                              context.read<RegisterCubit>().updateCity(city);
                              cityController.text = city;
                            }
                          },
                        );
                      },
                      controller: cityController,
                      hintText: 'Region',
                      readOnly: true,
                    );
                  },
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 16, 12, 0),
            child: Text(
              "Have a referral code?",
              style: AppStyles.of(context).copyWith(
                fontSize: 14,
                height: 18 / 14,
                fontWeight: FontWeight.w400,
                color: appColors.outerSpace,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: CustomTextFormField(
              controller: referralCodeController,
              hintText: 'Enter code',
              onChanged: (text) {
                context.read<RegisterCubit>().updateReferralCode(text);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 21, 12, 21),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text:
                        'By creating an account I accept Designer Wardrobe’s\n',
                    style: AppStyles.of(context).copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.normal,
                      color: appColors.outerSpace,
                    ),
                  ),
                  TextSpan(
                    recognizer: TapGestureRecognizer()..onTap = () {},
                    text: 'Terms',
                    style: AppStyles.of(context).copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.normal,
                      color: appColors.outerSpace,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  TextSpan(
                    text: ' & ',
                    style: AppStyles.of(context).copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.normal,
                      color: appColors.outerSpace,
                    ),
                  ),
                  TextSpan(
                    recognizer: TapGestureRecognizer()..onTap = () {},
                    text: 'Privacy Policy',
                    style: AppStyles.of(context).copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.normal,
                      color: appColors.outerSpace,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  TextSpan(
                    text: '.',
                    style: AppStyles.of(context).copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.normal,
                      color: appColors.outerSpace,
                    ),
                  ),
                ],
              ),
            ),
          ),
          BlocBuilder<RegisterCubit, RegisterState>(
            builder: (context, state) {
              final isValidFirstName = state.firstName?.isNotEmpty ?? false;
              final isValidLastName = state.lastName?.isNotEmpty ?? false;
              final isValidEmail = (state.email?.isNotEmpty ?? false) &&
                  (state.isEmailValid ?? false);
              final isValidUsername = (state.username?.isNotEmpty ?? false) &&
                  (state.isUsernameValid ?? false);
              final isValidPassword = state.password?.isNotEmpty ?? false;
              final isValidBirthday =
                  (state.month != null && state.year != null);
              final isValidCountry =
                  state.country?.countryName?.isNotEmpty ?? false;
              final isValidRegion = state.city?.isNotEmpty ?? false;
              final isActivated = isValidFirstName &&
                  isValidLastName &&
                  isValidEmail &&
                  isValidUsername &&
                  isValidPassword &&
                  isValidBirthday &&
                  isValidCountry &&
                  isValidRegion;
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 37),
                child: AppButton(
                  title: 'Sign Up',
                  onPressed: !isActivated
                      ? null
                      : () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          context.read<RegisterCubit>().validateUser();
                        },
                  backgroundColor: isActivated
                      ? appColors.registerButtonColor
                      : appColors.registerUnactivatedButtonColor,
                  textColor: appColors.registerTextButtonColor,
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(21, 30, 21, 30),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Already have an account? ',
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
                        parentContext.router.maybePop();
                      },
                    text: 'Log In',
                    style: AppStyles.of(context).copyWith(
                      fontSize: 14,
                      height: 18 / 14,
                      fontWeight: FontWeight.w600,
                      color: appColors.vividBlue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
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
          border: Border.all(color: appColors.lightGray),
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
                color: appColors.darkSlateBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
