import 'package:flutter/material.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:qwid/src/features/authentication/presentation/views/home/widgets/select_virtual_account_bottom_sheet.dart';

class PaymentSuccess extends StatelessWidget {
  const PaymentSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.all(24),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 8),
            Image.asset(icQwidPaymentSuccess, width: 91, height: 64),
            const SizedBox(height: 8),
            Text(
              "Your request is being processed.",
              style: TextStyle(
                fontFamily: "Creato Display",
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              "We’re on it! You’ll hear from us shortly.",
              style: TextStyle(
                fontFamily: "Creato Display",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF8C909C),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 52,
              width: double.infinity,
              child: ElevatedButton(
                onPressed:  () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color(0xff0092FF),
                  disabledBackgroundColor: Color(0xFFF4F4F4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(
                    fontFamily: 'Creato Display',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: _canSubmit ? Colors.white : Color(0xFFA3A3A3),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  final bool _canSubmit = true;

  void _openVirtualAccountSelector(BuildContext context) async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const SelectVirtualAccountBottomSheet(),
    );

    if (selected != null) {
      // _countryController.text = selected;
      // print("Selected country: $selected");
    }
  }
}