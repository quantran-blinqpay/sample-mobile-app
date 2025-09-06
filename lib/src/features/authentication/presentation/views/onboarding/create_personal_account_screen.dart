import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:designerwardrobe/src/router/route_names.dart';
import 'package:designerwardrobe/src/router/router.dart';
import 'package:flutter/material.dart';

@RoutePage(name: createPersonalAccountRoute)
class CreatePersonalAccountScreen extends StatelessWidget {
  const CreatePersonalAccountScreen({super.key});

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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              "Create a Personal account",
              style: const TextStyle(
                fontFamily: "Creato Display",
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Color(0xFF0A0A0C), // rgb(10,10,12)
              ),
            ),
            const SizedBox(height: 4),

            // Subtitle
            Text(
              "Create your account in a few simple steps",
              style: const TextStyle(
                fontFamily: "Creato Display",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF92939E), // rgb(146,147,158)
              ),
            ),
            const SizedBox(height: 24),

            // Steps
            _stepItem(
              icon: Icons.public_outlined,
              title: "Basic Information",
              subtitle:
              "We need your basic information like country of residence and email to create your account",
            ),
            _stepItem(
              icon: Icons.person_outline,
              title: "Personal Information",
              subtitle:
              "We need your personal details like your full name and email address to set up your account",
            ),
            _stepItem(
              icon: Icons.contact_mail_outlined,
              title: "Contact Information",
              subtitle:
              "To complete your registration, please provide your phone number, address, city, state, and postal code.",
            ),
            _stepItem(
              icon: Icons.shield_outlined,
              title: "Security and PIN",
              subtitle:
              "Add a layer of security by setting up your password, transaction PIN, and biometrics",
            ),

            const Spacer(),

            // Get Started button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0092FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onPressed: () {
                  context.router.push(BasicInformationScreenRoute());
                },
                child: const Text(
                  "Get Started",
                  style: TextStyle(
                    fontFamily: "Creato Display",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
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

  Widget _stepItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 24, color: Color(0xFF92939E)),
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
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF0A0A0C),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontFamily: "Creato Display",
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF92939E),
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
