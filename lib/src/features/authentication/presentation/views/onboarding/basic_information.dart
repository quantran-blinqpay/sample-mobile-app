import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_images.dart';
import 'package:designerwardrobe/src/router/route_names.dart';
import 'package:designerwardrobe/src/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage(name: basicInformationRoute)
class BasicInformationScreen extends StatefulWidget {
  const BasicInformationScreen({super.key});

  @override
  State<BasicInformationScreen> createState() => _BasicInformationScreenState();
}

class _BasicInformationScreenState extends State<BasicInformationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _countryController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

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
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                "Step 1 of 4",
                style: TextStyle(
                  fontFamily: "Creato Display",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
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
              TextFormField(
                controller: _emailController,
                cursorColor: Color(0xff0092FF),
                decoration: const InputDecoration(
                  labelText: "Email Address",
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffF3F5F7), width: 0.5), // custom color & thickness
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff0092FF), width: 1),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              // Password
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                cursorColor: Color(0xff0092FF),
                decoration: InputDecoration(
                  labelText: "Password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
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
                  SvgPicture.asset(icQwidInformation, width: 14, height: 14, color: Color(0xFFAEAFC0)),
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
                  SvgPicture.asset(icQwidInformation, width: 14, height: 14, color: Color(0xFFAEAFC0)),
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
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                cursorColor: Color(0xff0092FF),
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
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
              ),
              const Spacer(),

              // Continue button
              SafeArea(
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: (){
                      context.router.push(AccountVerificationScreenRoute());
                    }, // Disabled until form valid
                    style: ElevatedButton.styleFrom(
                      elevation: 0, // remove shadow
                      shadowColor: Colors.transparent, // optional, ensures no shadow color
                      backgroundColor: const Color(0xFFF4F4F4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: const Text(
                      "Continue",
                      style: TextStyle(
                        fontFamily: "Creato Display",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFA3A3A3),
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
}