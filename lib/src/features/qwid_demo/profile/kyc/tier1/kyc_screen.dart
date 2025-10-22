import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qwid/src/components/scaffold/app_scaffold.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:qwid/src/router/route_names.dart';
import 'package:qwid/src/router/router.dart';

@RoutePage(name: kycRoute)
class KycScreen extends StatefulWidget {
  const KycScreen({super.key});

  @override
  State<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen> {
  bool _tier1 = false;
  bool _tier2 = false;
  bool _tier3 = false;

  @override
  Widget build(BuildContext context) {
    const blue = Color(0xFF0092FF);
    const sub = Color(0xFF92939E);
    const divider = Color(0xFFF3F5F7);

    return AppScaffold(
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
          const SizedBox(height: 16),
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
                  onTap: () {
                    setState(() {
                      _tier1 = true;
                    });
                    context.router.push(const Tier1VerificationScreenRoute());
                  },
                  selected: _tier1,
                  tier: "Tier 1",
                  description:
                  "Provide additional user information to increase your transaction limit to ₦100 thousand per day and ₦1 million per month.",
                ),
                _tierCard(
                  onTap: () {
                    setState(() {
                      _tier2 = true;
                    });
                    context.router.push(const Tier2VerificationScreenRoute());
                  },
                  selected: _tier2,
                  tier: "Tier 2",
                  description:
                  "Upload a valid government-issued ID to increase your transaction limit from ₦1 million daily and ₦10 million monthly.",
                ),
                _tierCard(
                  onTap: () {
                    setState(() {
                      _tier3 = true;
                    });
                    context.router.push(const Tier3VerificationScreenRoute());
                  },
                  selected: _tier3,
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
                    backgroundColor: _tier1 && _tier2 && _tier3 ? blue: const Color(0xFFF4F4F4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    // todo
                  },
                  child: Text(
                    "Next",
                    style: TextStyle(
                      fontFamily: 'Creato Display',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _tier1 && _tier2 && _tier3 ? Colors.white: const Color(0xFFA3A3A3),
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

  Widget _tierCard({
      required bool selected,
      required String tier,
      required String description,
      required VoidCallback onTap}) {
    const sub = Color(0xFF92939E);
    const divider = Color(0xFFF3F5F7);

    return GestureDetector(
      onTap: () => onTap.call(),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(selected? icQwidTierCompleted : icQwidTierBadge, width: 22, height: 22),
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
      ),
    );
  }
}