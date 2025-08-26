import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.white,
    required this.red,
    required this.hintGray,
    required this.gray,
    required this.black,
    required this.silverSand,
    required this.outerSpace,
    required this.cherryRed,
    required this.mediumGray,
    required this.lightGray,
    required this.darkSlateBlue,
    required this.greyStone,
    required this.coalBlack,
    required this.coralBlue,
    required this.cobatBlue,
    required this.cornflower,
    required this.vividBlue,
    required this.skyBlue,
    required this.lavender,
    required this.manatee,
    required this.chrome,
    required this.rhino,
    required this.platinum,
    required this.dimGray,
    required this.veryLightGrey,
    required this.gainsboro,
    required this.brightRed,
    required this.nobel,
    required this.paleYellow,
    required this.whiteSmoke,
    required this.neutralGray,
    required this.darkGray,
    required this.vibrantBlue,
    required this.settingAppbar,
    required this.settingBackground,
    required this.settingTextColor,
    required this.settingItemBackground,
    required this.settingTitleBackground,
    required this.settingSeparateColor,
    required this.profileAppbar,
    required this.profileBackground,
    required this.profileTextColor,
    required this.profileItemBackground,
    required this.profileSeparateColor,
    required this.profileButtonColor,
    required this.profileTextButtonColor,
    required this.profileIconColor,
    required this.profileBarCodeBg,
    required this.profileBarCodeText,
    required this.signInBackground,
    required this.signInButtonColor,
    required this.signInTextButtonColor,
    required this.signInSeparateColor,
    required this.signInTextColor,
    required this.signInLinkColor,
    required this.signInFocusColor,
    required this.registerBackground,
    required this.registerButtonColor,
    required this.registerUnactivatedButtonColor,
    required this.registerTextButtonColor,
    required this.registerSeparateColor,
    required this.registerTextColor,
    required this.registerLinkColor,
    required this.registerFocusColor,
    required this.forgotPasswordBackground,
    required this.forgotPasswordButtonColor,
    required this.forgotPasswordTextButtonColor,
    required this.forgotPasswordSeparateColor,
    required this.forgotPasswordTextColor,
    required this.forgotPasswordLinkColor,
    required this.forgotPasswordFocusColor,
    required this.forgotPasswordAppbar,
  });
  final Color white;
  final Color red;
  final Color hintGray;
  final Color black;
  final Color gray;
  final Color silverSand;
  final Color outerSpace;
  final Color cherryRed;
  final Color mediumGray;
  final Color lightGray;
  final Color darkSlateBlue;
  final Color vividBlue;
  final Color skyBlue;
  final Color lavender;
  final Color manatee;
  final Color chrome;
  final Color rhino;
  final Color platinum;
  final Color dimGray;
  final Color veryLightGrey;
  final Color gainsboro;
  final Color brightRed;
  final Color nobel;
  final Color paleYellow;
  final Color whiteSmoke;
  final Color neutralGray;
  final Color darkGray;
  final Color vibrantBlue;

  final Color greyStone;
  final Color coalBlack;
  final Color coralBlue;
  final Color cobatBlue;
  final Color cornflower;
  final Color settingAppbar;
  final Color settingBackground;
  final Color settingTextColor;
  final Color settingItemBackground;
  final Color settingTitleBackground;
  final Color settingSeparateColor;
  final Color profileAppbar;
  final Color profileBackground;
  final Color profileTextColor;
  final Color profileItemBackground;
  final Color profileSeparateColor;
  final Color profileButtonColor;
  final Color profileIconColor;
  final Color profileTextButtonColor;
  final Color profileBarCodeBg;
  final Color profileBarCodeText;
  final Color signInBackground;
  final Color signInButtonColor;
  final Color signInTextButtonColor;
  final Color signInSeparateColor;
  final Color signInTextColor;
  final Color signInLinkColor;
  final Color signInFocusColor;
  final Color registerBackground;
  final Color registerButtonColor;
  final Color registerUnactivatedButtonColor;
  final Color registerTextButtonColor;
  final Color registerSeparateColor;
  final Color registerTextColor;
  final Color registerLinkColor;
  final Color registerFocusColor;
  final Color forgotPasswordBackground;
  final Color forgotPasswordButtonColor;
  final Color forgotPasswordTextButtonColor;
  final Color forgotPasswordSeparateColor;
  final Color forgotPasswordTextColor;
  final Color forgotPasswordLinkColor;
  final Color forgotPasswordFocusColor;
  final Color forgotPasswordAppbar;

  @override
  AppColors copyWith({
    Color? white,
    Color? red,
    Color? hintGray,
    Color? backgroundDark,
    Color? gray,
    Color? silverSand,
    Color? outerSpace,
    Color? cherryRed,
    Color? mediumGray,
    Color? lightGray,
    Color? greyStone,
    Color? coalBlack,
    Color? coralBlue,
    Color? cobatBlue,
    Color? cornflower,
    Color? darkSlateBlue,
    Color? settingAppbar,
    Color? vividBlue,
    Color? skyBlue,
    Color? lavender,
    Color? manatee,
    Color? chrome,
    Color? rhino,
    Color? platinum,
    Color? dimGray,
    Color? veryLightGrey,
    Color? gainsboro,
    Color? brightRed,
    Color? nobel,
    Color? paleYellow,
    Color? whiteSmoke,
    Color? neutralGray,
    Color? darkGray,
    Color? vibrantBlue,
    Color? settingBackground,
    Color? settingTextColor,
    Color? settingItemBackground,
    Color? settingTitleBackground,
    Color? settingSeparateColor,
    Color? profileAppbar,
    Color? profileBackground,
    Color? profileTextColor,
    Color? profileItemBackground,
    Color? profileSeparateColor,
    Color? profileButtonColor,
    Color? profileIconColor,
    Color? profileTextButtonColor,
    Color? profileBarCodeBg,
    Color? profileBarCodeText,
    Color? signInBackground,
    Color? signInButtonColor,
    Color? signInTextButtonColor,
    Color? signInSeparateColor,
    Color? signInTextColor,
    Color? signInLinkColor,
    Color? signInFocusColor,
    Color? registerBackground,
    Color? registerButtonColor,
    Color? registerUnactivatedButtonColor,
    Color? registerTextButtonColor,
    Color? registerSeparateColor,
    Color? registerTextColor,
    Color? registerLinkColor,
    Color? registerFocusColor,
    Color? forgotPasswordBackground,
    Color? forgotPasswordButtonColor,
    Color? forgotPasswordTextButtonColor,
    Color? forgotPasswordSeparateColor,
    Color? forgotPasswordTextColor,
    Color? forgotPasswordLinkColor,
    Color? forgotPasswordFocusColor,
    Color? forgotPasswordAppbar,
  }) {
    return AppColors(
      white: white ?? AppColorss.background,
      red: red ?? this.red,
      hintGray: hintGray ?? this.hintGray,
      black: backgroundDark ?? black,
      gray: gray ?? this.gray,
      silverSand: silverSand ?? this.silverSand,
      outerSpace: outerSpace ?? this.outerSpace,
      cherryRed: cherryRed ?? this.cherryRed,
      mediumGray: mediumGray ?? this.mediumGray,
      lightGray: lightGray ?? this.lightGray,
      greyStone: greyStone ?? this.greyStone,
      coalBlack: coalBlack ?? this.coalBlack,
      coralBlue: coralBlue ?? this.coralBlue,
      cobatBlue: cobatBlue ?? this.cobatBlue,
      cornflower: cornflower ?? this.cornflower,
      darkSlateBlue: darkSlateBlue ?? this.darkSlateBlue,
      settingAppbar: settingAppbar ?? this.settingAppbar,
      vividBlue: vividBlue ?? this.vividBlue,
      skyBlue: skyBlue ?? this.skyBlue,
      lavender: lavender ?? this.lavender,
      manatee: manatee ?? this.manatee,
      chrome: chrome ?? this.chrome,
      rhino: rhino ?? this.rhino,
      platinum: platinum ?? this.platinum,
      dimGray: dimGray ?? this.dimGray,
      veryLightGrey: veryLightGrey ?? this.veryLightGrey,
      gainsboro: gainsboro ?? this.gainsboro,
      brightRed: brightRed ?? this.brightRed,
      nobel: nobel ?? this.nobel,
      paleYellow: paleYellow ?? this.paleYellow,
      whiteSmoke: whiteSmoke ?? this.whiteSmoke,
      neutralGray: neutralGray ?? this.neutralGray,
      darkGray: darkGray ?? this.darkGray,
      vibrantBlue: vibrantBlue ?? this.vibrantBlue,
      settingBackground: settingBackground ?? this.settingBackground,
      settingTextColor: settingTextColor ?? this.settingTextColor,
      settingItemBackground:
          settingItemBackground ?? this.settingItemBackground,
      settingTitleBackground:
          settingTitleBackground ?? this.settingTitleBackground,
      settingSeparateColor: settingSeparateColor ?? this.settingSeparateColor,
      profileAppbar: profileAppbar ?? this.profileAppbar,
      profileBackground: profileBackground ?? this.profileBackground,
      profileTextColor: profileTextColor ?? this.profileTextColor,
      profileItemBackground:
          profileItemBackground ?? this.profileItemBackground,
      profileSeparateColor: profileSeparateColor ?? this.profileSeparateColor,
      profileButtonColor: profileButtonColor ?? this.profileButtonColor,
      profileIconColor: profileIconColor ?? this.profileIconColor,
      profileTextButtonColor:
          profileTextButtonColor ?? this.profileTextButtonColor,
      profileBarCodeBg: profileBarCodeBg ?? this.profileBarCodeBg,
      profileBarCodeText: profileBarCodeText ?? this.profileBarCodeText,
      signInBackground: signInBackground ?? this.signInBackground,
      signInButtonColor: signInButtonColor ?? this.signInButtonColor,
      signInTextButtonColor:
          signInTextButtonColor ?? this.signInTextButtonColor,
      signInSeparateColor: signInSeparateColor ?? this.signInSeparateColor,
      signInTextColor: signInTextColor ?? this.signInTextColor,
      signInLinkColor: signInLinkColor ?? this.signInLinkColor,
      signInFocusColor: signInFocusColor ?? this.signInFocusColor,
      registerBackground: registerBackground ?? this.registerBackground,
      registerButtonColor: registerButtonColor ?? this.registerButtonColor,
      registerUnactivatedButtonColor:
          registerUnactivatedButtonColor ?? this.registerUnactivatedButtonColor,
      registerTextButtonColor:
          registerTextButtonColor ?? this.registerTextButtonColor,
      registerSeparateColor:
          registerSeparateColor ?? this.registerSeparateColor,
      registerTextColor: registerTextColor ?? this.registerTextColor,
      registerLinkColor: registerLinkColor ?? this.registerLinkColor,
      registerFocusColor: registerFocusColor ?? this.registerFocusColor,
      forgotPasswordBackground:
          forgotPasswordBackground ?? this.forgotPasswordBackground,
      forgotPasswordButtonColor:
          forgotPasswordButtonColor ?? this.forgotPasswordButtonColor,
      forgotPasswordTextButtonColor:
          forgotPasswordTextButtonColor ?? this.forgotPasswordTextButtonColor,
      forgotPasswordSeparateColor:
          forgotPasswordSeparateColor ?? this.forgotPasswordSeparateColor,
      forgotPasswordTextColor:
          forgotPasswordTextColor ?? this.forgotPasswordTextColor,
      forgotPasswordLinkColor:
          forgotPasswordLinkColor ?? this.forgotPasswordLinkColor,
      forgotPasswordFocusColor:
          forgotPasswordFocusColor ?? this.forgotPasswordFocusColor,
      forgotPasswordAppbar: forgotPasswordAppbar ?? this.forgotPasswordAppbar,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      white: Color.lerp(white, other.white, t) ?? white,
      red: Color.lerp(red, other.red, t) ?? red,
      hintGray: Color.lerp(hintGray, other.hintGray, t) ?? hintGray,
      black: Color.lerp(black, other.black, t) ?? black,
      gray: Color.lerp(gray, other.gray, t) ?? gray,
      silverSand: Color.lerp(silverSand, other.silverSand, t) ?? silverSand,
      outerSpace: Color.lerp(outerSpace, other.outerSpace, t) ?? outerSpace,
      cherryRed: Color.lerp(cherryRed, other.cherryRed, t) ?? cherryRed,
      mediumGray: Color.lerp(mediumGray, other.mediumGray, t) ?? mediumGray,
      lightGray: Color.lerp(lightGray, other.lightGray, t) ?? lightGray,
      greyStone: Color.lerp(greyStone, other.greyStone, t) ?? greyStone,
      coalBlack: Color.lerp(coalBlack, other.coalBlack, t) ?? coalBlack,
      coralBlue: Color.lerp(coralBlue, other.coralBlue, t) ?? coralBlue,
      cobatBlue: Color.lerp(cobatBlue, other.cobatBlue, t) ?? cobatBlue,
      cornflower: Color.lerp(cornflower, other.cornflower, t) ?? cornflower,
      darkSlateBlue:
          Color.lerp(darkSlateBlue, other.darkSlateBlue, t) ?? darkSlateBlue,
      settingAppbar:
          Color.lerp(settingAppbar, other.settingAppbar, t) ?? settingAppbar,
      vividBlue: Color.lerp(vividBlue, other.vividBlue, t) ?? vividBlue,
      skyBlue: Color.lerp(skyBlue, other.skyBlue, t) ?? skyBlue,
      lavender: Color.lerp(lavender, other.lavender, t) ?? lavender,
      manatee: Color.lerp(manatee, other.manatee, t) ?? manatee,
      chrome: Color.lerp(chrome, other.chrome, t) ?? chrome,
      rhino: Color.lerp(rhino, other.rhino, t) ?? rhino,
      platinum: Color.lerp(platinum, other.platinum, t) ?? platinum,
      dimGray: Color.lerp(dimGray, other.dimGray, t) ?? dimGray,
      veryLightGrey:
          Color.lerp(veryLightGrey, other.veryLightGrey, t) ?? veryLightGrey,
      gainsboro: Color.lerp(gainsboro, other.gainsboro, t) ?? gainsboro,
      brightRed: Color.lerp(brightRed, other.brightRed, t) ?? brightRed,
      nobel: Color.lerp(nobel, other.nobel, t) ?? nobel,
      paleYellow: Color.lerp(paleYellow, other.paleYellow, t) ?? paleYellow,
      whiteSmoke: Color.lerp(whiteSmoke, other.whiteSmoke, t) ?? whiteSmoke,
      neutralGray: Color.lerp(neutralGray, other.neutralGray, t) ?? neutralGray,
      darkGray: Color.lerp(darkGray, other.darkGray, t) ?? darkGray,
      vibrantBlue: Color.lerp(vibrantBlue, other.vibrantBlue, t) ?? vibrantBlue,
      settingBackground:
          Color.lerp(settingBackground, other.settingBackground, t) ??
              settingBackground,
      settingTextColor:
          Color.lerp(settingTextColor, other.settingTextColor, t) ??
              settingTextColor,
      settingItemBackground:
          Color.lerp(settingItemBackground, other.settingItemBackground, t) ??
              settingItemBackground,
      settingTitleBackground:
          Color.lerp(settingTitleBackground, other.settingTitleBackground, t) ??
              settingTitleBackground,
      settingSeparateColor:
          Color.lerp(settingSeparateColor, other.settingSeparateColor, t) ??
              settingSeparateColor,
      profileAppbar:
          Color.lerp(profileAppbar, other.profileAppbar, t) ?? profileAppbar,
      profileBackground:
          Color.lerp(profileBackground, other.profileBackground, t) ??
              profileBackground,
      profileTextColor:
          Color.lerp(profileTextColor, other.profileTextColor, t) ??
              profileTextColor,
      profileItemBackground:
          Color.lerp(profileItemBackground, other.profileItemBackground, t) ??
              profileItemBackground,
      profileSeparateColor:
          Color.lerp(profileSeparateColor, other.profileSeparateColor, t) ??
              profileSeparateColor,
      profileButtonColor:
          Color.lerp(profileButtonColor, other.profileButtonColor, t) ??
              profileButtonColor,
      profileIconColor:
          Color.lerp(profileIconColor, other.profileIconColor, t) ??
              profileIconColor,
      profileTextButtonColor:
          Color.lerp(profileTextButtonColor, other.profileTextButtonColor, t) ??
              profileTextButtonColor,
      profileBarCodeBg:
          Color.lerp(profileBarCodeBg, other.profileBarCodeBg, t) ??
              profileBarCodeBg,
      profileBarCodeText:
          Color.lerp(profileBarCodeText, other.profileBarCodeText, t) ??
              profileBarCodeText,
      signInBackground:
          Color.lerp(signInBackground, other.signInBackground, t) ??
              signInBackground,
      signInButtonColor:
          Color.lerp(signInButtonColor, other.signInButtonColor, t) ??
              signInButtonColor,
      signInTextButtonColor:
          Color.lerp(signInTextButtonColor, other.signInTextButtonColor, t) ??
              signInTextButtonColor,
      signInSeparateColor:
          Color.lerp(signInSeparateColor, other.signInSeparateColor, t) ??
              signInSeparateColor,
      signInTextColor: Color.lerp(signInTextColor, other.signInTextColor, t) ??
          signInTextColor,
      signInLinkColor: Color.lerp(signInLinkColor, other.signInLinkColor, t) ??
          signInLinkColor,
      signInFocusColor:
          Color.lerp(signInFocusColor, other.signInFocusColor, t) ??
              signInFocusColor,
      registerBackground:
          Color.lerp(registerBackground, other.registerBackground, t) ??
              registerBackground,
      registerButtonColor:
          Color.lerp(registerButtonColor, other.registerButtonColor, t) ??
              registerButtonColor,
      registerUnactivatedButtonColor: Color.lerp(registerUnactivatedButtonColor,
              other.registerUnactivatedButtonColor, t) ??
          registerUnactivatedButtonColor,
      registerTextButtonColor: Color.lerp(
              registerTextButtonColor, other.registerTextButtonColor, t) ??
          registerTextButtonColor,
      registerSeparateColor:
          Color.lerp(registerSeparateColor, other.registerSeparateColor, t) ??
              registerSeparateColor,
      registerTextColor:
          Color.lerp(registerTextColor, other.registerTextColor, t) ??
              registerTextColor,
      registerLinkColor:
          Color.lerp(registerLinkColor, other.registerLinkColor, t) ??
              registerLinkColor,
      registerFocusColor:
          Color.lerp(registerFocusColor, other.registerFocusColor, t) ??
              registerFocusColor,
      forgotPasswordBackground: Color.lerp(
              forgotPasswordBackground, other.forgotPasswordBackground, t) ??
          forgotPasswordBackground,
      forgotPasswordButtonColor: Color.lerp(
              forgotPasswordButtonColor, other.forgotPasswordButtonColor, t) ??
          forgotPasswordButtonColor,
      forgotPasswordTextButtonColor: Color.lerp(forgotPasswordTextButtonColor,
              other.forgotPasswordTextButtonColor, t) ??
          forgotPasswordTextButtonColor,
      forgotPasswordSeparateColor: Color.lerp(forgotPasswordSeparateColor,
              other.forgotPasswordSeparateColor, t) ??
          forgotPasswordSeparateColor,
      forgotPasswordTextColor: Color.lerp(
              forgotPasswordTextColor, other.forgotPasswordTextColor, t) ??
          forgotPasswordTextColor,
      forgotPasswordLinkColor: Color.lerp(
              forgotPasswordLinkColor, other.forgotPasswordLinkColor, t) ??
          forgotPasswordLinkColor,
      forgotPasswordFocusColor: Color.lerp(
              forgotPasswordFocusColor, other.forgotPasswordFocusColor, t) ??
          forgotPasswordFocusColor,
      forgotPasswordAppbar:
          Color.lerp(forgotPasswordAppbar, other.forgotPasswordAppbar, t) ??
              forgotPasswordAppbar,
    );
  }
}

//TODO will be deleted later
class AppColorss {
  ///Common
  static const Color main = Color(0xFF00C8A0);
  static const Color background = Color(0xFFFFFFFF);
  static const Color brown = Color(0xFFD9D5CB);
  static const Color darkBrown = Color(0xFF796451);

  ///Gradient
  static const Color gradientEnd = Color(0xFF00C8A0);
  static const Color gradientStart = Color(0xFF00AFA5);

  ///Shadow
  static const Color shadowColor = Color(0x25606060);

  ///Border
  static const Color borderColor = Color(0xFFC6C6C6);

  ///Text
  static const Color textTint = Color(0xFF00C8A0);
  static const Color textDart = Color(0xFF000000);
  static const Color textGray = Color(0xFF979ca8);

  ///Button
  static const Color buttonGreen = Color(0xFF00FF00);
  static const Color crimson = Color(0xFFAD2F34);
  static const Color blue = Color(0xFF4B90FD);

  ///Other
  static const Color lightGray = Color(0x1A606060);
  static const Color gray = Color(0xFF606060);
}
