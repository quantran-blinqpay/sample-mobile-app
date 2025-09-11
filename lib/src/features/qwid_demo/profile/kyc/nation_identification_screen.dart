import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:qwid/src/router/route_names.dart';

@RoutePage(name: nationIdentification)
class NationIdentificationScreen extends StatefulWidget {
  const NationIdentificationScreen({super.key});

  @override
  State<NationIdentificationScreen> createState() => _NationIdentificationScreenState();
}

class _NationIdentificationScreenState extends State<NationIdentificationScreen> {
  final _controller = TextEditingController();

  bool get _isValid => _controller.text.isNotEmpty && _errorText == null;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const blue = Color(0xFF0092FF);
    const sub = Color(0xFF92939E);
    const divider = Color(0xFFF3F5F7);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 18, color: Colors.black),
            onPressed: () => Navigator.maybePop(context),
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
                        'Step 2 ',
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
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                const SizedBox(height: 16),
                const Text(
                  "National Identification Number",
                  style: TextStyle(
                    fontFamily: 'Creato Display',
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Dial *346# on the phone number linked to your NIN",
                  style: TextStyle(
                    fontFamily: 'Creato Display',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: sub,
                  ),
                ),
                const SizedBox(height: 32),
                // Input field
                TextFormField(
                  onChanged: (_) => _validate11Digits(),
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  maxLength: 11,
                  cursorColor: blue,
                  style: const TextStyle(
                    fontFamily: 'Creato Display',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                    hintText: "Enter 11-digit number",
                    hintStyle: TextStyle(
                      fontFamily: 'Creato Display',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: sub,
                    ),
                    labelStyle: TextStyle(
                      fontFamily: 'Creato Display',
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF92939E),
                    ),
                    counterText: "",
                    labelText: "Enter 11-digit number",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: divider, width: 1),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: blue, width: 1),
                    ),
                  ),
                ),
                // Custom error widget
                if (_errorText != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                            icQwidError,
                            width: 16,
                            height: 16,
                            color: Colors.red),
                        const SizedBox(width: 4),
                        Text(
                          _errorText!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                            fontFamily: "Creato Display",
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          // Continue button & switch link
          SafeArea(
            top: false,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: divider)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isValid ? blue : const Color(0xFFF4F4F4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        elevation: 0,
                      ),
                      onPressed: _isValid
                          ? () {
                        setState(() => _isLoading = true);
                        Future.delayed(const Duration(seconds: 2), () {
                          setState(() => _isLoading = false);
                        });
                      }
                          : null,
                      child: _isLoading == true
                          ? const CupertinoActivityIndicator(color: Colors.white)
                          : Text(
                        "Continue",
                        style: TextStyle(
                          fontFamily: 'Creato Display',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: _isValid ? Colors.white : const Color(0xFFA3A3A3),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      // Switch to BVN instead
                    },
                    child: const Text(
                      "I want to use my BVN instead",
                      style: TextStyle(
                        fontFamily: 'Creato Display',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String? _errorText;
  bool? _isLoading;

  void _validate11Digits() {
    final value = _controller.text;
    if (value.isEmpty) {
      setState(() => _errorText = "NIN is required");
    } else {
      if (value.length < 11) {
        setState(() => _errorText = "NIN Verification Failed");
      } else {
        setState(() => _errorText = null);
      }
    }
  }
}