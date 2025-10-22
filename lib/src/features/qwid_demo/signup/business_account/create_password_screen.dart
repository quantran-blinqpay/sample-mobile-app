import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:qwid/src/components/scaffold/app_scaffold.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:qwid/src/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage(name: createPasswordRoute)
class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

enum TextFieldStatus {
  notValidated,
  valid,
  invalid,
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  TextFieldStatus _lengthStatus = TextFieldStatus.notValidated;
  TextFieldStatus? _specialCharacterStatus = TextFieldStatus.notValidated;

  bool _obscurePassword = true;

  bool get isFormValid {
    return (_lengthStatus == TextFieldStatus.valid && _specialCharacterStatus == TextFieldStatus.valid);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
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
                "Create a Password",
                style: const TextStyle(
                  fontFamily: "Creato Display",
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF0A0A0C),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Set up a secure password to protect your account. For better security, use a combination of letters, numbers, and special characters.",
                style: const TextStyle(
                  fontFamily: "Creato Display",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF92939E),
                ),
              ),
              const SizedBox(height: 24),

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
              const Spacer(),

              // Continue button
              SafeArea(
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: isFormValid ? (){
                      context.router.pop();
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

}