import 'package:auto_route/auto_route.dart';
import 'package:designerwardrobe/src/router/route_names.dart';
import 'package:designerwardrobe/src/router/router.dart';
import 'package:flutter/material.dart';

@RoutePage(name: setupPinRoute)
class SetupPinScreen extends StatefulWidget {
  const SetupPinScreen({super.key});

  @override
  State<SetupPinScreen> createState() => _SetupPinScreenState();
}

class _SetupPinScreenState extends State<SetupPinScreen> {
  final List<TextEditingController> _controllers =
  List.generate(4, (_) => TextEditingController());

  bool get _isPinComplete =>
      _controllers.every((c) => c.text.isNotEmpty && c.text.length == 1);

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
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                "Step 3 of 4",
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
              "Set up PIN",
              style: const TextStyle(
                fontFamily: "Creato Display",
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: Color(0xFF0A0A0C),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Add an extra layer of security and set up a transaction PIN to secure your account",
              style: const TextStyle(
                fontFamily: "Creato Display",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF92939E),
              ),
            ),
            const SizedBox(height: 32),

            // Enter PIN label
            const Text(
              "Enter PIN",
              style: TextStyle(
                fontFamily: "Creato Display",
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF92939E),
              ),
            ),
            const SizedBox(height: 12),

            // PIN input boxes
            Row(
              children: List.generate(
                4,
                    (index) => _buildPinBox(index),
              ),
            ),
            const Spacer(),

            // Next button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: (){
                  context.router.push(ConfirmPinScreenRoute());
                }/*_isPinComplete
                    ? () {
                  // TODO: proceed to next step
                }
                    : null*/,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isPinComplete
                      ? const Color(0xFF0092FF)
                      : const Color(0xFFF4F4F4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: Text(
                  "Next",
                  style: TextStyle(
                    fontFamily: "Creato Display",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color:
                    _isPinComplete ? Colors.white : const Color(0xFFA3A3A3),
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

  Widget _buildPinBox(int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: SizedBox(
        width: 52,
        height: 56,
        child: TextField(
          controller: _controllers[index],
          maxLength: 1,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            counterText: "",
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFE1E5EA),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF0092FF),
                width: 1.5,
              ),
            ),
          ),
          onChanged: (_) => setState(() {}),
        ),
      ),
    );
  }
}