import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:designerwardrobe/src/router/route_names.dart';
import 'package:designerwardrobe/src/router/router.dart';
import 'package:flutter/material.dart';

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

  String? _selectedState;
  String? _selectedCity;

  final List<String> states = ["Lagos", "Abuja", "Kano"];
  final List<String> cities = ["Ikeja", "Lekki", "Victoria Island"];

  @override
  Widget build(BuildContext context) {
    final bool isFormValid = _selectedState != null &&
        _selectedCity != null &&
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
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                "Step 4 of 4",
                style: TextStyle(
                  fontFamily: "Creato Display",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
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
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: "State"),
              value: _selectedState,
              items: states
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: (value) => setState(() => _selectedState = value),
            ),
            const SizedBox(height: 16),

            // City dropdown
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: "City"),
              value: _selectedCity,
              items: cities
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (value) => setState(() => _selectedCity = value),
            ),
            const SizedBox(height: 16),

            // Postal Code
            TextField(
              controller: _postalCodeController,
              decoration: const InputDecoration(labelText: "Postal Code"),
              keyboardType: TextInputType.number,
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),

            // Address
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: "Address"),
              onChanged: (_) => setState(() {}),
            ),
            const Spacer(),

            // Continue button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: (){
                  context.router.push(SecurityAndPinScreenRoute());
                }/*isFormValid
                    ? () {
                  // TODO: Submit contact info
                }
                    : null*/,
                style: ElevatedButton.styleFrom(
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
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}