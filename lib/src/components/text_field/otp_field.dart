import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OTPInputField extends StatefulWidget {
  final int length; // Length of the OTP (1 to 6)
  final bool obscure; // Whether to obscure input (for sensitive data)
  final String errorText; // Error message to display
  final Function(String) onCompleted; // Callback when OTP is completed
  final Function(String) onChange; // Callback when OTP changes
  final FocusNode? focusNode;

  const OTPInputField({
    super.key,
    this.length = 4,
    this.obscure = false,
    this.errorText = '',
    this.focusNode,
    required this.onCompleted,
    required this.onChange,
  }) : assert(length > 0 && length <= 6, 'Length must be between 1 and 6');

  @override
  OTPInputFieldState createState() => OTPInputFieldState();
}

class OTPInputFieldState extends State<OTPInputField> {
  late final TextEditingController _otpControllers;

  @override
  void initState() {
    _otpControllers = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _otpControllers.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFE1E5EA)),
      ),
    );
    final submittedPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
        fontSize: 20,
        color: Color(0xFF0A0A0C),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFE1E5EA)),
      ),
    );
    final focusedPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
        fontSize: 20,
        color: Color(0xFF0A0A0C),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF0092FF), width: 2),
      ),
    );

    return Pinput(
      focusNode: widget.focusNode,
      defaultPinTheme: defaultPinTheme,
      submittedPinTheme: submittedPinTheme,
      focusedPinTheme: focusedPinTheme,
      controller: _otpControllers,
      hapticFeedbackType: HapticFeedbackType.mediumImpact,
      cursor: Container(
        width: 3,
        height: 22,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Color(0xffE1E5EA)),
      ),
      onChanged: widget.onChange,
      onCompleted: widget.onCompleted,
      obscureText: widget.obscure,
      separatorBuilder: (val) {
        return const Padding(
          padding: EdgeInsets.all(4.0),
          child: Text(""),
        );
      },
      length: widget.length,
    );
  }
}
