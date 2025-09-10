// ignore_for_file: must_be_immutable

import 'package:qwid/src/configs/app_themes/app_styles.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qwid/src/components/loading_indicator/loading_indicator_widget.dart';
import 'package:qwid/src/configs/app_themes/app_colors.dart';

enum ShapeAppButton { circle, rectangle }

class AppButton extends StatelessWidget {
  String title;
  bool? isLoading;
  VoidCallback? onPressed;
  FontStyle? fontStyle;
  FontWeight? fontWeight;
  Color? textColor;
  Color? backgroundColor;
  BoxBorder? border;
  double fontSize;
  double radius;
  double? width;
  double? height;
  EdgeInsetsGeometry? padding;

  AppButton({
    super.key,
    this.title = '',
    this.isLoading = false,
    this.onPressed,
    this.border,
    this.fontStyle,
    this.textColor,
    this.backgroundColor,
    this.fontWeight = FontWeight.w600,
    this.fontSize = 16,
    this.radius = 10,
    this.width = double.infinity,
    this.height,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height ?? 50,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: border,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        // boxShadow: AppShadow.boxShadow,
      ),
      child: ButtonTheme(
        minWidth: 0.0,
        height: 0.0,
        padding: const EdgeInsets.all(0),
        child: TextButton(
          style: ButtonStyle(
            shape: WidgetStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0))),
          ),
          onPressed: onPressed,
          child: _buildBodyWidget(context),
        ),
      ),
    );
  }

  Widget _buildBodyWidget(BuildContext context) {
    if (isLoading ?? true) {
      return const CupertinoActivityIndicator(
          color: Colors.white,
          radius: 14);
    }
    return Text(
      title,
      style: AppStyles.of(context).copyWith(
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        color: textColor,
      ),
    );
  }
}

class AppWhiteButton extends AppButton {
  AppWhiteButton({
    super.key,
    super.title = '',
    super.isLoading = false,
    super.onPressed,
    super.fontStyle,
    super.fontWeight,
    super.fontSize,
  }) : super(
          textColor: AppColorss.blue,
          backgroundColor: Colors.white,
        );
}

class AppTintButton extends AppButton {
  AppTintButton({
    super.key,
    super.title = '',
    super.isLoading = false,
    super.onPressed,
    super.fontStyle,
    super.fontWeight,
    super.fontSize,
  }) : super(
          textColor: Colors.white,
          backgroundColor: AppColorss.main,
        );
}

class AppCrimsonButton extends AppButton {
  AppCrimsonButton({
    super.key,
    super.title = '',
    super.isLoading = false,
    super.onPressed,
    super.fontStyle,
    super.fontWeight,
    super.fontSize,
  }) : super(
          textColor: Colors.white,
          backgroundColor: AppColorss.crimson,
        );
}

class AppBorderButton extends AppButton {
  AppBorderButton({
    super.key,
    super.title = '',
    super.isLoading = false,
    super.onPressed,
    super.fontStyle,
    super.fontWeight,
    super.fontSize,
  }) : super(
          textColor: Colors.black,
          backgroundColor: Colors.white,
          border: Border.all(color: Colors.grey, width: 1),
        );
}

class ElevatedAppButton extends StatelessWidget {
  const ElevatedAppButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.height,
    this.width,
    required this.bgColor,
    required this.padding,
    required this.radius,
    this.isOutlined = false,
    this.borderColor,
    this.onLongPress,
    this.shape = ShapeAppButton.rectangle,
  });

  final VoidCallback? onPressed;
  final Function()? onLongPress;
  final Widget child;

  /// Default : 40px
  final double? height;
  final double? width;
  final Color bgColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final double radius;
  final ShapeAppButton shape;
  final bool? isOutlined;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: bgColor.darken(30),
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              shape == ShapeAppButton.rectangle ? radius : 100,
            ),
          ),
          side: isOutlined ?? false
              ? BorderSide(color: borderColor ?? Colors.amber)
              : BorderSide.none,
          elevation: 0,
          padding: padding,
          minimumSize: Size(0, height ?? 0),
        ),
        child: child,
      ),
    );
  }
}
