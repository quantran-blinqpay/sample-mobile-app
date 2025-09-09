import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  int _index = 0;

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
        preferredSize: const Size.fromHeight(52),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Replace with your actual logo asset
                // SvgPicture.asset(icQwidLogo, width: 100, height: 24),
                Text('qwid',
                    style: const TextStyle(
                      fontFamily: 'Creato Display',
                      fontSize: 20,
                      color: _blue,
                      fontWeight: FontWeight.w500,
                    )),
                Row(
                  children: [
                    // SvgPicture.asset(icQwidGift, width: 24, height: 24),
                    const Icon(Icons.card_giftcard_outlined, size: 22),
                    const SizedBox(width: 12),
                    // SvgPicture.asset(icQwidNotification, width: 24, height: 24),
                    const Icon(Icons.notifications_none_rounded, size: 22),
                    const SizedBox(width: 12),
                    // SvgPicture.asset(icQwidCloud, width: 24, height: 24),
                    const Icon(Icons.cloud_outlined, size: 22),
                  ],
                )
              ],
            ),
          ),
        ),
      ),

      body: Column(
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
          SizedBox(
            height: 210,
            child: PageView(
              controller: _page,
              onPageChanged: (i) => setState(() => _index = i),
              children: const [
                _AccountCard(
                  flagEmoji: "🇬🇧",
                  currency: "GBP",
                  bank: "Barclays Bank",
                  accountRef: "20-32-10 12345678",
                  balance: "£1,827,630.41",
                  statusChip: "Balance",
                  gradient: [Colors.black, Colors.black87],
                ),
                _AccountCard(
                  flagEmoji: "🇺🇸",
                  currency: "USD",
                  bank: "First American Bank",
                  accountRef: "0123456789",
                  balance: "\$0.00",
                  statusChip: "Your request is pending",
                  gradient: [Color(0xFF2E2E2E), Color(0xFF1C1C1C)],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          _Dots(index: _index, count: 6),

          const SizedBox(height: 12),
          Container(height: 8, color: _divider),
          const SizedBox(height: 12),

          // ---- Bank details title row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: const [
                Text(
                  "Your UK bank account details",
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
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
                    multiline: true,
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
          ),
        ],
      ),
    );
  }
}

// ========== widgets ==========

class _AccountCard extends StatelessWidget {
  const _AccountCard({
    required this.flagEmoji,
    required this.currency,
    required this.bank,
    required this.accountRef,
    required this.balance,
    required this.statusChip,
    required this.gradient,
  });

  final String flagEmoji;
  final String currency;
  final String bank;
  final String accountRef;
  final String balance;
  final String statusChip;
  final List<Color> gradient;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 8),
      child: Container(
        width: 260,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: flag + currency  |  eye icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Text(flagEmoji, style: const TextStyle(fontSize: 18)),
                  const SizedBox(width: 6),
                  Text(
                    currency,
                    style: const TextStyle(
                      fontFamily: 'Creato Display',
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ]),
                const Icon(Icons.visibility_off, color: Colors.white70, size: 18),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              "$bank  •  $accountRef",
              style: const TextStyle(
                fontFamily: 'Creato Display',
                fontSize: 10,
                color: Colors.white70,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Row(
              children: const [
                Icon(Icons.account_balance_wallet_outlined,
                    color: Colors.white70, size: 14),
                SizedBox(width: 4),
                Text("Balance",
                    style: TextStyle(
                      fontFamily: 'Creato Display',
                      fontSize: 10,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    )),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              balance,
              style: const TextStyle(
                fontFamily: 'Creato Display',
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 8),
            // action chips (Add/Send) – simplified
            Row(
              children: [
                _circleAction(Icons.add, "Add"),
                const SizedBox(width: 16),
                _circleAction(Icons.send_rounded, "Send"),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _circleAction(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 18, color: Colors.white),
        ),
        const SizedBox(height: 4),
        Text(label,
            style: const TextStyle(
              fontFamily: 'Creato Display',
              fontSize: 10,
              color: Colors.white70,
              fontWeight: FontWeight.w500,
            ))
      ],
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({required this.index, required this.count});
  final int index;
  final int count;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(count, (i) {
          final active = i == index;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: active ? _blue : const Color(0xFFE1E5EA),
              shape: BoxShape.circle,
            ),
          );
        }),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.value,
    this.multiline = false,
  });

  final String label;
  final String value;
  final bool multiline;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: _divider, width: 1)),
      ),
      child: Row(
        crossAxisAlignment:
        multiline ? CrossAxisAlignment.start : CrossAxisAlignment.center,
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
            .map((s) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: s,
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
        ...rows.map((r) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(r[0],
                  style: const TextStyle(
                    fontFamily: 'Creato Display',
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  )),
              const SizedBox(height: 2),
              Text(r[1],
                  style: const TextStyle(
                    fontFamily: 'Creato Display',
                    fontSize: 14,
                    color: _subText,
                    fontWeight: FontWeight.w400,
                  )),
            ],
          ),
        )),
      ],
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 12, 0, 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 24, color: active ? _blue : _subText),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Creato Display',
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: active ? _blue : _subText,
            ),
          ),
        ],
      ),
    );
  }
}