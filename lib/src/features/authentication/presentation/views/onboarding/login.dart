import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_images.dart';
import 'package:designerwardrobe/src/router/route_names.dart';
import 'package:designerwardrobe/src/router/router.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage(name: loginRoute)
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  String? _errorText;
  bool _obscurePassword = true;

  bool get _canSubmit =>
      (_errorText?.isEmpty ?? true && _email.text.isNotEmpty) && _password.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    _email.addListener(_onChanged);
    _password.addListener(_onChanged);
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _onChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    const colorText = Color(0xFF0A0A0C);
    const colorSubText = Color(0xFF92939E);
    const colorUnderline = Color(0xFFF3F5F7);
    const colorLink = Color(0xFF0092FF);
    const btnDisabledBg = Color(0xFFF4F4F4);
    const btnDisabledText = Color(0xFFA3A3A3);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18, color: colorText),
          onPressed: () => Navigator.maybePop(context),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            children: [
              const SizedBox(height: 4),
              const Text(
                'Sign In with a different account',
                style: TextStyle(
                  fontFamily: 'Creato Display',
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: colorText,
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                'Enter email and password to sign in',
                style: TextStyle(
                  fontFamily: 'Creato Display',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: colorSubText,
                ),
              ),
              const SizedBox(height: 32),

              // Email
              TextFormField(
                controller: _email,
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
              const SizedBox(height: 24),

              // Password
              TextFormField(
                onChanged: (_) {},
                controller: _password,
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
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {
                    // TODO: context.router.push(ForgotPasswordRoute());
                  },
                  child: const Text(
                    'Forgot your password?',
                    style: TextStyle(
                      fontFamily: 'Creato Display',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: colorLink,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Sign in button
              SizedBox(
                height: 52,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _canSubmit
                      ? () {
                    context.router.replace(const QwidHomeScreenRoute());
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: _canSubmit ? colorLink : btnDisabledBg,
                    disabledBackgroundColor: btnDisabledBg,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                      fontFamily: 'Creato Display',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: _canSubmit ? Colors.white : btnDisabledText,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),
              Center(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontFamily: 'Creato Display',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: colorSubText,
                    ),
                    children: [
                      const TextSpan(text: "Don’t have an account? "),
                      TextSpan(
                        text: 'Sign up',
                        style: const TextStyle(color: colorLink),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // TODO: context.router.push(const SignUpRoute());
                          },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  void _validateEmail() {
    final value = _email.text;
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
}