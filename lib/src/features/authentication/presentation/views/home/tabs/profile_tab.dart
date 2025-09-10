import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  bool biometricsOn = false;

  @override
  Widget build(BuildContext context) {
    const blue = Color(0xFF0092FF);
    const sub = Color(0xFF92939E);
    const divider = Color(0xFFF3F5F7);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            // Header: avatar + name + email
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border.all(color: divider, width: 2),
                          color: const Color(0xFFAEB3BE),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'BA',
                          style: TextStyle(
                            fontFamily: 'Creato Display',
                            fontSize: 32,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Positioned(
                        right: -2,
                        bottom: -2,
                        child: SvgPicture.asset(icQwidEdit, width: 24, height: 24),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Blessin Ayodele',
                    style: TextStyle(
                      fontFamily: 'Creato Display',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'blessingayodele@gmail.com',
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: sub,
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Column(
              children: [
                _SectionCard(
                  title: 'Account',
                  children: [
                    _tile(
                      icon: icQwidProfile,
                      title: 'Account Details',
                      subtitle: 'View and update your personal details',
                      trailing: SvgPicture.asset(icQwidArrowRight, width: 24, height: 24),
                    ),
                    _tile(
                      icon: icQwidIdentification,
                      title: 'Account Verification',
                      subtitle:
                      'Verify account to unlock more features and higher transaction limits',
                      trailing: SvgPicture.asset(icQwidUncompletedTier, width: 24, height: 24),
                    ),
                  ],
                ),
                _SectionCard(
                  title: 'Finances',
                  children: [
                    _tile(
                      icon: icQwidBank,
                      title: 'Transaction Limits',
                      subtitle:
                      'See how much you can send or receive based on your verification level',
                      trailing: SvgPicture.asset(icQwidArrowRight, width: 24, height: 24),
                    ),
                  ],
                ),
                _SectionCard(
                  title: 'Security',
                  children: [
                    _tile(
                      icon: icQwidLock,
                      title: 'Password & PIN',
                      subtitle: 'Manage your password and transaction PIN',
                      trailing: SvgPicture.asset(icQwidArrowRight, width: 24, height: 24),
                    ),
                    _tile(
                      icon: icQwidSecurity,
                      title: 'Two-Factor Authentication',
                      subtitle:
                      'Secure your account using one-time codes sent to your email or preferred authenticator app',
                      trailing: SvgPicture.asset(icQwidArrowRight, width: 24, height: 24),
                    ),
                    _tile(
                      icon: icQwidFingerprint,
                      title: 'Biometrics',
                      subtitle:
                      'Use Face ID or Fingerprint ID instead of a password to sign into your account',
                      trailing: Switch(
                        value: biometricsOn,
                        activeColor: blue,
                        onChanged: (v) => setState(() => biometricsOn = v),
                      ),
                    ),
                  ],
                ),
                _SectionCard(
                  title: 'Support',
                  children: [
                    _tile(
                      icon: icQwidNotification,
                      title: 'Notifications',
                      subtitle: 'Choose how you want to receive updates',
                      trailing: SvgPicture.asset(icQwidArrowRight, width: 24, height: 24),
                    ),
                    _tile(
                      icon: icQwidNotebook,
                      title: 'Qwid Guide',
                      subtitle: 'New here? Explore tips on how to use the app',
                      trailing: SvgPicture.asset(icQwidArrowRight, width: 24, height: 24),
                    ),
                    _tile(
                      icon: icQwidHelp,
                      title: 'Help',
                      subtitle: "Need help? Reach out to us. We're here for you.",
                      trailing: SvgPicture.asset(icQwidArrowRight, width: 24, height: 24),
                    ),
                    _tile(
                      icon: '',
                      title: 'Deactivate Account',
                      subtitle: "You can always come back when you're ready.",
                      trailing: SvgPicture.asset(icQwidArrowRight, width: 24, height: 24),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ListTile-like row with our style
  Widget _tile({
    required String icon,
    required String title,
    required String subtitle,
    required Widget trailing,
  }) {
    const sub = Color(0xFF92939E);
    const divider = Color(0xFFF3F5F7);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          icon.isEmpty ? SizedBox(width: 22, height: 22) : SvgPicture.asset(icon, width: 22, height: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: const TextStyle(
                            fontFamily: 'Creato Display',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          )),
                      const SizedBox(height: 2),
                      Text(subtitle,
                          style: const TextStyle(
                            fontFamily: 'Creato Display',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: sub,
                          )),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                trailing,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.children});
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    const divider = Color(0xFFF3F5F7);

    return Container(
      margin: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: const Border.fromBorderSide(BorderSide(color: divider)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section label (outside padding to align with tiles)
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
            child: Text(
              title,
              style: const TextStyle(
                fontFamily: 'Creato Display',
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}