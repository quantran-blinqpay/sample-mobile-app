import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:qwid/src/router/route_names.dart';

@RoutePage(name: accountDetailRoute)
class AccountDetailScreen extends StatelessWidget {
  const AccountDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const blue = Color(0xFF0092FF);
    const sub = Color(0xFF92939E);
    const divider = Color(0xFFF3F5F7);

    return Scaffold(
      backgroundColor: const Color(0xFFFcFcFc),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18, color: Colors.black),
          onPressed: () => Navigator.maybePop(context),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile section
          const Text(
            "Profile",
            style: TextStyle(
              fontFamily: 'Creato Display',
              fontSize: 24,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "View and update your personal details anytime. This helps us keep your account accurate and secure.",
            style: TextStyle(
              fontFamily: 'Creato Display',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: sub,
            ),
          ),
          const SizedBox(height: 16),

          // User card
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: divider),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFFFAFAFA),
                    border: Border.all(color: divider),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "BA",
                    style: TextStyle(
                      fontFamily: 'Creato Display',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFAEB3BE),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // User info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Blessing Ayodele",
                        style: TextStyle(
                          fontFamily: 'Creato Display',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        "blessingayodele@gmail.com",
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: sub,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F8FF),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Text(
                          "Personal account",
                          style: TextStyle(
                            fontFamily: 'Creato Display',
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Personal Information
          Container(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: divider),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: divider)),
                  ),
                  child: Text(
                    "Personal information",
                    style: const TextStyle(
                      fontFamily: 'Creato Display',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff92939E),
                    ),
                  ),
                ),
                _infoRow("First name", "Blessing"),
                _infoRow("Last name", "Ayodele"),
                _infoRow("Date of birth", "01-01-2000"),
                _infoRow("Gender", "Female"),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    const sub = Color(0xFF92939E);
    const divider = Color(0xFFE1E5EA);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: 'Creato Display',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: sub,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Creato Display',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}