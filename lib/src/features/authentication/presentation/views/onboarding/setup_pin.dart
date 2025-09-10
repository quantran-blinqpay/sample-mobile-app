import 'package:auto_route/auto_route.dart';
import 'package:qwid/src/components/text_field/otp_field.dart';
import 'package:qwid/src/router/route_names.dart';
import 'package:qwid/src/router/router.dart';
import 'package:flutter/material.dart';

@RoutePage(name: setupPinRoute)
class SetupPinScreen extends StatefulWidget {
  const SetupPinScreen({super.key});

  @override
  State<SetupPinScreen> createState() => _SetupPinScreenState();
}

class _SetupPinScreenState extends State<SetupPinScreen> {
  String? _otp;

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
            OTPInputField(
              length: 4,
              onChange: (val) {
                setState(() {
                  _otp = val;
                });
              },
              onCompleted: (val) {
              },
            ),
            const Spacer(),

            // Next button
            SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: (){
                    context.router.popAndPush(ConfirmPinScreenRoute());
                  }/*_isPinComplete
                      ? () {
                    // TODO: proceed to next step
                  }
                      : null*/,
                  style: ElevatedButton.styleFrom(
                    elevation: 0, // remove shadow
                    shadowColor: Colors.transparent, // optional, ensures no shadow color
                    backgroundColor: _otp?.length == 4
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
                      color: _otp?.length == 4 ? Colors.white : const Color(0xFFA3A3A3),
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

}