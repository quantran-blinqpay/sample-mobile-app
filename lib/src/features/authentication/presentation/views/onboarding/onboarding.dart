import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:designerwardrobe/src/router/route_names.dart';
import 'package:designerwardrobe/src/router/router.dart';
import 'package:flutter/material.dart';

@RoutePage(name: onboardingRoute)
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final pageController = PageController(initialPage: 0);
  int index = 0;

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
              Expanded(
                child: PageView(
                  controller: pageController,
                  onPageChanged: (value) {
                    setState(() {
                      index = value;
                    });
                  },
                  children: [
                    _buildTabItem(title: "Connecting You to the World",
                        subtitle: "With access to 150+ countries, we have made\nglobal transactions easier and faster"),
                    _buildTabItem(title: "Send and Receive Money",
                        subtitle: "Seamlessly send and receive money globally\nwith just a few simple steps"),
                    _buildTabItem(title: "Convert to Multiple Currencies",
                        subtitle: "Convert your funds into major currencies such as\nUSD, GBP, EUR, and so much more"),
                    _buildTabItem(title: "Trade Crypto with Qwid",
                        subtitle: "Simply and securely buy, sell, send, and receive\ncryptocurrencies with Qwid"),
                  ],
                ),
              ),

              // Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _dot(active: index == 0),
                  _dot(active: index == 1),
                  _dot(active: index == 2),
                  _dot(active: index == 3),
                ],
              ),
              const SizedBox(height: 24),

              // Buttons
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0, // remove shadow
                    shadowColor: Colors.transparent, // optional, ensures no shadow color
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
                    elevation: 0, // remove shadow
                    shadowColor: Colors.transparent, // optional, ensures no shadow color
                    side: const BorderSide(
                      color: Color(0xFFE1E5EA),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed: () {
                    context.router.push(QwidHomeScreenRoute());
                  },
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
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'By signing up or logging in, you agree to our ',
                      style: const TextStyle(
                        fontFamily: "Creato Display",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: '\nTerms of service',
                      style: const TextStyle(
                        fontFamily: "Creato Display",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff0092FF),
                      ),
                    ),
                    TextSpan(
                      text: ' and ',
                      style: const TextStyle(
                        fontFamily: "Creato Display",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: 'privacy policy',
                      style: const TextStyle(
                        fontFamily: "Creato Display",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff0092FF),
                      ),
                    ),
                    TextSpan(
                      text: '.',
                      style: const TextStyle(
                        fontFamily: "Creato Display",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ],
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

  Widget _buildTabItem({required String title, required String subtitle}) {
    {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          // Title
          Text(
            title,
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
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: "Creato Display",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF92939E), // rgb(146,147,158)
            ),
          ),
          const SizedBox(height: 16),
        ],
      );
    }
  }
}