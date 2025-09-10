import 'package:designerwardrobe/src/configs/app_themes/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BeneficiariesTab extends StatefulWidget {
  const BeneficiariesTab({super.key});

  @override
  State<BeneficiariesTab> createState() => _BeneficiariesTabState();
}

class _BeneficiariesTabState extends State<BeneficiariesTab> {
  final _search = TextEditingController();
  int _chipIndex = 0; // 0 = Qwid, 1 = External accounts, 2 = My account

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const colorText = Color(0xFF0A0A0C);
    const colorSubText = Color(0xFF92939E);
    const colorBlue = Color(0xFF0F77F0); // selected chip + CTA
    const colorBlue2 = Color(0xFF0092FF); // link/brand (kept from sign in)
    const chipGreyBg = Color(0xFFFAFAFA);
    const borderGrey = Color(0xFFF3F5F7);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 0, // status bar only (per design)
      ),
      body: Column(
        children: [
          // Search row
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: chipGreyBg,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        SvgPicture.asset(icQwidSearch, width: 18, height: 18),
                        const SizedBox(width: 6),
                        Expanded(
                          child: TextField(
                            controller: _search,
                            cursorColor: colorBlue2,
                            decoration: const InputDecoration(
                              hintText: 'Search for a beneficiary',
                              hintStyle: TextStyle(
                                fontFamily: 'Creato Display',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF8C909C),
                              ),
                              border: InputBorder.none,
                              isDense: true,
                            ),
                            style: const TextStyle(
                              fontFamily: 'Creato Display',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Small add button (plus)
                SizedBox(
                  width: 24,
                  height: 24,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.add, size: 20, color: colorBlue),
                    onPressed: () {
                      // TODO: create new beneficiary
                    },
                  ),
                ),
              ],
            ),
          ),

          // Chips row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                _Chip(
                  text: 'Qwid',
                  selected: _chipIndex == 0,
                  onTap: () => setState(() => _chipIndex = 0),
                ),
                const SizedBox(width: 4),
                _Chip(
                  text: 'External accounts',
                  selected: _chipIndex == 1,
                  onTap: () => setState(() => _chipIndex = 1),
                ),
                const SizedBox(width: 4),
                _Chip(
                  text: 'My account',
                  selected: _chipIndex == 2,
                  onTap: () => setState(() => _chipIndex = 2),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 24),
                // Empty state illustration placeholder
                // Replace with your SVG/PNG asset if provided
                Container(
                  width: 120,
                  height: 120,
                  alignment: Alignment.center,
                  child: Image.asset(icQwidBook, width: 80, height: 80),
                ),
                const SizedBox(height: 16),
                const Text(
                  'No Beneficiaries',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Creato Display',
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 8),
                const SizedBox(
                  width: 320,
                  child: Text(
                    "You haven’t added any beneficiaries. Add your first beneficiary to make sending money easier.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Creato Display',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: colorSubText,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  height: 40,
                  child: FilledButton(
                    onPressed: () {
                      // TODO: navigate to Add Beneficiary
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: colorBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                    child: const Text(
                      'Add a Beneficiary',
                      style: TextStyle(
                        fontFamily: 'Creato Display',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.text,
    required this.selected,
    required this.onTap,
  });

  final String text;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const colorBlue = Color(0xFF0F77F0);
    const chipGreyBg = Color(0xFFFAFAFA);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: selected ? colorBlue : chipGreyBg,
          borderRadius: BorderRadius.circular(50),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Creato Display',
            fontSize: 14,
            fontWeight: selected ? FontWeight.w500 : FontWeight.w400,
            color: selected ? Colors.white : const Color(0xFF8C909C),
          ),
        ),
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
    const colorBlue = Color(0xFF0092FF);
    const colorSubText = Color(0xFF92939E);

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 12, 0, 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 24, color: active ? colorBlue : colorSubText),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Creato Display',
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: active ? colorBlue : colorSubText,
            ),
          ),
        ],
      ),
    );
  }
}