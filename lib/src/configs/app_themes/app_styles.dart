import 'package:flutter/material.dart';

import 'app_themes.dart';

@immutable
class AppStyles {
  static AppFonts getAppFonts(BuildContext context) {
    return Theme.of(context).extension<AppFonts>()!;
  }

  static AppColors getAppColors(BuildContext context) {
    return Theme.of(context).extension<AppColors>()!;
  }

  static TextStyle of(BuildContext context) {
    return TextStyle(
        color: getAppColors(context).black,
        fontSize: 22,
        fontWeight: FontWeight.bold,
        fontFamily: getAppFonts(context).mainFont);
  }
}
