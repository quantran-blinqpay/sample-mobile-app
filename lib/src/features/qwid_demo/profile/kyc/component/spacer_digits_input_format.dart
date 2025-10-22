import 'package:flutter/services.dart';

/// Formats digits as `d d d d ...` (spaces between every digit).
class SpacedDigitsInputFormatter extends TextInputFormatter {
  SpacedDigitsInputFormatter({this.maxDigits});

  /// Optional cap on how many digits (without spaces).
  final int? maxDigits;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // Keep only digits
    var digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (maxDigits != null && digits.length > maxDigits!) {
      digits = digits.substring(0, maxDigits);
    }

    // Build spaced string
    final b = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      b.write(digits[i]);
      if (i != digits.length - 1) b.write(' ');
    }
    final formatted = b.toString();

    // Place caret at end (simple & reliable)
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
      composing: TextRange.empty,
    );
  }

  /// Helper to strip spaces later
  static String unformat(String spaced) =>
      spaced.replaceAll(RegExp(r'\s+'), '');
}