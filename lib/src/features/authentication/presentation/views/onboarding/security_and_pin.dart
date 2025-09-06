import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:designerwardrobe/src/router/route_names.dart';
import 'package:designerwardrobe/src/router/router.dart';
import 'package:flutter/material.dart';

@RoutePage(name: securityAndPinRoute)
class SecurityAndPinScreen extends StatefulWidget {
  const SecurityAndPinScreen({super.key});

  @override
  State<SecurityAndPinScreen> createState() => _SecurityAndPinScreenState();
}

class _SecurityAndPinScreenState extends State<SecurityAndPinScreen> {
  bool _pinSetup = false;
  bool _securityQuestionSetup = false;

  @override
  Widget build(BuildContext context) {
    final bool isFormValid = _pinSetup && _securityQuestionSetup;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                "Step 3 of 4",
                style: TextStyle(
                  fontFamily: "Creato Display",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              "Security and PIN",
              style: const TextStyle(
                fontFamily: "Creato Display",
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: Color(0xFF0A0A0C),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Set up additional security to protect your account.",
              style: const TextStyle(
                fontFamily: "Creato Display",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF92939E),
              ),
            ),
            const SizedBox(height: 24),

            // Set up PIN
            _securityItem(
              icon: Icons.vpn_key_outlined,
              title: "Set up PIN",
              subtitle: "Set up a transaction PIN to secure your account",
              linkText: "Set up transaction PIN",
              onTap: () {
                setState(() => _pinSetup = true);
              },
            ),
            const SizedBox(height: 12),

            // Security Questions
            _securityItem(
              icon: Icons.shield_outlined,
              title: "Security Questions",
              subtitle:
              "Access your account when you can’t use your password or two-step verification",
              linkText: "Set up security question",
              onTap: () {
                setState(() => _securityQuestionSetup = true);
              },
            ),
            const Spacer(),

            // Continue button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: (){
                  context.router.push(SetupPinScreenRoute());
                }/*isFormValid
                    ? () {
                  // TODO: navigate to Step 4
                }
                    : null*/,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  isFormValid ? const Color(0xFF0092FF) : const Color(0xFFF4F4F4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: Text(
                  "Continue",
                  style: TextStyle(
                    fontFamily: "Creato Display",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color:
                    isFormValid ? Colors.white : const Color(0xFFA3A3A3),
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

  Widget _securityItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String linkText,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFFF3F5F7)),
          ),
        ),
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
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF0A0A0C),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontFamily: "Creato Display",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF92939E),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    linkText,
                    style: const TextStyle(
                      fontFamily: "Creato Display",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF0092FF),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios,
                size: 16, color: Color(0xFF94A3B8)),
          ],
        ),
      ),
    );
  }
}