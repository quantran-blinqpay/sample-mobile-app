import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:qwid/src/router/route_names.dart';
import 'package:qwid/src/router/router.dart';

@RoutePage(name: tier1Verification)
class Tier1VerificationScreen extends StatelessWidget {
  const Tier1VerificationScreen({super.key});

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
        centerTitle: false,
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
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                const SizedBox(height: 16),
                const Text(
                  "Complete Your Tier 1 Verification",
                  style: TextStyle(
                    fontFamily: 'Creato Display',
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Provide additional user information to increase your transaction limit to ₦100 thousand per day and ₦1 million per month",
                  style: TextStyle(
                    fontFamily: 'Creato Display',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: sub,
                  ),
                ),
                const SizedBox(height: 24),

                // List of steps
                _stepTile(
                  icon: icQwidProfile,
                  title: "User Information",
                  description:
                  "We’ll need your gender, nationality, employment \nstatus and more.",
                ),
                _stepTile(
                  icon: icQwidIdentification,
                  title: "Identity Verification",
                  description:
                  "Upload a valid government-issued ID, like your \nnational ID, passport, or driver’s license.",
                ),
                _stepTile(
                  icon: icQwidCamera,
                  title: "Facial Verification",
                  description:
                  "Take a quick facial scan so we can confirm it’s \nreally you.",
                ),
              ],
            ),
          ),

          // Bottom button & note
          SafeArea(
            top: false,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: divider)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        context.router.push(UserInformationScreenRoute());
                      },
                      child: const Text(
                        "Continue",
                        style: TextStyle(
                          fontFamily: 'Creato Display',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _stepTile({
    required String icon,
    required String title,
    required String description,
  }) {
    const sub = Color(0xFF92939E);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                    fontFamily: 'Creato Display',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontFamily: 'Creato Display',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: sub,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}