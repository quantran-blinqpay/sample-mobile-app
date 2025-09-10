import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectStateBottomSheet extends StatefulWidget {
  const SelectStateBottomSheet({super.key});

  @override
  State<SelectStateBottomSheet> createState() =>
      _SelectCountryBottomSheetState();
}

class _SelectCountryBottomSheetState extends State<SelectStateBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, String>> states = [
    {"name": "Results"},
    {"name": "Bauchi"},
    {"name": "Bayelsa"},
    {"name": "Benue"},
    {"name": "Bomo"},
  ];

  String _query = "";

  @override
  Widget build(BuildContext context) {
    final filteredCountries = states
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
                  "Select State",
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
                    hintText: "Search for a state",
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
              const SizedBox(height: 8),
              // List of countries
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: filteredCountries.length,
                  itemBuilder: (context, index) {
                    final country = filteredCountries[index];
                    return ListTile(
                      title: Text(
                        country["name"]!,
                        style: const TextStyle(
                          fontFamily: "Creato Display",
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF0A0A0C),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context, country["name"]);
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