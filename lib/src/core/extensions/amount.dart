

import 'package:easy_localization/easy_localization.dart';

extension StringEx on double {
  String asNZDFormat(
      {String? prefix, String pattern = '#,##0.##', String fallback = '-'}) {
    /// change default prefix according the currency
    prefix ??= r'NZD $';
    final currencyFormat = NumberFormat(pattern, 'en_US');
    if (this > 0) {
      // Check if it is a whole number
      if (this == toInt()) {
        return '$prefix${currencyFormat.format(toInt())}';
      }
      return '$prefix${currencyFormat.format(this)}';
    } else if (this < 0) {
      if (this == toInt()) {
        return '-$prefix${currencyFormat.format(abs().toInt())}';
      }
      return '-$prefix${currencyFormat.format(abs())}';
    } else {
      return fallback;
    }
  }

  String asDFormat(
      {String? prefix, String pattern = '#,##0.##', String fallback = '-'}) {
    /// change default prefix according the currency
    prefix ??= r'$';
    final currencyFormat = NumberFormat(pattern, 'en_US');
    if (this > 0) {
      // Check if it is a whole number
      if (this == toInt()) {
        return '$prefix${currencyFormat.format(toInt())}';
      }
      return '$prefix${currencyFormat.format(this)}';
    } else if (this < 0) {
      if (this == toInt()) {
        return '-$prefix${currencyFormat.format(abs().toInt())}';
      }
      return '-$prefix${currencyFormat.format(abs())}';
    } else {
      return fallback;
    }
  }
}