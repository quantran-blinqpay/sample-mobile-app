import 'package:designerwardrobe/src/configs/app_themes/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectCountryCodeBottomSheet extends StatefulWidget {
  const SelectCountryCodeBottomSheet({super.key});

  @override
  State<SelectCountryCodeBottomSheet> createState() =>
      _SelectCountryCodeBottomSheetState();
}

class _SelectCountryCodeBottomSheetState extends State<SelectCountryCodeBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, String>> countries = [
    {"name": "Afghanistan", "flag": "🇦🇫", "code": "+93"},
    {"name": "Albania", "flag": "🇦🇱", "code": "+355"},
    {"name": "Algeria", "flag": "🇩🇿", "code": "+213"},
    {"name": "Andorra", "flag": "🇦🇩", "code": "+376"},
    {"name": "Angola", "flag": "🇦🇴", "code": "+244"},
    {"name": "Antigua and Barbuda", "flag": "🇦🇬", "code": "+1268"},
    {"name": "Argentina", "flag": "🇦🇷", "code": "+54"},
    {"name": "Armenia", "flag": "🇦🇲", "code": "+374"},
    {"name": "Australia", "flag": "🇦🇺", "code": "+61"},
    {"name": "Austria", "flag": "🇦🇹", "code": "+43"},
  ];

  String _query = "";

  @override
  Widget build(BuildContext context) {
    final filteredCountries = countries
        .where((c) =>
        c["name"]!.toLowerCase().contains(_query.toLowerCase().trim()))
        .toList();

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.9,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
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
                  "Select Country",
                  style: TextStyle(
                    fontFamily: "Creato Display",
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF27272A),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 12),

              // Search bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _searchController,
                  onChanged: (val) => setState(() => _query = val),
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SvgPicture.asset(icQwidSearch, width: 5, height: 5),
                    ),
                    hintText: "Search for a country",
                    hintStyle: const TextStyle(
                      fontFamily: "Creato Display",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF8C909C),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    filled: true,
                    fillColor: const Color(0xFFFAFAFA),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Countries",
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
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: filteredCountries.length,
                  itemBuilder: (context, index) {
                    final country = filteredCountries[index];
                    return ListTile(
                      leading: Text(
                        country["flag"]!,
                        style: const TextStyle(fontSize: 24),
                      ),
                      title: RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: country["name"]!,
                              style: const TextStyle(
                                fontFamily: "Creato Display",
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF0A0A0C),
                              ),
                            ),
                            TextSpan(
                              text:
                              ' (${country["code"]!})',
                              style: const TextStyle(
                                fontFamily: "Creato Display",
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF92939E),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context, '${country["flag"]} ${country["code"]}');
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}