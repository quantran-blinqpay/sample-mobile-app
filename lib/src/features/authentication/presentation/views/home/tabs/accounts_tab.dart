import 'package:country_flags/country_flags.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:qwid/src/features/authentication/presentation/views/home/widgets/account_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qwid/src/features/authentication/presentation/views/home/widgets/inform_update_account.dart';

// If you already have these in your app, import your constants instead.
const _blue = Color(0xFF0092FF);
const _subText = Color(0xFF92939E);
const _divider = Color(0xFFF3F5F7);

class AccountsTab extends StatefulWidget {
  const AccountsTab({super.key});

  @override
  State<AccountsTab> createState() => _AccountsTabState();
}

class _AccountsTabState extends State<AccountsTab> {
  final _page = PageController(viewportFraction: 0.74);

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((value) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (_) => InformUpdateAccount(),
        );
      }
    });
  }

  @override
  void dispose() {
    _page.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // Top app bar – same visual as HomeTab
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(52),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(icQwidLogo, width: 100, height: 24),
                Row(
                  children: [
                    SvgPicture.asset(icQwidGift,
                        width: 24, height: 24),
                    SizedBox(width: 12),
                    SvgPicture.asset(icQwidNotification, width: 24, height: 24),
                    SizedBox(width: 12),
                    SvgPicture.asset(icQwidCloud, width: 24, height: 24),
                  ],
                )
              ],
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---- My Accounts + add
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "My Accounts",
                    style: TextStyle(
                      fontFamily: 'Creato Display',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  Icon(Icons.add, color: _blue),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // ---- Cards carousel
            // Wallet PageView
            AccountCarousel(
              onPageChanged: (index){
                setState(() {
                  _currentPage = index;
                });
              },
            ),
            _currentPage == 1 ? _buildPendingContent() : _buildNormalContent(),
          ],
        ),
      ),
    );
  }

  int _currentPage = 0;

  Widget _buildPendingContent(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 12),
        Container(height: 8, color: _divider),
        SizedBox(height: 120),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Image.asset(icQwidCup, width: 91, height: 64),
              SizedBox(height: 16),
              Text('Your account is still processing',
                style: TextStyle(
                  fontFamily: 'Creato Display',
                  fontSize: 20,
                  color: Color(0xff0A0A0C),
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4),
              Text("We're still working on your USD account. Please be \npatient, you'll get an email once there's an update or if we need more information.",
                style: TextStyle(
                  fontFamily: 'Creato Display',
                  fontSize: 14,
                  color: Color(0xff92939E),
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNormalContent(){
    return Column(
      children: [
        const SizedBox(height: 12),
        Container(height: 8, color: _divider),
        const SizedBox(height: 12),

        // ---- Bank details title row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              CountryFlag.fromCountryCode("NG", width: 20, height: 14),
              Text(
                " Your NG bank account details",
                style: TextStyle(
                  fontFamily: 'Creato Display',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // ---- Details list with Copy buttons
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              _DetailRow(label: "Name", value: "Peter Parker"),
              _DetailRow(label: "Account number", value: "200116634584"),
              _DetailRow(label: "Sort code", value: "23-14-70"),
              _DetailRow(
                label: "IBAN",
                value: "GB58 TRWI 2314 7093 4833 92",
              ),
              _DetailRow(label: "Swift/BIC", value: "TRWIGB2LXXX"),
              _DetailRow(label: "Bank name", value: "Clear Junction Limited"),
              _DetailRow(
                label: "Bank address",
                value:
                "4th Floor Imperial House, 15 Kingsway,\nLondon, United Kingdom, WC2B 6UN",
              ),

              const SizedBox(height: 16),

              // ---- Info card (arrivals & fees)
              _InfoCard(
                sections: const [
                  _InfoSection(
                    title: "When will the money arrive?",
                    rows: [
                      ["From the UK (Local)", "Usually 1 working day"],
                      [
                        "From outside the UK (Swift)",
                        "Sometimes up to 5 working days"
                      ],
                    ],
                  ),
                  _InfoSection(
                    title: "Transaction fee?",
                    rows: [
                      ["From the UK (Local)", "No fee"],
                      ["From outside the UK (Swift)", "No fee"],
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16 + 8), // space above bottom bar
            ],
          ),
        ),
      ],
    );
  }
}

// ========== widgets ==========

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                      fontFamily: 'Creato Display',
                      fontSize: 12,
                      color: _subText,
                      fontWeight: FontWeight.w400,
                    )),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontFamily: 'Creato Display',
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            height: 32,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: _divider,
                side: const BorderSide(color: _divider),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: value));
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$label copied'),
                    duration: const Duration(milliseconds: 800),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: const Text(
                "Copy",
                style: TextStyle(
                  fontFamily: 'Creato Display',
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.sections});
  final List<_InfoSection> sections;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: const Border.fromBorderSide(BorderSide(color: _divider)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: sections
            .asMap().entries.map((s) => Padding(
          padding: EdgeInsets.only(bottom: s.key == sections.length - 1 ? 0 : 16),
          child: s.value,
        ))
            .toList(),
      ),
    );
  }
}

class _InfoSection extends StatelessWidget {
  const _InfoSection({required this.title, required this.rows});
  final String title;
  final List<List<String>> rows;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
              fontFamily: 'Creato Display',
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            )),
        const SizedBox(height: 10),
        ...rows.asMap().entries.map((r) => Padding(
          padding: EdgeInsets.only(bottom: r.key == rows.length - 1 ? 0 : 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(r.value[0],
                  style: const TextStyle(
                    fontFamily: 'Creato Display',
                    fontSize: 14,
                    color: _subText,
                    fontWeight: FontWeight.w500,
                  )),
              const SizedBox(height: 2),
              Text(r.value[1],
                  style: const TextStyle(
                    fontFamily: 'Creato Display',
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  )),
            ],
          ),
        )),
      ],
    );
  }
}