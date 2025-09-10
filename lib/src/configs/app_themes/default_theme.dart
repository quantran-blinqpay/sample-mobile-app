import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_themes.dart';

ThemeData getThemeDefault() {
  return ThemeData.light().copyWith(
    extensions: <ThemeExtension<dynamic>>[
      const AppColors(
        white: Color(0xFFffffff),
        red: Color(0xFFdb1b2a),
        hintGray: Color(0xFFcbc0b8),
        gray: Color(0xFFcccdcd),
        black: Color(0xFF081012),
        silverSand: Color(0xFFC6C6C6),
        outerSpace: Color(0xFF444444),
        cherryRed: Color(0xFFDC4A58),
        mediumGray: Color(0xFF8A8A8A),
        lightGray: Color(0xFFE3E3E3),
        darkSlateBlue: Color(0xFF334151),
        vividBlue: Color(0xFF022DE2),
        skyBlue: Color(0xFFD5DDF8),
        lavender: Color(0xFFECEEFB),
        manatee: Color(0xFF9DA3AE),
        chrome: Color(0xFFF9F9F9),
        rhino: Color(0xFFDEDEDE),
        platinum: Color(0xFFE5E8EC),
        dimGray: Color(0xFF717171),
        veryLightGrey: Color(0xFFCDCDCD),
        gainsboro: Color(0xFFE2E2E2),
        brightRed: Color(0xFFF2322B),
        nobel: Color(0xFF979797),
        paleYellow: Color(0xFFF2F6DA),
        whiteSmoke: Color(0xFFF8F8F8),
        neutralGray: Color(0xFF828282),
        darkGray: Color(0xFF6E6E6E),
        vibrantBlue: Color(0xFF007AFF),

        /// Home screen
        greyStone: Color(0xFFF5F5F5),
        coalBlack: Color(0xFF444444),
        coralBlue: Color(0xFFEBEEFC),
        cobatBlue: Color(0xFF0022EC),
        cornflower: Color(0xFFD6DDF9),

        /// Setting screen
        settingAppbar: Color(0xFFAD2F34),
        settingBackground: Color(0xFFD9D5CB),
        settingTextColor: Color(0xFF081012),
        settingItemBackground: Color(0xFFFFFFFF),
        settingTitleBackground: Color(0xFF796451),
        settingSeparateColor: Color(0xFFBCBCBC),

        /// profile screen
        profileAppbar: Color(0xFFAD2F34),
        profileBackground: Color(0xFFD9D5CB),
        profileTextColor: Color(0xFF081012),
        profileItemBackground: Color(0xFFFFFFFF),
        profileSeparateColor: Color(0xFFBCBCBC),
        profileButtonColor: Color(0xFFAD2F34),
        profileTextButtonColor: Color(0xFFFFFFFF),
        profileIconColor: Color(0xFFAD2F34),
        profileBarCodeBg: Color(0xFFD4D4D6),
        profileBarCodeText: Color(0xFF081012),

        /// sign in screen
        signInBackground: Color(0xFFECEEFB),
        signInButtonColor: Color(0xFF022DE2),
        signInTextButtonColor: Color(0xFFFFFFFF),
        signInSeparateColor: Color(0xFF979ca8),
        signInTextColor: Color(0xFF081012),
        signInLinkColor: Color(0xFF195777),
        signInFocusColor: Color(0xFFAD2F34),

        /// register screen
        registerBackground: Color(0xFFD9D5CB),
        registerButtonColor: Color(0xFF022DE2),
        registerUnactivatedButtonColor: Color(0xFF778DEF),
        registerTextButtonColor: Color(0xFFFFFFFF),
        registerSeparateColor: Color(0xFF979ca8),
        registerTextColor: Color(0xFF081012),
        registerLinkColor: Color(0xFF195777),
        registerFocusColor: Color(0xFFAD2F34),

        /// forgot password screen
        forgotPasswordAppbar: Color(0xFFAD2F34),
        forgotPasswordBackground: Color(0xFFD9D5CB),
        forgotPasswordButtonColor: Color(0xFFAD2F34),
        forgotPasswordTextButtonColor: Color(0xFFFFFFFF),
        forgotPasswordSeparateColor: Color(0xFF979ca8),
        forgotPasswordTextColor: Color(0xFF081012),
        forgotPasswordLinkColor: Color(0xFF195777),
        forgotPasswordFocusColor: Color(0xFFAD2F34),
      ),
      const AppFonts(mainFont: 'CreatoDisplay', subFont: 'Inter')
    ],
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    ),
  );
}

