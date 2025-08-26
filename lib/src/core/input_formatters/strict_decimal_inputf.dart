import 'package:flutter/services.dart';

class StrictDecimalInputFormatter extends TextInputFormatter {
  StrictDecimalInputFormatter({this.decimalRange = 2})
      : assert(decimalRange >= 0);

  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // 1) normalize: turn commas into dots
    final normalized = newValue.text.replaceAll(',', '.');

    // allow clearing
    if (normalized.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // 2) only digits and dots
    //    full-string check so pasting "abc" is rejected
    final onlyDigitsAndDot = RegExp(r'^[0-9.]+$');
    if (!onlyDigitsAndDot.hasMatch(normalized)) {
      return oldValue; // reject paste of letters/symbols
    }

    // 3) at most one dot
    if ('.'.allMatches(normalized).length > 1) {
      return oldValue;
    }

    // 4) max N decimals
    if (normalized.contains('.')) {
      final parts = normalized.split('.');
      final decimals = parts.length > 1 ? parts[1] : '';
      if (decimals.length > decimalRange) {
        return oldValue;
      }
    }

    // accept normalized text, fix selection
    final newText = normalized;
    final sel = newValue.selection;
    final newOffset = newText.length.clamp(0, newText.length);
    return TextEditingValue(
      text: newText,
      selection: sel.isValid
          ? TextSelection.collapsed(offset: newOffset)
          : TextSelection.collapsed(offset: newText.length),
      composing: TextRange.empty,
    );
  }
}
