

import 'package:qwid/src/configs/app_themes/app_images.dart';

enum CardBrand {
  visa,
  mastercard,
  amex,
  unknown,
}

extension CardBrandExtension on CardBrand {
  String get cardType {
    switch (this) {
      case CardBrand.visa:
        return 'visa';
      case CardBrand.mastercard:
        return 'mastercard';
      case CardBrand.amex:
        return 'american express';
      case CardBrand.unknown:
        return 'unknown';
    }
  }

  String get cardLogo {
    switch (this) {
      case CardBrand.visa:
        return icPaymentVisa;
      case CardBrand.mastercard:
        return icPaymentMastercard;
      case CardBrand.amex:
        return icPaymentAmex;
      case CardBrand.unknown:
        return 'unknown';
    }
  }
}

class CardUtils {
  static CardBrand fromCardNumber(String cardNumber) {
    String input = cardNumber.replaceAll(RegExp(r'\s+'), ''); // remove spaces

    if (input.isEmpty) return CardBrand.unknown;

    if (input.startsWith('4')) {
      return CardBrand.visa;
    } else if (RegExp(r'^(5[1-5])').hasMatch(input) ||
        RegExp(r'^(222[1-9]|22[3-9]\d|2[3-6]\d{2}|27[01]\d|2720)').hasMatch(
            input)) {
      return CardBrand.mastercard;
    } else if (RegExp(r'^(34|37)').hasMatch(input)) {
      return CardBrand.amex;
    } else {
      return CardBrand.unknown;
    }
  }

  static CardBrand fromCardType(String cardType) {
    switch (cardType.toLowerCase()) {
      case 'visa':
        return CardBrand.visa;
      case 'mastercard':
        return CardBrand.mastercard;
      case 'amex':
        return CardBrand.amex;
      default:
        return CardBrand.unknown;
    }
  }
}