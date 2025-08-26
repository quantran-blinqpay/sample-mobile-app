// ignore_for_file: must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:designerwardrobe/gen/assets.gen.dart';
import 'package:designerwardrobe/src/components/divider/custom_divider.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({
    super.key,
    required this.onPressed,
    required this.title,
    this.brightness = true,
    this.useCloseIcon = false,
  });

  Function onPressed;
  String title;
  bool brightness;
  bool useCloseIcon;

  late BuildContext _currentContext;

  @override
  Widget build(BuildContext context) {
    _currentContext = context;
    return Stack(
      children: [
        Visibility(visible: brightness, child: _backgroundShadow()),
        _appBar(context),
      ],
    );
  }

  Widget _appBar(BuildContext context) => SafeArea(
        child: SizedBox(
          height: 48,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                padding: EdgeInsets.all(5),
                icon: SvgPicture.asset(
                  useCloseIcon ? Assets.svgs.icClose : Assets.svgs.icArrowBack,
                  width: useCloseIcon ? null : 18,
                  height: useCloseIcon ? null : 18,
                ),
                onPressed: () {
                  onPressed();
                },
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 48.0),
                  child: Text(
                    title,
                    style: AppStyles.of(context).copyWith(
                      color: Colors.black,
                      fontSize: 14,
                      height: 13 / 14,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _backgroundShadow() {
    return Container(
      height: MediaQuery.of(_currentContext).size.width / 2.5,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.2, 0.5, 0.7, 1],
          colors: [
            Color.fromRGBO(0, 0, 0, 0.6),
            Color.fromRGBO(0, 0, 0, 0.45),
            Color.fromRGBO(0, 0, 0, 0.3),
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}

class CustomNativeAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  CustomNativeAppBar({
    super.key,
    this.onPressed,
    this.title,
    this.customTitle,
    this.useCloseIcon = false,
    this.hadBottomLine = false,
    this.actions,
    this.titleSpacing,
  });

  Function()? onPressed;
  String? title;
  Widget? customTitle;
  bool useCloseIcon;
  bool hadBottomLine;
  List<Widget>? actions;
  double? titleSpacing;

  late BuildContext _currentContext;
  late AppColors? appColors;

  @override
  Size get preferredSize => Size.fromHeight(48 + (hadBottomLine ? 0.5 : 0));

  @override
  Widget build(BuildContext context) {
    _currentContext = context;
    appColors = Theme.of(context).extension<AppColors>();

    return Column(
      children: [
        AppBar(
          toolbarHeight: 48,
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.white,
          leadingWidth: 48,
          leading: IconButton(
            padding: EdgeInsets.fromLTRB(16, 5, 5, 5),
            icon: SvgPicture.asset(
              useCloseIcon ? Assets.svgs.icClose : Assets.svgs.icArrowBack,
              width: useCloseIcon ? null : 18,
              height: useCloseIcon ? null : 18,
            ),
            onPressed: onPressed ?? () => _currentContext.router.pop(),
          ),
          titleSpacing: titleSpacing,
          title: customTitle ??
              Text(
                title ?? '',
                style: AppStyles.of(context).copyWith(
                  color: Colors.black,
                  fontSize: 14,
                  height: 13 / 14,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
          actions: actions,
        ),
        if (hadBottomLine) CustomDivider()
      ],
    );
  }
}
