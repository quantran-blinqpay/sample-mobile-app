import 'package:auto_route/annotations.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_images.dart';
import 'package:designerwardrobe/src/features/authentication/presentation/views/onboarding/loading_bottom_sheet.dart';
import 'package:designerwardrobe/src/router/route_names.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage(name: securityQuestionsRoute)
class SecurityQuestionsScreen extends StatefulWidget {
  const SecurityQuestionsScreen({super.key});

  @override
  State<SecurityQuestionsScreen> createState() =>
      _SecurityQuestionsScreenState();
}

class _SecurityQuestionsScreenState extends State<SecurityQuestionsScreen> {
  String? _question1;
  String? _question2;
  final _answer1Controller = TextEditingController();
  final _answer2Controller = TextEditingController();

  final List<String> questions = [
    "What was your childhood nickname?",
    "What is the name of your first pet?",
    "What is your mother’s maiden name?",
    "What is your favorite teacher’s name?",
  ];

  bool get _isFormValid =>
      _question1 != null &&
          _question2 != null &&
          _answer1Controller.text.isNotEmpty &&
          _answer2Controller.text.isNotEmpty;

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
                      'Step 4 ',
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
                  "Set up Security Questions",
                  style: const TextStyle(
                    fontFamily: "Creato Display",
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF0A0A0C),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Add an extra layer of security by setting a question only you can answer.",
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
              'Question 1',
              style: TextStyle(fontSize: 14),
            ),
            items: questions
                .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                    item,
                    style: const TextStyle(fontFamily: "Creato Display", fontSize: 16, fontWeight: FontWeight.w400)))).toList(),
            value: _question1,
            onChanged: (value) {
              if(value != null){
                setState(() {
                  _question1 = value;
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
          // Answer 1
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              cursorColor: Color(0xff0092FF),
              controller: _answer1Controller,
              decoration: const InputDecoration(
                labelText: "Answer",
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
          const SizedBox(height: 16),

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
              'Question 2',
              style: TextStyle(fontSize: 14),
            ),
            items: questions
                .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                    item,
                    style: const TextStyle(fontFamily: "Creato Display", fontSize: 16, fontWeight: FontWeight.w400)))).toList(),
            value: _question2,
            onChanged: (value) {
              if(value != null){
                setState(() {
                  _question2 = value;
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              cursorColor: Color(0xff0092FF),
              controller: _answer2Controller,
              decoration: const InputDecoration(
                labelText: "Answer",
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
          const Spacer(),

          // Submit button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _isFormValid
                    ? () {
                  _openCountrySelector(context);
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
                  "Set Security Question",
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
          const SizedBox(height: 12),

          // Skip option
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SafeArea(
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    // TODO: skip setup
                  },
                  child: const Text(
                    "Set up later",
                    style: TextStyle(
                      fontFamily: "Creato Display",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF0092FF),
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

  String selectedQuestion1 = 'Question 1';
  void _openCountrySelector(BuildContext context) async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const LoadingBottomSheet(title: 'We are setting up your account'),
    );

    if (selected != null) {
      Navigator.of(context).pop();
    }
  }
}