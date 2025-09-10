import 'package:country_flags/country_flags.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qwid/src/features/authentication/presentation/views/home/widgets/select_account_summary_bottom_sheet.dart';
import 'package:qwid/src/features/authentication/presentation/views/onboarding/models/countries.dart';

class AccountDetailBottomSheet extends StatefulWidget {
  const AccountDetailBottomSheet({super.key});

  @override
  State<AccountDetailBottomSheet> createState() =>
      _AccountDetailBottomSheetState();
}

class _AccountDetailBottomSheetState extends State<AccountDetailBottomSheet> {

  String _query = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          SizedBox(
            width: double.infinity,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ),

          // Title
          SizedBox(
            width: double.infinity,
            child: Center(
              child: const Text(
                "Account summary",
                style: TextStyle(
                  fontFamily: "Creato Display",
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF27272A),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Center(
              child: const Text(
                "Here’s a summary for the creation of CAD account.",
                style: TextStyle(
                  fontFamily: "Creato Display",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF87849F),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 36),
          SizedBox(
            width: double.infinity,
            child: Center(
              child: DecoratedBox(decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xffF4F9FB)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CountryFlag.fromCurrencyCode(
                    "CAD",
                    width: 48,
                    height: 48,
                    shape: Circle(),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Search bar
          SizedBox(
            width: double.infinity,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "CAD Account details",
                  style: const TextStyle(
                    fontFamily: "Creato Display",
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1D1D20),
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildItems("Creation fee", "\$0.99 "),
                const SizedBox(height: 32),
                _buildItems("Creation date", "11 Sept, 2024 at 02:10 am"),
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
              child: SizedBox(
                height: 52,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:  () {
                    _openAccountSummary(context);
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: const Color(0xff0092FF),
                    disabledBackgroundColor: Color(0xFFF4F4F4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontFamily: 'Creato Display',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: _canSubmit ? Colors.white : Color(0xFFA3A3A3),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildItems(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: "Creato Display",
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0xFF92939E),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          content,
          style: const TextStyle(
            fontFamily: "Creato Display",
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF1D1D20),
          ),
        ),
      ],
    );
  }

  final bool _canSubmit = true;

  void _openAccountSummary(BuildContext context) async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const SelectAccountSummaryBottomSheet(),
    );

    if (selected != null) {
      // _countryController.text = selected;
      // context.router.push(PersonalInformationScreenRoute());
    }
  }
}