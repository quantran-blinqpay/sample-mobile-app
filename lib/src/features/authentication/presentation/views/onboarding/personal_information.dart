import 'package:auto_route/auto_route.dart';
import 'package:designerwardrobe/src/router/route_names.dart';
import 'package:designerwardrobe/src/router/router.dart';
import 'package:flutter/material.dart';

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

  DateTime? _selectedDate;

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
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                "Step 2 of 4",
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
              decoration: const InputDecoration(labelText: "First Name"),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),

            // Last Name
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: "Last Name (Surname)"),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),

            // Mobile with country code
            Row(
              children: [
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE1E5EA)),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    "+234",
                    style: TextStyle(
                      fontFamily: "Creato Display",
                      fontSize: 16,
                      color: Color(0xFF92939E),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _mobileController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(labelText: "Mobile"),
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
                  icon: const Icon(Icons.calendar_today_outlined,
                      color: Color(0xFFAEAFC0)),
                  onPressed: _pickDate,
                ),
              ),
              onTap: _pickDate,
            ),
            const SizedBox(height: 16),

            // Referral Code (optional)
            TextField(
              controller: _referralController,
              decoration:
              const InputDecoration(labelText: "Referral Code (optional)"),
            ),
            const Spacer(),

            // Continue button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  context.router.push(ContactInformationScreenRoute());
                }/*isFormValid
                    ? () {

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

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dobController.text =
        "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }
}