
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:qwid/src/router/route_names.dart';

@RoutePage(name: facialVerification)
class FacialVerificationScreen extends StatelessWidget {
  const FacialVerificationScreen({super.key});

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
                        'Step 3 ',
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
                  "Facial Verification",
                  style: TextStyle(
                    fontFamily: 'Creato Display',
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Take a quick facial scan so we can confirm it’s really you.",
                  style: TextStyle(
                    fontFamily: 'Creato Display',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: sub,
                  ),
                ),
                const SizedBox(height: 24),

                // Selfie tile
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(icQwidCamera, width: 24, height: 24),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Take a Selfie",
                              style: TextStyle(
                                fontFamily: 'Creato Display',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Ensure you’re in a well lit room and remove anything that covers your face. Don’t worry, this photo won’t appear in your profile.",
                              style: TextStyle(
                                fontFamily: 'Creato Display',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: sub,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
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
                border: Border(top: BorderSide(color: divider)),
                color: Colors.white,
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
                        // Submit action
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
                  const SizedBox(height: 12),
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text:
                          "Your documents captured during the ID Verification process are safe and secure. Please See our ",
                          style: TextStyle(
                            fontFamily: 'Creato Display',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: sub,
                          ),
                        ),
                        TextSpan(
                          text: "Privacy Policy",
                          style: TextStyle(
                            fontFamily: 'Creato Display',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: blue,
                          ),
                        ),
                        TextSpan(
                          text:
                          " for more information on how we store your data.",
                          style: TextStyle(
                            fontFamily: 'Creato Display',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: sub,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}