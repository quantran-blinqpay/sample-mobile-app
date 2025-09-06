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
        centerTitle: true,
        title: const Text(
          "Home",
          style: TextStyle(
            fontFamily: "Creato Display",
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Color(0xFF0A0A0C),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF0A0A0C), size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF0A0A0C), size: 24),
            onPressed: () {},
          ),
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.notifications_outlined, color: Color(0xFF0A0A0C), size: 24),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Color(0xFF0092FF),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  
                  // Header section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Create a Personal account",
                        style: TextStyle(
                          fontFamily: "Creato Display",
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF0A0A0C),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Create your account in a few simple steps",
                        style: TextStyle(
                          fontFamily: "Creato Display",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF92939E),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Steps list
                  Expanded(
                    child: Column(
                      children: [
                        _buildStepItem(
                          icon: Icons.info_outline,
                          title: "Basic Information",
                          description: "We need your basic information like country of residence and email to create your account",
                          onTap: () {},
                        ),
                        _buildStepItem(
                          icon: Icons.person_outline,
                          title: "Personal Information",
                          description: "We need your personal details like your full name and email address to set up your account",
                          onTap: () {},
                        ),
                        _buildStepItem(
                          icon: Icons.contact_mail_outlined,
                          title: "Contact Information",
                          description: "To complete your registration, please provide your phone number, address, city, state, and postal code.",
                          onTap: () {},
                        ),
                        _buildStepItem(
                          icon: Icons.security_outlined,
                          title: "Security and PIN",
                          description: "Add a layer of security by setting up your password, transaction PIN, and biometrics",
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Bottom section with button and text
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 16,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0092FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      onPressed: () {
                        // Navigate to registration screen
                        context.router.push(RegisterScreenRoute());
                      },
                      child: const Text(
                        "Get Started",
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
                  const Text(
                    "Please enter your details as they appear on your ID to help us verify your identity quickly and securely.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Creato Display",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF92939E),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepItem({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFFF3F5F7), width: 1),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 24, color: const Color(0xFF92939E)),
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
                    description,
                    style: const TextStyle(
                      fontFamily: "Creato Display",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF92939E),
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
