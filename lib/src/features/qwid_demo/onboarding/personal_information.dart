import 'package:auto_route/auto_route.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:qwid/src/features/qwid_demo/onboarding/select_country_code_bottom_sheet.dart';
import 'package:qwid/src/router/route_names.dart';
import 'package:qwid/src/router/router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage(name: personalInformationRoute)
class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _dobController = TextEditingController();
  final _referralController = TextEditingController();
  String _countryCode = '+93';
  String _flag = '🇦🇫';

  DateTime? _selectedDate;

  // bool get isFormValid {
  //   return _selectedDate != null
  //       && _firstNameController.text.isNotEmpty
  //       && _lastNameController.text.isNotEmpty
  //       && _mobileController.text.isNotEmpty;
  // }

  @override
  Widget build(BuildContext context) {
    final bool isFormValid = _firstNameController.text.isNotEmpty &&
        _lastNameController.text.isNotEmpty &&
        _mobileController.text.isNotEmpty &&
        _dobController.text.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text:
                      'Step 2 ',
                      style: TextStyle(
                        fontFamily: "Creato Display",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: 'of 4',
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              "Personal Information",
              style: const TextStyle(
                fontFamily: "Creato Display",
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: Color(0xFF0A0A0C),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Please enter your details as they appear on your Government-issued ID.",
              style: const TextStyle(
                fontFamily: "Creato Display",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF92939E),
              ),
            ),
            const SizedBox(height: 24),

            // First Name
            TextField(
              controller: _firstNameController,
              cursorColor: Color(0xff0092FF),
              decoration: const InputDecoration(
                labelText: "First Name",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffF3F5F7), width: 0.5), // custom color & thickness
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff0092FF), width: 1),
                ),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),

            // Last Name
            TextField(
              controller: _lastNameController,
              cursorColor: Color(0xff0092FF),
              decoration: const InputDecoration(
                labelText: "Last Name (Surname)",
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffF3F5F7), width: 0.5), // custom color & thickness
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff0092FF), width: 1),
                ),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),

            // Mobile with country code
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {
                      _openCountrySelector(context);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 12, 7),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                      "$_flag ",
                                      style: TextStyle(
                                        fontFamily: "Creato Display",
                                        fontSize: 24,
                                        color: Color(0xFF92939E),
                                      ),
                                    ),
                                    TextSpan(
                                      text: _countryCode,
                                      style: TextStyle(
                                        fontFamily: "Creato Display",
                                        fontSize: 16,
                                        color: Color(0xFF92939E),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 1),
                              SvgPicture.asset(
                                  icQwidArrowDown,
                                  width: 24,
                                  height: 24,
                                  color: Color(0xFF92939E),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 6),
                        Container(width: double.infinity, height: 0.5, color: Color(0xffF3F5F7))
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: TextField(
                    controller: _mobileController,
                    keyboardType: TextInputType.phone,
                    cursorColor: Color(0xff0092FF),
                    decoration: const InputDecoration(
                      labelText: "Mobile",
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffF3F5F7), width: 0.5), // custom color & thickness
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff0092FF), width: 1),
                      ),
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Date of Birth
            TextField(
              controller: _dobController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Date of Birth",
                suffixIcon: IconButton(
                  icon: SvgPicture.asset(
                    icQwidCalendar,
                    width: 24,
                    height: 24,
                    color: Color(0xFF92939E),
                  ),
                  onPressed: _pickDate,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffF3F5F7), width: 0.5), // custom color & thickness
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff0092FF), width: 1),
                ),
              ),
              onTap: _pickDate,
            ),
            const SizedBox(height: 16),

            // Referral Code (optional)
            TextField(
              controller: _referralController,
              decoration:
              const InputDecoration(
                labelText: "Referral Code (optional)",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffF3F5F7), width: 0.5), // custom color & thickness
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff0092FF), width: 1),
                ),
              ),
            ),
            const Spacer(),

            // Continue button
            SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: isFormValid
                      ? () {
                        context.router.push(AccountVerificationByPhoneScreenRoute());
                      }
                      : null,
                  style: ElevatedButton.styleFrom(
                    elevation: 0, // remove shadow
                    shadowColor: Colors.transparent, // optional, ensures no shadow color
                    backgroundColor:
                    isFormValid ? const Color(0xFF0092FF) : const Color(0xFFF4F4F4),
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
                      isFormValid ? Colors.white : const Color(0xFFA3A3A3),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showCupertinoDatePicker(
      context,
      initialDate: _selectedDate,
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dobController.text = withOrdinal(picked);
      });
    }
  }

  void _openCountrySelector(BuildContext context) async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const SelectCountryCodeBottomSheet(),
    );

    if (selected != null) {
      setState(() {
        _countryCode = selected.split(' ')[1];
        _flag = selected.split(' ')[0];
      });
    }
  }

  Future<DateTime?> showCupertinoDatePicker(BuildContext context,
      {DateTime? initialDate}) async {
    DateTime? picked;
    await showCupertinoModalPopup(
      context: context,
      builder: (popupContext) {
        return Container(
          height: 250,
          color: Colors.white,
          child: Column(
            children: [
              // Done button row
              Container(
                alignment: Alignment.centerRight,
                child: CupertinoButton(
                  child: const Text("Done"),
                  onPressed: () {
                    Navigator.pop(popupContext);
                  },
                ),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: initialDate ?? DateTime(2000),
                  minimumDate: DateTime(1900),
                  maximumDate: DateTime.now(),
                  onDateTimeChanged: (DateTime value) {
                    picked = value;
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
    return picked;
  }

  String withOrdinal(DateTime d) {
    final day = d.day;
    final suffix = (day >= 11 && day <= 13)
        ? 'th'
        : {1: 'st', 2: 'nd', 3: 'rd'}[day % 10] ?? 'th';
    final monthYear = DateFormat('MMMM y', 'en_US').format(d); // "July 1990"
    return '$day$suffix $monthYear'; // "19th July 1990"
  }
}