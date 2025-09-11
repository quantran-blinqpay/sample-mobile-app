import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:country_flags/country_flags.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:qwid/src/router/route_names.dart';
import 'package:qwid/src/router/router.dart';

@RoutePage(name: userInformation)
class UserInformationScreen extends StatefulWidget {
  const UserInformationScreen({super.key});

  @override
  State<UserInformationScreen> createState() =>
      _UserInformationScreenState();
}

class _UserInformationScreenState extends State<UserInformationScreen> {
  String? _employeeStatus;
  String? _answer;

  final List<String> employeeStatus = [
    "Employed",
    "Self-Employed",
    "Unemployed",
    "Retired",
    "Student",
  ];

  final List<String> answers = [
    "Yes",
    "No",
  ];

  bool get _isFormValid =>
      _employeeStatus != null &&
          _answer != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text:
                      'Step 1 ',
                      style: TextStyle(
                        fontFamily: "Creato Display",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: 'of 3',
                      style: TextStyle(
                        fontFamily: "Creato Display",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff92939E),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "User Information",
                  style: const TextStyle(
                    fontFamily: "Creato Display",
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF0A0A0C),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Tell us more about yourself. These details help us complete your registration and personalise your Qwid experience.",
                  style: const TextStyle(
                    fontFamily: "Creato Display",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF92939E),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 0.5, color: Color(0xffEDEFF2))),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Country of Residence', style: TextStyle(
                  fontFamily: 'Creato Display',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF92939E),
                  )),
                SizedBox(height: 8),
                Row(
                  children: [
                    CountryFlag.fromCountryCode(
                      "NG",
                      width: 20,
                      height: 14,
                    ),
                    SizedBox(width: 8),
                    Text('Nigeria', style: TextStyle(
                      fontFamily: 'Creato Display',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF92939E),
                      ),
                    ),
                  ],
                ),
              ]
            ),
          ),
          // Question 1
          DropdownButtonFormField2<String>(
            decoration: InputDecoration(
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xffF3F5F7), width: 0.5), // custom color & thickness
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xff0092FF), width: 1),
              ),
              contentPadding: const EdgeInsets.only(bottom: 16),
            ),
            isExpanded: true,
            hint: const Text(
              'Employment Status',
              style: TextStyle(fontSize: 14),
            ),
            items: employeeStatus
                .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                    item,
                    style: const TextStyle(fontFamily: "Creato Display", fontSize: 16, fontWeight: FontWeight.w400)))).toList(),
            value: _employeeStatus,
            onChanged: (value) {
              if(value != null){
                setState(() {
                  _employeeStatus = value;
                });
              }
            },
            buttonStyleData: const ButtonStyleData(
              padding: EdgeInsets.only(right: 8),
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1),
                border: Border.all(width: 0.5, color: Color(0xffEDEFF2)),
                color: Colors.white,
              ),
            ),
            menuItemStyleData: MenuItemStyleData(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                selectedMenuItemBuilder: (BuildContext context, Widget child) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1),
                        color: Colors.grey.withAlpha(20),
                      ),
                      child: Row(
                        children: [
                          child,
                          Spacer(),
                          SvgPicture.asset(
                            icQwidCheck,
                            fit: BoxFit.none,
                          ),
                          SizedBox(width: 15)
                        ],
                      )),
                )
            ),
            iconStyleData: IconStyleData(
              icon: Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: SvgPicture.asset(
                  icQwidArrowDown,
                  fit: BoxFit.none,
                ),
              ),
              openMenuIcon: Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: SvgPicture.asset(
                  icQwidArrowUp,
                  fit: BoxFit.none,
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          // Question 2
          DropdownButtonFormField2<String>(
            decoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xffF3F5F7), width: 0.5), // custom color & thickness
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xff0092FF), width: 1),
              ),
              contentPadding: const EdgeInsets.only(bottom: 16),
            ),
            isExpanded: true,
            hint: const Text(
              'Are you a Political Exposed Person (PEP)',
              style: TextStyle(fontSize: 14),
            ),
            items: answers
                .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                    item,
                    style: const TextStyle(fontFamily: "Creato Display", fontSize: 16, fontWeight: FontWeight.w400)))).toList(),
            value: _answer,
            onChanged: (value) {
              if(value != null){
                setState(() {
                  _answer = value;
                });
              }
            },
            buttonStyleData: const ButtonStyleData(
              padding: EdgeInsets.only(right: 8),
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1),
                border: Border.all(width: 0.5, color: Color(0xffEDEFF2)),
                color: Colors.white,
              ),
            ),
            menuItemStyleData: MenuItemStyleData(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                selectedMenuItemBuilder: (BuildContext context, Widget child) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1),
                        color: Colors.grey.withAlpha(20),
                      ),
                      child: Row(
                        children: [
                          child,
                          Spacer(),
                          SvgPicture.asset(
                            icQwidCheck,
                            fit: BoxFit.none,
                          ),
                          SizedBox(width: 15)
                        ],
                      )),
                )
            ),
            iconStyleData: IconStyleData(
              icon: Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: SvgPicture.asset(
                  icQwidArrowDown,
                  fit: BoxFit.none,
                ),
              ),
              openMenuIcon: Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: SvgPicture.asset(
                  icQwidArrowUp,
                  fit: BoxFit.none,
                ),
              ),
            ),
          ),
          // Answer 2
          const Spacer(),

          // Submit button
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _isFormValid
                      ? () {
                    context.router.push(IdentityVerificationScreenRoute());
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    elevation: 0, // remove shadow
                    shadowColor: Colors.transparent, // optional, ensures no shadow color
                    backgroundColor: _isFormValid
                        ? const Color(0xFF0092FF)
                        : const Color(0xFFF4F4F4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      fontFamily: "Creato Display",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color:
                      _isFormValid ? Colors.white : const Color(0xFFA3A3A3),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

}