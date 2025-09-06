import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:designerwardrobe/src/router/route_names.dart';
import 'package:designerwardrobe/src/router/router.dart';
import 'package:flutter/material.dart';

@RoutePage(name: onboardingOneRoute)
class OnboardingOneScreen extends StatelessWidget {
  const OnboardingOneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(), // pushes content to bottom like in your JSON

              // Title
              Text(
                "Connecting You to the World",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: "Creato Display", // from JSON
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF0A0A0C), // rgb(10,10,12)
                ),
              ),
              const SizedBox(height: 4),

              // Subtitle
              Text(
                "With access to 150+ countries, we have made\nglobal transactions easier and faster",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: "Creato Display",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF92939E), // rgb(146,147,158)
                ),
              ),
              const SizedBox(height: 16),

              // Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _dot(active: true),
                  _dot(),
                  _dot(),
                  _dot(),
                ],
              ),
              const SizedBox(height: 24),

              // Buttons
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0092FF), // primary blue
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed: () {
                    context.router.push(AccountTypeScreenRoute());
                  },
                  child: const Text(
                    "Sign up with Qwid",
                    style: TextStyle(
                      fontFamily: "Creato Display",
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Log in button (outlined)
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Color(0xFFE1E5EA),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Already a member? Log in",
                    style: TextStyle(
                      fontFamily: "Creato Display",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF0092FF),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Footer text
              Text(
                "By signing up or logging in, you agree to our\nTerms of service and privacy policy.",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: "Creato Display",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dot({bool active = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 5,
      height: 5,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? const Color(0xFF0092FF) : const Color(0xFFE1E5EA),
      ),
    );
  }
}