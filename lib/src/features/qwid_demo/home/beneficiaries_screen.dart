import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:qwid/src/router/route_names.dart';

@RoutePage(name: beneficiariesRoute)
class BeneficiariesScreen extends StatefulWidget {
  const BeneficiariesScreen({super.key});

  @override
  State<BeneficiariesScreen> createState() => _BeneficiariesScreenState();
}

class _BeneficiariesScreenState extends State<BeneficiariesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  final List<Map<String, String>> beneficiaries = [
    {"name": "Peter Parker", "email": "peterparker@gmail.com"},
    {"name": "Tony Stark", "email": "tonystark@stark.com"},
    {"name": "Steve Rogers", "email": "captain@avengers.com"},
    {"name": "Natasha Romanoff", "email": "blackwidow@shield.com"},
    {"name": "Bruce Banner", "email": "hulk@avengers.com"},
    {"name": "Clint Barton", "email": "hawkeye@shield.com"},
  ];

  final List<Map<String, String>> frequents = [
    {"name": "Peter Parker", "email": "blessingayodele@gmail.com"},
    {"name": "Temitope Olaniyan", "email": "temiolaniyan@gmail.com"},
    {"name": "Ngozi Umeh", "email": "ngoziumehl@gmail.com"},
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredBeneficiaries =
        beneficiaries
            .where((b) => b["name"]!.toLowerCase().contains(_searchQuery))
            .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF7F8FA),
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextField(
            controller: _searchController,
            cursorColor: const Color(0xff0092FF),
            cursorHeight: 14,
            decoration: InputDecoration(
              hintText: "Search for a beneficiary",
              border: InputBorder.none,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(icSearch, color: Color(0xffAEB3BE)),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Color(0xff0092FF)),
            onPressed: () {
              // TODO: Add beneficiary
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    _buildChip("Qwid", true),
                    const SizedBox(width: 8),
                    _buildChip("External accounts", false),
                    const SizedBox(width: 8),
                    _buildChip("My account", false),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Beneficiaries Section
            Expanded(
              child:
                  filteredBeneficiaries.isEmpty
                      ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(icQwidEmptyBene, width: 120, height: 120),
                            Text(
                              "No results found",
                              style: TextStyle(
                                fontFamily: "Creato Display",
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "We didn’t find any contacts matching your search.\nTry again with a different name.",
                              style: TextStyle(
                                fontFamily: "Creato Display",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff92939E),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                      : Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: CustomScrollView(
                          slivers: [
                            SliverPadding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                              sliver: SliverList(
                                delegate: SliverChildBuilderDelegate(
                                      (BuildContext context, int index) {
                                    return Text(
                                      'Frequents',
                                      style: const TextStyle(
                                        fontFamily: "Creato Display",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    );
                                  },
                                  // Or, uncomment the following line:
                                  childCount: 1,
                                ),
                              ),
                            ),
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                                  final frequent = frequents[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: const Color(0xFFF3F5F7),
                                          child: Text(
                                            frequent["name"]![0],
                                            style: const TextStyle(
                                              fontFamily: "Creato Display",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xffAEB3BE),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                frequent["name"]!,
                                                style: const TextStyle(
                                                  fontFamily: "Creato Display",
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                frequent["email"]!,
                                                style: const TextStyle(
                                                  fontFamily: "Creato Display",
                                                  fontSize: 14,
                                                  color: Color(0xFF92939E),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.more_vert,
                                            color: Colors.black54,
                                          ),
                                          onPressed: () {
                                            // TODO: Add options menu
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                // Or, uncomment the following line:
                                childCount: frequents.length,
                              ),
                            ),
                            SliverPadding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                              sliver: SliverList(
                                delegate: SliverChildBuilderDelegate(
                                      (BuildContext context, int index) {
                                    return Text(
                                      'All Beneficiaries',
                                      style: const TextStyle(
                                        fontFamily: "Creato Display",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    );
                                  },
                                  // Or, uncomment the following line:
                                  childCount: 1,
                                ),
                              ),
                            ),
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                                  final beneficiary = filteredBeneficiaries[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: const Color(0xFFF3F5F7),
                                          child: Text(
                                            beneficiary["name"]![0],
                                            style: const TextStyle(
                                              fontFamily: "Creato Display",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xffAEB3BE),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                beneficiary["name"]!,
                                                style: const TextStyle(
                                                  fontFamily: "Creato Display",
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                beneficiary["email"]!,
                                                style: const TextStyle(
                                                  fontFamily: "Creato Display",
                                                  fontSize: 14,
                                                  color: Color(0xFF92939E),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.more_vert,
                                            color: Colors.black54,
                                          ),
                                          onPressed: () {
                                            // TODO: Add options menu
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                // Or, uncomment the following line:
                                childCount: filteredBeneficiaries.length,
                              ),
                            )
                          ],
                        ),
                      )
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF0092FF) : const Color(0xFFF4F4F4),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: "Creato Display",
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: isSelected ? Colors.white : const Color(0xFF8C909C),
        ),
      ),
    );
  }
}
