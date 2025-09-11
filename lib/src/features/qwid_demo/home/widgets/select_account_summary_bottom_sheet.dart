import 'package:country_flags/country_flags.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qwid/src/features/qwid_demo/home/widgets/payment_success.dart';
import 'package:qwid/src/features/qwid_demo/onboarding/models/countries.dart';

class SelectAccountSummaryBottomSheet extends StatefulWidget {
  const SelectAccountSummaryBottomSheet({super.key});

  @override
  State<SelectAccountSummaryBottomSheet> createState() =>
      _SelectAccountSummaryBottomSheetState();
}

class _SelectAccountSummaryBottomSheetState extends State<SelectAccountSummaryBottomSheet> {
  final TextEditingController _searchController = TextEditingController();

  String _query = "";
  List<String> _selecteds = [];

  @override
  Widget build(BuildContext context) {
    final filteredCountries = countries
        .where((c) =>
        c["name"]!.toLowerCase().contains(_query.toLowerCase().trim()))
        .toList();

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SafeArea(
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
            const SizedBox(height: 32),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Currencies",
                style: const TextStyle(
                  fontFamily: "Creato Display",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF0A0A0C),
                ),
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(height: 8),
            // List of countries
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 6,
                itemBuilder: (context, index) {
                  final country = filteredCountries[index];
                  return ListTile(
                    leading: CountryFlag.fromCurrencyCode(
                      country["currency"]!,
                      width: 24,
                      height: 15,
                      shape: Rectangle(),
                    ),
                    title: Text(
                      country["name"]!,
                      style: const TextStyle(
                        fontFamily: "Creato Display",
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF0A0A0C),
                      ),
                    ),
                    trailing: GestureDetector(
                        onTap: (){
                          setState(() {
                            if(_selecteds.contains(country["name"])){
                              _selecteds.remove(country["name"]);
                            } else{
                              _selecteds.add(country["name"]!);
                            }
                          });
                        },
                        child: SvgPicture.asset(_selecteds.contains(country["name"]) ? icQwidCheckmark : icQwidUncheckmark)),
                    onTap: () {
                      Navigator.pop(context, country["name"]);
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  height: 52,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:  () {
                      Navigator.pop(context);
                      if (mounted) {
                        showDialog(
                          context: context,
                          builder: (_) => PaymentSuccess(),
                        );
                      }
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
                      'Make Payment',
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
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  final bool _canSubmit = true;
}