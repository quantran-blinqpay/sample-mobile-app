import 'package:auto_route/auto_route.dart';
import 'package:qwid/src/components/text_field/search_text_field.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectStateBottomSheet extends StatefulWidget {
  const SelectStateBottomSheet({super.key, this.title});
  final String? title;

  @override
  State<SelectStateBottomSheet> createState() =>
      _SelectCountryBottomSheetState();
}

class _SelectCountryBottomSheetState extends State<SelectStateBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, String>> states = [
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
                child: SearchTextField(
                  controller: _searchController,
                  onChanged: (val) => setState(() => _query = val),
                  onClear: () => setState(() => _query = ""),
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
                    return Container(
                      decoration: BoxDecoration(
                        color: widget.title == country["name"] ? Color(0xffFCFCFC) : Colors.transparent,          // custom background
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
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
                        trailing: widget.title == country["name"] ? SvgPicture.asset(
                          icQwidCheck,
                          fit: BoxFit.none,
                        ) : SizedBox(),
                      ),
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