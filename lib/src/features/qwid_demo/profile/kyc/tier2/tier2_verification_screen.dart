import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qwid/src/components/scaffold/app_scaffold.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:qwid/src/router/route_names.dart';
import 'package:qwid/src/router/router.dart';

@RoutePage(name: tier2VerificationRoute)
class Tier2VerificationScreen extends StatelessWidget {
  const Tier2VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const sub = Color(0xFF92939E);

    return AppScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18, color: Colors.black),
          onPressed: () => Navigator.maybePop(context),
        ),
        centerTitle: false,
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                const SizedBox(height: 16),
                const Text(
                  "Upgrade to Tier 2 Account",
                  style: TextStyle(
                    fontFamily: 'Creato Display',
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Upload a valid government-issued ID to increase your transaction limit from ₦1 million daily and ₦10 million monthly..",
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
                  onTap: () {
                    context.router.push(DocumentUploadScreenRoute()).then((value) {
                      if (value == "take a photo") {
                        context.router.push(TakeAPassportPictureScreenRoute());
                      } else if (value == "upload document") {
                        context.router.push(InternationalPassportScreenRoute());
                      }
                    });
                  },
                  icon: icQwidIdentification2,
                  title: "International Passport",
                ),
                _stepTile(
                  onTap: () {
                    context.router.push(DocumentUploadScreenRoute()).then((value) {
                      if (value == "take a photo") {
                        context.router.push(TakeDriverLicensePictureRouteScreenRoute());
                      } else if (value == "upload document") {
                        context.router.push(DriverLicenseScreenRoute());
                      }
                    });
                  },
                  icon: icQwidIdentification2,
                  title: "Driver’s License",
                ),
                _stepTile(
                  onTap: () {
                    context.router.push(DocumentUploadScreenRoute());
                    // Get.toNamed(AppRoutes.documentUploadScreen);
                  },
                  icon: icQwidIdentification2,
                  title: "Voter’s Card",
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
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: const Text(
                      "You can choose to take pictures or upload any of your government-issued ID document listed above.",
                      style: TextStyle(
                        fontFamily: 'Creato Display',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff92939E),
                      ),
                      textAlign: TextAlign.center,
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
    required VoidCallback onTap,
  }) {

    return GestureDetector(
      onTap: () => onTap.call(),
      child: Container(
        color: Colors.transparent,
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
                ],
              ),
            ),
            SvgPicture.asset(icQwidArrowRight, width: 24, height: 24),
          ],
        ),
      ),
    );
  }
}