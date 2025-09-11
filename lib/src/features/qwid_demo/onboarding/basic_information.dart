import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:qwid/src/features/qwid_demo/onboarding/select_country_bottom_sheet.dart';
import 'package:qwid/src/router/route_names.dart';
import 'package:qwid/src/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage(name: basicInformationRoute)
class BasicInformationScreen extends StatefulWidget {
  const BasicInformationScreen({super.key});

  @override
  State<BasicInformationScreen> createState() => _BasicInformationScreenState();
}

enum TextFieldStatus {
  notValidated,
  valid,
  invalid,
}

class _BasicInformationScreenState extends State<BasicInformationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _countryController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String? _errorText;
  TextFieldStatus _lengthStatus = TextFieldStatus.notValidated;
  TextFieldStatus? _specialCharacterStatus = TextFieldStatus.notValidated;
  String? _errorConfirmText;

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isCountryEmpty = true;

  @override
  void initState() {
    super.initState();
    _countryController.addListener(() {
      setState(() {
        _isCountryEmpty = _countryController.text.isEmpty;
      });
    });
  }

  bool get isFormValid {
    return !_isCountryEmpty
        && (_errorText?.isEmpty ?? true && _emailController.text.isNotEmpty)
        && (_lengthStatus == TextFieldStatus.valid && _specialCharacterStatus == TextFieldStatus.valid)
        && (_errorConfirmText?.isEmpty ?? true && _confirmPasswordController.text.isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text:
                      'Step 1 ',
                      style: TextStyle(
                        fontFamily: "Creato Display",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: 'of 4',
                      style: TextStyle(
                        fontFamily: "Creato Display",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff92939E),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                "Basic Information",
                style: const TextStyle(
                  fontFamily: "Creato Display",
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF0A0A0C),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Please enter the following details to create your Qwid account",
                style: const TextStyle(
                  fontFamily: "Creato Display",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF92939E),
                ),
              ),
              const SizedBox(height: 24),

              // Country Dropdown
              TextFormField(
                controller: _countryController,
                readOnly: true,
                cursorColor: Color(0xff0092FF),
                onTap: (){
                  _openCountrySelector(context);
                },
                decoration: InputDecoration(
                  labelText: "Country of Residence",
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset(icQwidArrowDown, width: 24, height: 24, color: Color(0xFF92939E)),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffF3F5F7), width: 0.5), // custom color & thickness
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff0092FF), width: 1),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Email
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _emailController,
                    cursorColor: const Color(0xff0092FF),
                    decoration: const InputDecoration(
                      labelText: "Email Address",
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffF3F5F7), width: 0.5),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff0092FF), width: 1),
                      ),
                      errorStyle: TextStyle(height: 0), // hide default error
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (_) => _validateEmail(),
                  ),

                  // Custom error widget
                  if (_errorText != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            icQwidError,
                            width: 16,
                            height: 16,
                            color: Colors.red),
                          const SizedBox(width: 4),
                          Text(
                            _errorText!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.red,
                              fontFamily: "Creato Display",
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),

              // Password
              TextFormField(
                onChanged: (_) {
                  _validate8Character();
                  _validateSpecialCharacter();
                },
                controller: _passwordController,
                obscureText: _obscurePassword,
                cursorColor: Color(0xff0092FF),
                decoration: InputDecoration(
                  labelText: "Password",
                  suffixIcon: IconButton(
                    icon: SvgPicture.asset(
                      _obscurePassword
                          ? icQwidEyeOff
                          : icQwidEyeOn,
                      width: 24,
                      height: 24,
                      color: Color(0xFF92939E),
                    ),
                    onPressed: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffF3F5F7), width: 0.5), // custom color & thickness
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff0092FF), width: 1),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  SvgPicture.asset(
                      _lengthStatus == TextFieldStatus.valid
                          ? icQwidSuccess
                          : _lengthStatus == TextFieldStatus.invalid
                            ? icQwidError
                            : icQwidInformation, width: 14, height: 14),
                  SizedBox(width: 4),
                  Text(
                    "Password must be at least 8 characters",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF92939E),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SvgPicture.asset(
                      _specialCharacterStatus == TextFieldStatus.valid
                          ? icQwidSuccess
                          : _specialCharacterStatus == TextFieldStatus.invalid
                            ? icQwidError
                            : icQwidInformation, width: 14, height: 14),
                  SizedBox(width: 4),
                  Text(
                    "Password must contain a special character",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF92939E),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Confirm Password
              Column(
                children: [
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    cursorColor: Color(0xff0092FF),
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      suffixIcon: IconButton(
                        icon: SvgPicture.asset(
                          _obscureConfirmPassword
                              ? icQwidEyeOff
                              : icQwidEyeOn,
                          width: 24,
                          height: 24,
                          color: Color(0xFF92939E),
                        ),
                        onPressed: () {
                          setState(() =>
                          _obscureConfirmPassword = !_obscureConfirmPassword);
                        },
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffF3F5F7), width: 0.5), // custom color & thickness
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff0092FF), width: 1),
                      ),
                    ),
                    onChanged: (_) => _validateConfirmCharacter(),
                  ),
                  // Custom error widget
                  if (_errorConfirmText != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                              icQwidError,
                              width: 16,
                              height: 16,
                              color: Colors.red),
                          const SizedBox(width: 4),
                          Text(
                            _errorConfirmText!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.red,
                              fontFamily: "Creato Display",
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const Spacer(),

              // Continue button
              SafeArea(
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: isFormValid ? (){
                      context.router.push(AccountVerificationScreenRoute());
                    } : null, // Disabled until form valid
                    style: ElevatedButton.styleFrom(
                      elevation: 0, // remove shadow
                      shadowColor: Colors.transparent, // optional, ensures no shadow color
                      backgroundColor: isFormValid
                          ? const Color(0xFF0092FF)
                          : const Color(0xFFF4F4F4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: Text(
                      "Continue",
                      style: TextStyle(
                        fontFamily: "Creato Display",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: isFormValid ? Colors.white : Color(0xFFA3A3A3),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _openCountrySelector(BuildContext context) async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const SelectCountryBottomSheet(),
    );

    if (selected != null) {
      _countryController.text = selected;
      print("Selected country: $selected");
    }
  }

  void _validateEmail() {
    final value = _emailController.text;
    if (value.isEmpty) {
      setState(() => _errorText = "Email is required");
    } else {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(value)) {
        setState(() => _errorText = "Invalid email address");
      } else {
        setState(() => _errorText = null);
      }
    }
  }

  void _validate8Character() {
    final value = _passwordController.text;
    if (value.isEmpty) {
      setState(() => _lengthStatus = TextFieldStatus.notValidated);
    } else {
      if (value.length < 8) {
        setState(() => _lengthStatus = TextFieldStatus.invalid);
      } else {
        setState(() => _lengthStatus = TextFieldStatus.valid);
      }
    }
  }

  void _validateSpecialCharacter() {
    final value = _passwordController.text;
    if (value.isEmpty) {
      setState(() => _specialCharacterStatus = TextFieldStatus.notValidated);
    } else {
      final hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]');;
      if (!hasSpecialChar.hasMatch(value)) {
        setState(() => _specialCharacterStatus = TextFieldStatus.invalid);
      } else {
        setState(() => _specialCharacterStatus = TextFieldStatus.valid);
      }
    }
  }

  void _validateConfirmCharacter() {
    final password = _confirmPasswordController.text;
    final confirmPassword = _passwordController.text;
    if (confirmPassword.isEmpty) {
      setState(() => _errorConfirmText = "Password is required");
    } else {
      if (password != confirmPassword) {
        setState(() => _errorConfirmText = "Password does not match");
      } else {
        setState(() => _errorConfirmText = null);
      }
    }
  }
}