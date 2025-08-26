import 'package:flutter/material.dart';

@immutable
class AppFonts extends ThemeExtension<AppFonts> {
  const AppFonts({
    required this.mainFont,
    required this.subFont,
  });

  final String mainFont;
  final String subFont;

  @override
  AppFonts copyWith({String? mainFont, String? subFont}) {
    return AppFonts(
      mainFont: mainFont ?? this.mainFont,
      subFont: subFont ?? this.subFont,
    );
  }

  @override
  AppFonts lerp(ThemeExtension<AppFonts>? other, double t) {
    if (other is! AppFonts) {
      return this;
    }
    return AppFonts(
      mainFont: other.mainFont,
      subFont: other.subFont,
    );
  }
}

extension AssetPathAppFonts on AppFonts {
  String get mainFontRegularAssetPath {
    //The asset path to the font file
    return 'assets/fonts/$mainFont-Regular.ttf';
  }
}
