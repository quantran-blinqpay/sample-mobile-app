import 'package:flutter/material.dart';

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
    const cardBg = Colors.white;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black, size: 28),
          onPressed: () => Navigator.maybePop(context),
        ),
      ),
      body: Column(
        children: [
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
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          color: blue,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.edit, color: Colors.white, size: 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Blessing Ayodele',
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
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                _SectionCard(
                  title: 'Account',
                  children: [
                    _tile(
                      icon: Icons.person_outline,
                      title: 'Account Details',
                      subtitle: 'View and update your personal details',
                      trailing: const Icon(Icons.chevron_right, color: Colors.black54),
                    ),
                    _tile(
                      icon: Icons.verified_outlined,
                      title: 'Account Verification',
                      subtitle:
                      'Verify account to unlock more features and higher transaction limits',
                      trailing: const Icon(Icons.verified, color: Color(0xFF4CD964)),
                    ),
                  ],
                ),
                _SectionCard(
                  title: 'Finances',
                  children: [
                    _tile(
                      icon: Icons.account_balance_outlined,
                      title: 'Transaction Limits',
                      subtitle:
                      'See how much you can send or receive based on your verification level',
                      trailing: const Icon(Icons.chevron_right, color: Colors.black54),
                    ),
                  ],
                ),
                _SectionCard(
                  title: 'Security',
                  children: [
                    _tile(
                      icon: Icons.lock_outline,
                      title: 'Password & PIN',
                      subtitle: 'Manage your password and transaction PIN',
                      trailing: const Icon(Icons.chevron_right, color: Colors.black54),
                    ),
                    _tile(
                      icon: Icons.phonelink_lock_outlined,
                      title: 'Two-Factor Authentication',
                      subtitle:
                      'Secure your account using one-time codes sent to your email or preferred authenticator app',
                      trailing: const Icon(Icons.chevron_right, color: Colors.black54),
                    ),
                    _tile(
                      icon: Icons.fingerprint_outlined,
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
                      icon: Icons.notifications_none_rounded,
                      title: 'Notifications',
                      subtitle: 'Choose how you want to receive updates',
                      trailing: const Icon(Icons.chevron_right, color: Colors.black54),
                    ),
                    _tile(
                      icon: Icons.menu_book_outlined,
                      title: 'Qwid Guide',
                      subtitle: 'New here? Explore tips on how to use the app',
                      trailing: const Icon(Icons.chevron_right, color: Colors.black54),
                    ),
                    _tile(
                      icon: Icons.help_outline,
                      title: 'Help',
                      subtitle: "Need help? Reach out to us. We're here for you.",
                      trailing: const Icon(Icons.chevron_right, color: Colors.black54),
                    ),
                    _tile(
                      icon: Icons.cancel_presentation_outlined,
                      title: 'Deactivate Account',
                      subtitle: "You can always come back when you're ready.",
                      trailing: const Icon(Icons.chevron_right, color: Colors.black54),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ListTile-like row with our style
  Widget _tile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget trailing,
  }) {
    const sub = Color(0xFF92939E);
    const divider = Color(0xFFF3F5F7);

    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: divider)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 22, color: sub),
          const SizedBox(width: 12),
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
          const Divider(height: 1, color: divider),
          ...children,
        ],
      ),
    );
  }
}

class _BottomItem extends StatelessWidget {
  const _BottomItem({
    required this.icon,
    required this.label,
    this.active = false,
  });

  final IconData icon;
  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    const blue = Color(0xFF0092FF);
    const sub = Color(0xFF92939E);

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 12, 0, 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 24, color: active ? blue : sub),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Creato Display',
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: active ? blue : sub,
            ),
          ),
        ],
      ),
    );
  }
}