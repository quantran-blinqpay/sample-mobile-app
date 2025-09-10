import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:qwid/src/components/text_field/otp_field.dart';
import 'package:qwid/src/features/authentication/presentation/views/onboarding/loading_bottom_sheet.dart';
import 'package:qwid/src/router/route_names.dart';
import 'package:qwid/src/router/router.dart';
import 'package:flutter/material.dart';

@RoutePage(name: accountVerificationByPhoneRoute)
class AccountVerificationByPhoneScreen extends StatefulWidget {
  const AccountVerificationByPhoneScreen({super.key});

  @override
  State<AccountVerificationByPhoneScreen> createState() =>
      _AccountVerificationScreenState();
}

class _AccountVerificationScreenState extends State<AccountVerificationByPhoneScreen> {
  String? _otp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              "Account Verification",
              style: const TextStyle(
                fontFamily: "Creato Display",
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: Color(0xFF0A0A0C),
              ),
            ),
            const SizedBox(height: 8),
            RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                children: [
                  TextSpan(
                    text:
                    'We sent a verification code to ',
                    style: const TextStyle(
                      fontFamily: "Arial",
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF92939E),
                    ),
                  ),
                  TextSpan(
                    text: '+234 908 437 3860. ',
                    style: const TextStyle(
                      fontFamily: "Arial",
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text:
                    '\nPlease enter the code below.',
                    style: const TextStyle(
                      fontFamily: "Arial",
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF92939E),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Enter code label
            Text(
              "Enter code",
              style: const TextStyle(
                fontFamily: "Creato Display",
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF92939E),
              ),
            ),
            const SizedBox(height: 12),

            // OTP boxes
            OTPInputField(
              length: 6,
              onChange: (val) {
                setState(() {
                  _otp = val;
                });
              },
              onCompleted: (val) {
                debugPrint(val);
              },
            ),
            const SizedBox(height: 16),

            // Resend code
            GestureDetector(
              onTap: () {
                // TODO: resend code
              },
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text:
                      'Didn’t get a code? ',
                      style: TextStyle(
                        fontFamily: "Creato Display",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff92939E),
                      ),
                    ),
                    TextSpan(
                      text: 'Resend code',
                      style: TextStyle(
                        fontFamily: "Creato Display",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF0092FF),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),

            // Verify button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _otp?.length == 6
                    ? () {
                      _openCountrySelector(context);
                    }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _otp?.length == 6
                      ? const Color(0xFF0092FF)
                      : const Color(0xFFF4F4F4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  elevation: 0, // remove shadow
                  shadowColor: Colors.transparent, // optional, ensures no shadow color
                ),
                child: Text(
                  "Verify",
                  style: TextStyle(
                    fontFamily: "Creato Display",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: _otp?.length == 6
                        ? Colors.white
                        : const Color(0xFFA3A3A3),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Change Email
            SafeArea(
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    // TODO: change email flow
                  },
                  child: const Text(
                    "Update mobile number",
                    style: TextStyle(
                      fontFamily: "Creato Display",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF0092FF),
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

  void _openCountrySelector(BuildContext context) async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const LoadingBottomSheet(title: 'We are verifying your account'),
    );

    if (selected != null) {
      context.router.push(ContactInformationScreenRoute());
    }
  }

}