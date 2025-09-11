import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:qwid/src/router/route_names.dart';
import 'package:qwid/src/router/router.dart';

@RoutePage(name: kycRoute)
class KycScreen extends StatelessWidget {
  const KycScreen({super.key});

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
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                const Text(
                  "Complete Your KYC",
                  style: TextStyle(
                    fontFamily: 'Creato Display',
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Completing your KYC ensures a safe and seamless experience, allowing you to transact without restrictions.",
                  style: TextStyle(
                    fontFamily: 'Creato Display',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: sub,
                  ),
                ),
                const SizedBox(height: 24),

                // Tier 1
                _tierCard(
                  tier: "Tier 1",
                  description:
                  "Provide additional user information to increase your transaction limit to ₦100 thousand per day and ₦1 million per month.",
                ),
                _tierCard(
                  tier: "Tier 2",
                  description:
                  "Upload a valid government-issued ID to increase your transaction limit from ₦1 million daily and ₦10 million monthly.",
                ),
                _tierCard(
                  tier: "Tier 3",
                  description:
                  "Submit your proof of address to send up to ₦10 million daily and ₦100 million monthly.",
                ),
              ],
            ),
          ),

          // Bottom button
          SafeArea(
            top: false,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: divider)),
              ),
              child: SizedBox(
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
                    context.router.push(Tier1VerificationScreenRoute());
                  },
                  child: const Text(
                    "Next",
                    style: TextStyle(
                      fontFamily: 'Creato Display',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tierCard({required String tier, required String description}) {
    const sub = Color(0xFF92939E);
    const divider = Color(0xFFF3F5F7);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: divider),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(icQwidTierBadge, width: 22, height: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tier,
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