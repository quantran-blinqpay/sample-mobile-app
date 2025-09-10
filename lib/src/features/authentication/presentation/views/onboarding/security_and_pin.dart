import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:qwid/src/router/route_names.dart';
import 'package:qwid/src/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage(name: securityAndPinRoute)
class SecurityAndPinScreen extends StatefulWidget {
  const SecurityAndPinScreen({super.key});

  @override
  State<SecurityAndPinScreen> createState() => _SecurityAndPinScreenState();
}

class _SecurityAndPinScreenState extends State<SecurityAndPinScreen> {
  bool _pinSetup = false;
  bool _securityQuestionSetup = false;

  @override
  Widget build(BuildContext context) {
    final bool isFormValid = _pinSetup && _securityQuestionSetup;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text:
                      'Step 3 ',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              "Security and PIN",
              style: const TextStyle(
                fontFamily: "Creato Display",
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: Color(0xFF0A0A0C),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Set up additional security to protect your account.",
              style: const TextStyle(
                fontFamily: "Creato Display",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF92939E),
              ),
            ),
            const SizedBox(height: 24),

            // Set up PIN
            _securityItem(
              icon: icQwidKey,
              title: "Set up PIN",
              subtitle: "Set up a transaction PIN to secure your account",
              linkText: "Set up transaction PIN",
              onTap: () {
                setState(() => _pinSetup = true);
                context.router.push(SetupPinScreenRoute());
              },
            ),
            const SizedBox(height: 12),

            // Security Questions
            _securityItem(
              icon: icQwidSecurity,
              title: "Security Questions",
              subtitle:
              "Access your account when you can’t use your password or two-step verification",
              linkText: "Set up security question",
              onTap: () {
                setState(() => _securityQuestionSetup = true);
                context.router.push(SecurityQuestionsScreenRoute());
              },
            ),
            const Spacer(),

            // Continue button
            SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: (){
                    context.router.push(QwidHomeScreenRoute());
                  }/*isFormValid
                      ? () {
                    // TODO: navigate to Step 4
                  }
                      : null*/,
                  style: ElevatedButton.styleFrom(
                    elevation: 0, // remove shadow
                    shadowColor: Colors.transparent, // optional, ensures no shadow color
                    backgroundColor:
                    isFormValid ? const Color(0xFF0092FF) : const Color(0xFFF4F4F4),
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
                      color:
                      isFormValid ? Colors.white : const Color(0xFFA3A3A3),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _securityItem({
    required String icon,
    required String title,
    required String subtitle,
    required String linkText,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(icon, width: 24, height: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: "Creato Display",
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF0A0A0C),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontFamily: "Creato Display",
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF92939E),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    linkText,
                    style: const TextStyle(
                      fontFamily: "Creato Display",
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF0092FF),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}