ThemeData getDarkDefault() {
  return ThemeData.dark().copyWith(
    extensions: <ThemeExtension<dynamic>>[
      const AppColors(
        white: Color(0xFFffffff),
        red: Color(0xFF00AFA5),
        hintGray: Color(0xFFcbc0b8),
        gray: Color(0xFFcccdcd),
        black: Color(0xFF081012),
        silverSand: Color(0xFFC6C6C6),
        outerSpace: Color(0xFF444444),
        cherryRed: Color(0xFFDC4A58),
        mediumGray: Color(0xFF8A8A8A),
        lightGray: Color(0xFFE3E3E3),
        darkSlateBlue: Color(0xFF334151),
        vividBlue: Color(0xFF334151),
        skyBlue: Color(0xFFD5DDF8),
        lavender: Color(0xFFECEEFB),
        manatee: Color(0xFF9DA3AE),
        chrome: Color(0xFFF9F9F9),
        rhino: Color(0xFFDEDEDE),
        platinum: Color(0xFFE5E8EC),
        dimGray: Color(0xFF717171),
        veryLightGrey: Color(0xFFCDCDCD),
        gainsboro: Color(0xFFE2E2E2),
        brightRed: Color(0xFFF2322B),
        nobel: Color(0xFF979797),
        paleYellow: Color(0xFFF2F6DA),
        whiteSmoke: Color(0xFFF8F8F8),
        neutralGray: Color(0xFF828282),
        darkGray: Color(0xFF6E6E6E),
        vibrantBlue: Color(0xFF007AFF),

        /// Home screen
        greyStone: Color(0xFFF5F5F5),
        coalBlack: Color(0xFF444444),
        coralBlue: Color(0xFFEBEEFC),
        cobatBlue: Color(0xFF0022EC),
        cornflower: Color(0xFFD6DDF9),

        /// Setting screen
        settingAppbar: Color(0xFF195777),
        settingBackground: Color(0xFF2A282D),
        settingTextColor: Color(0xFFD4D4D6),
        settingItemBackground: Color(0xFF4C4C4F),
        settingTitleBackground: Color(0xFF9FABBA),
        settingSeparateColor: Color(0xFF282828),

        /// profile screen
        profileAppbar: Color(0xFF195777),
        profileBackground: Color(0xFF2A282D),
        profileTextColor: Color(0xFFD4D4D6),
        profileItemBackground: Color(0xFF4C4C4F),
        profileSeparateColor: Color(0xFF282828),
        profileButtonColor: Color(0xFF195777),
        profileTextButtonColor: Color(0xFFD4D4D6),
        profileIconColor: Color(0xFF00AFA5),
        profileBarCodeBg: Color(0xFFD4D4D6),
        profileBarCodeText: Color(0xFF081012),

        /// sign in screen
        signInBackground: Color(0xFF4C4C4F),
        signInButtonColor: Color(0xFF195777),
        signInTextButtonColor: Color(0xFFD4D4D6),
        signInSeparateColor: Color(0xFFD4D4D6),
        signInTextColor: Color(0xFFD4D4D6),
        signInLinkColor: Color(0xFF195777),
        signInFocusColor: Color(0xFF00AFA5),

        /// register screen
        registerBackground: Color(0xFF4C4C4F),
        registerButtonColor: Color(0xFF195777),
        registerUnactivatedButtonColor: Color(0xFF778DEF),
        registerTextButtonColor: Color(0xFFD4D4D6),
        registerSeparateColor: Color(0xFFD4D4D6),
        registerTextColor: Color(0xFFD4D4D6),
        registerLinkColor: Color(0xFF195777),
        registerFocusColor: Color(0xFF00AFA5),

        /// forgot password screen
        forgotPasswordAppbar: Color(0xFF195777),
        forgotPasswordBackground: Color(0xFF4C4C4F),
        forgotPasswordButtonColor: Color(0xFF195777),
        forgotPasswordTextButtonColor: Color(0xFFD4D4D6),
        forgotPasswordSeparateColor: Color(0xFFD4D4D6),
        forgotPasswordTextColor: Color(0xFFD4D4D6),
        forgotPasswordLinkColor: Color(0xFF195777),
        forgotPasswordFocusColor: Color(0xFF00AFA5),
      ),
      const AppFonts(mainFont: 'CreatoDisplay', subFont: 'Inter')
    ],
  );
}
