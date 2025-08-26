import 'dart:io';

import 'package:designerwardrobe/src/components/loading_indicator/app_loader.dart';
import 'package:designerwardrobe/src/components/scaffold/swipe_back_listener.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/services.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.body,
    super.key,
    this.leading,
    this.isLoading = false,
    this.isBackBtnVisible = true,
    this.shouldOverridePopScope = false,
    this.onPop,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.extendBody = false,
    this.paddingAppbar,
    this.bottomSheet,
    this.appBar,
    this.extendBodyBehindAppBar = false,
  });
  static const platform = MethodChannel('chocolate.method.channel');

  final Widget body;
  final List<Widget>? leading;

  final bool isLoading;
  final bool isBackBtnVisible;

  final VoidCallback? onPop;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final bool? resizeToAvoidBottomInset;
  final bool extendBody;
  final EdgeInsetsGeometry? paddingAppbar;
  final Widget? bottomSheet;
  final bool shouldOverridePopScope;
  final PreferredSizeWidget? appBar;
  final bool extendBodyBehindAppBar;
  @override
  Widget build(BuildContext context) => AppLoader(
        isLoading: isLoading,
        child: AppWillPopScope(
          onPop: isBackBtnVisible ? () => onPopHandler(context, onPop) : null,
          shouldOveridePopScope: shouldOverridePopScope,
          child: Scaffold(
            appBar: appBar,
            extendBody: extendBody,
            extendBodyBehindAppBar: extendBodyBehindAppBar,
            resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            backgroundColor: backgroundColor,
            bottomNavigationBar: bottomNavigationBar,
            body: Stack(
              fit: StackFit.expand,
              children: [body],
            ),
            bottomSheet: bottomSheet,
              // bottomNavigationBar
          ),
        ),
      );

  Widget _appBar(BuildContext context) => Padding(
        padding: paddingAppbar ??
            EdgeInsets.fromLTRB(
                50, 50, 50, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _backButton(context),
            const Spacer(),
            ...leading ?? [],
          ],
        ),
      );

  Widget _backButton(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Visibility(
      visible: isBackBtnVisible,
      child: GestureDetector(
        child: Icon(
          Icons.arrow_back_ios,
          size: 24,
          color: appColors.black,
        ),
        onTap: () => onPopHandler(context, onPop),
      ),
    );
  }

  static void onPopHandler(BuildContext context, VoidCallback? onPop) {
    try {
      /**
       * issue: https://chocfin.atlassian.net/browse/CHOC-5938
       * Only happen on iOS
       * No input is focused but Keyboard is still appear
       * Solution: Force hiding keyboard when go back
       * Flutter way FocusManager.instance.primaryFocus?.unfocus(); or FocusScope.of(context).unfocus(); doesn't work
       * => Using iOS native method: application.keyWindow?.endEditing(true);
       * 
      */
      if (Platform.isIOS) {
        platform.invokeMethod<void>('hide_keyboard');
      }
    } catch (_) {
      debugPrint('error on hide native keyboard');
    }
    (onPop != null) ? onPop.call() : context.router.pop();
  }
}
