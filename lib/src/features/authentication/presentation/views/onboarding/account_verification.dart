import 'package:auto_route/annotations.dart';
import 'package:designerwardrobe/src/router/route_names.dart';
import 'package:flutter/material.dart';

@RoutePage(name: accountVerificationRoute)
class AccountVerificationScreen extends StatefulWidget {
  const AccountVerificationScreen({super.key});

  @override
  State<AccountVerificationScreen> createState() =>
      _AccountVerificationScreenState();
}

class _AccountVerificationScreenState extends State<AccountVerificationScreen> {
  final List<TextEditingController> _controllers =
  List.generate(6, (_) => TextEditingController());

  bool get _isCodeComplete =>
      _controllers.every((c) => c.text.isNotEmpty && c.text.length == 1);

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
            Text(
              "We sent a verification code to dan***oji@blinqpay.io.\nPlease enter the code below.",
              style: const TextStyle(
                fontFamily: "Arial",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF92939E),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                6,
                    (index) => _buildOtpBox(index),
              ),
            ),
            const SizedBox(height: 16),

            // Resend code
            GestureDetector(
              onTap: () {
                // TODO: resend code
              },
              child: const Text(
                "Didn’t get a code? Resend code",
                style: TextStyle(
                  fontFamily: "Creato Display",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF0092FF),
                ),
              ),
            ),
            const Spacer(),

            // Verify button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _isCodeComplete
                    ? () {
                  // TODO: verify code
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isCodeComplete
                      ? const Color(0xFF0092FF)
                      : const Color(0xFFF4F4F4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: Text(
                  "Verify",
                  style: TextStyle(
                    fontFamily: "Creato Display",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: _isCodeComplete
                        ? Colors.white
                        : const Color(0xFFA3A3A3),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Change Email
            Center(
              child: GestureDetector(
                onTap: () {
                  // TODO: change email flow
                },
                child: const Text(
                  "Change Email Address",
                  style: TextStyle(
                    fontFamily: "Creato Display",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF0092FF),
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

  Widget _buildOtpBox(int index) {
    return SizedBox(
      width: 52,
      height: 56,
      child: TextField(
        controller: _controllers[index],
        maxLength: 1,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          counterText: "",
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFFE1E5EA),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFF0092FF),
              width: 1.5,
            ),
          ),
        ),
        onChanged: (_) => setState(() {}),
      ),
    );
  }
}