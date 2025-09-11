import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:qwid/src/router/route_names.dart';

@RoutePage(name: identityVerification)
class IdentityVerificationScreen extends StatelessWidget {
  const IdentityVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const blue = Color(0xFF0092FF);
    const sub = Color(0xFF92939E);
    const divider = Color(0xFFF3F5F7);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18, color: Colors.black),
          onPressed: () => Navigator.maybePop(context),
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
                      'Step 2 ',
                      style: TextStyle(
                        fontFamily: "Creato Display",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: 'of 3',
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

      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: const Text(
                    "Identity Verification",
                    style: TextStyle(
                      fontFamily: 'Creato Display',
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: const Text(
                    "Choose how you'd like to verify your identity.",
                    style: TextStyle(
                      fontFamily: 'Creato Display',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: sub,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // NIN option
                _optionTile(
                  title: "National Identification Number (NIN)",
                  onTap: () {
                    // Navigate to NIN flow
                  },
                ),

                // BVN option
                _optionTile(
                  title: "Bank Verification Number (BVN)",
                  onTap: () {
                    // Navigate to BVN flow
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _optionTile({required String title, required VoidCallback onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: SvgPicture.asset(icQwidIdentification2, width: 24, height: 24),
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Creato Display',
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        trailing: SvgPicture.asset(icQwidArrowRight, width: 24, height: 24),
        onTap: onTap,
      ),
    );
  }
}