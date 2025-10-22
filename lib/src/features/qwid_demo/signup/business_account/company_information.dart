import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:qwid/src/components/scaffold/app_scaffold.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:qwid/src/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qwid/src/router/router.dart';

@RoutePage(name: companyInformationRoute)
class CompanyInformationScreen extends StatefulWidget {
  const CompanyInformationScreen({super.key});

  @override
  State<CompanyInformationScreen> createState() => _CompanyInformationScreenState();
}

enum TextFieldStatus {
  notValidated,
  valid,
  invalid,
}

class _CompanyInformationScreenState extends State<CompanyInformationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _businessNameController = TextEditingController();
  String? _errorText;

  bool get isFormValid {
    return (_errorText?.isEmpty ?? true && _emailController.text.isNotEmpty)
        && _businessNameController.text.isNotEmpty;
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
                "Company Information",
                style: const TextStyle(
                  fontFamily: "Creato Display",
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF0A0A0C),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Sign up with your company name, email address, and business type to create an account, unlock all features, and receive important updates.",
                style: const TextStyle(
                  fontFamily: "Creato Display",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF92939E),
                ),
              ),
              const SizedBox(height: 24),

              // Email
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      onTapOutside: (_) => FocusScope.of(context).unfocus(),
                      controller: _businessNameController,
                      cursorColor: Color(0xff0092FF),
                      decoration: const InputDecoration(
                        labelText: "Business Name",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffF3F5F7), width: 0.5), // custom color & thickness
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff0092FF), width: 1),
                        ),
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      onTapOutside: (_) => FocusScope.of(context).unfocus(),
                      controller: _emailController,
                      cursorColor: const Color(0xff0092FF),
                      decoration: const InputDecoration(
                        labelText: "Company Email",
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
              ),
              const SizedBox(height: 16),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: isFormValid ? (){
                        context.router.push(AccountVerificationScreenRoute()).then((value) {
                          if (value != null) {
                            context.router.pop();
                          }
                        });
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
              ),
            ],
          ),
        ),
      ),
    );
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

}