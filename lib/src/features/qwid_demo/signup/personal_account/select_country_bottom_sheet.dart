import 'package:auto_route/auto_route.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:qwid/src/components/text_field/search_text_field.dart';

import '../models/countries.dart';

class SelectCountryBottomSheet extends StatefulWidget {
  const SelectCountryBottomSheet({super.key});

  @override
  State<SelectCountryBottomSheet> createState() =>
      _SelectCountryBottomSheetState();
}

class _SelectCountryBottomSheetState extends State<SelectCountryBottomSheet> {
  final TextEditingController _searchController = TextEditingController();

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
                child: SearchTextField(
                  controller: _searchController,
                  onChanged: (val) => setState(() => _query = val),
                  onClear: () => setState(() => _query = ""),
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
                      onTap: () {
                        context.router.pop(country["name"]);
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