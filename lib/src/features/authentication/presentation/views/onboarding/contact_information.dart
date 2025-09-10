import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:qwid/src/features/authentication/presentation/views/onboarding/select_city_bottom_sheet.dart';
import 'package:qwid/src/features/authentication/presentation/views/onboarding/select_state_bottom_sheet.dart';
import 'package:qwid/src/router/route_names.dart';
import 'package:qwid/src/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage(name: contactInformationRoute)
class ContactInformationScreen extends StatefulWidget {
  const ContactInformationScreen({super.key});

  @override
  State<ContactInformationScreen> createState() =>
      _ContactInformationScreenState();
}

class _ContactInformationScreenState extends State<ContactInformationScreen> {
  final _postalCodeController = TextEditingController();
  final _addressController = TextEditingController();
  final _stateController = TextEditingController();
  final _cityController = TextEditingController();

  String? _selectedState;
  String? _selectedCity;

  final List<String> states = ["Lagos", "Abuja", "Kano"];
  final List<String> cities = ["Ikeja", "Lekki", "Victoria Island"];

  @override
  Widget build(BuildContext context) {
    final bool isFormValid = _stateController.text.isNotEmpty &&
        _cityController.text.isNotEmpty &&
        _postalCodeController.text.isNotEmpty &&
        _addressController.text.isNotEmpty;

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
                      'Step 3 ',
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
              "Contact Information",
              style: const TextStyle(
                fontFamily: "Creato Display",
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: Color(0xFF0A0A0C),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "To complete your registration, please provide your phone number, address, city, state, and postal code.",
              style: const TextStyle(
                fontFamily: "Creato Display",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF92939E),
              ),
            ),
            const SizedBox(height: 24),

            // State dropdown
            TextFormField(
              controller: _stateController,
              readOnly: true,
              cursorColor: Color(0xff0092FF),
              onTap: (){
                _openStateSelector(context);
              },
              decoration: InputDecoration(
                labelText: "State",
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(icQwidArrowDown, width: 24, height: 24, color: Color(0xFF92939E)),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffF3F5F7), width: 0.5), // custom color & thickness
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff0092FF), width: 1),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // City dropdown
            TextFormField(
              controller: _cityController,
              readOnly: true,
              cursorColor: Color(0xff0092FF),
              onTap: (){
                _openCitySelector(context);
              },
              decoration: InputDecoration(
                labelText: "City",
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(icQwidArrowDown, width: 24, height: 24, color: Color(0xFF92939E)),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffF3F5F7), width: 0.5), // custom color & thickness
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff0092FF), width: 1),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Postal Code
            TextField(
              controller: _postalCodeController,
              decoration: const InputDecoration(
                labelText: "Postal Code",
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffF3F5F7), width: 0.5), // custom color & thickness
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff0092FF), width: 1),
                ),
              ),
              keyboardType: TextInputType.number,
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),

            // Address
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: "Address",
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffF3F5F7), width: 0.5), // custom color & thickness
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff0092FF), width: 1),
                ),
              ),
              onChanged: (_) => setState(() {}),
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
                    context.router.push(SecurityAndPinScreenRoute());
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

  void _openStateSelector(BuildContext context) async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const SelectStateBottomSheet(),
    );

    if (selected != null) {
      _stateController.text = selected;
    }
  }

  void _openCitySelector(BuildContext context) async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const SelectCityBottomSheet(),
    );

    if (selected != null) {
      _cityController.text = selected;
    }
  }
}