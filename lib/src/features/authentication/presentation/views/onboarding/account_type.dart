import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:designerwardrobe/src/router/route_names.dart';
import 'package:designerwardrobe/src/router/router.dart';
import 'package:flutter/material.dart';

@RoutePage(name: accountTypeRoute)
class AccountTypeScreen extends StatelessWidget {
  const AccountTypeScreen({super.key});

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
              "Choose an account type",
              style: const TextStyle(
                fontFamily: "Creato Display",
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: Color(0xFF0A0A0C), // rgb(10,10,12)
              ),
            ),
            const SizedBox(height: 4),

            // Subtitle
            Text(
              "What kind of account would you like to open today?",
              style: const TextStyle(
                fontFamily: "Creato Display",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF92939E), // rgb(146,147,158)
              ),
            ),
            const SizedBox(height: 24),

            // List
            _accountItem(
              context,
              icon: Icons.person_outline,
              title: "Personal account",
              subtitle: "Send, spend, and receive money from around the world",
              onTap: () {
                context.router.push(CreatePersonalAccountScreenRoute());
              },
            ),
            _accountItem(
              context,
              icon: Icons.business_outlined,
              title: "Business account",
              subtitle: "Do business or work as a freelancer internationally",
              onTap: () {
                // TODO: navigate
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _accountItem(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String subtitle,
        VoidCallback? onTap,
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
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
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
                size: 16, color: Color(0xFF92939E)),
          ],
        ),
      ),
    );
  }
}