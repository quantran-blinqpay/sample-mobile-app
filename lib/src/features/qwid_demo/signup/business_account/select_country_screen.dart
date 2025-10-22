import 'package:auto_route/auto_route.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:qwid/src/components/scaffold/app_scaffold.dart';
import 'package:qwid/src/components/text_field/search_text_field.dart';

import '../models/countries.dart';

class SelectCountryScreen extends StatefulWidget {
  const SelectCountryScreen({super.key});

  @override
  State<SelectCountryScreen> createState() =>
      _SelectCountryScreenState();
}

class _SelectCountryScreenState extends State<SelectCountryScreen> {
  final TextEditingController _searchController = TextEditingController();

  String _query = "";

  @override
  Widget build(BuildContext context) {
    final filteredCountries = countries
        .where((c) =>
        c["name"]!.toLowerCase().contains(_query.toLowerCase().trim()))
        .toList();

    return AppScaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ColoredBox(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Choose Your Location",
                  style: const TextStyle(
                    fontFamily: "Creato Display",
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF0A0A0C),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Let us know where you’ll be using Qwid from",
                  style: const TextStyle(
                    fontFamily: "Creato Display",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF92939E),
                  ),
                ),
              ),
              const SizedBox(height: 24),
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
              ...filteredCountries.map((country) {
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
              }),
            ],
          ),
        ),
      ),
    );
  }
}