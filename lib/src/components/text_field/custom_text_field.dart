// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:designerwardrobe/gen/assets.gen.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

enum ShapeTextFieldButton { circle, rectangle }

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? hintText;
  final TextStyle? hintStyle;
  final EdgeInsetsGeometry? contentPadding;
  bool obscureText;
  Color enabledBorderColor;
  Color focusedBorderColor;
  Color? closeColor;
  final List<TextInputFormatter>? inputFormatters;
  Function(String)? onChanged;
  Function()? onClear;

  CustomTextField({
    super.key,
    this.controller,
    this.keyboardType,
    this.hintText = "",
    this.hintStyle,
    this.obscureText = false,
    this.enabledBorderColor = AppColorss.borderColor,
    this.focusedBorderColor = AppColorss.borderColor,
    this.closeColor,
    this.contentPadding,
    this.inputFormatters,
    this.onChanged,
    this.onClear,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _passwordVisible = false;
  bool _clearVisible = false;
  bool? _hasFocus = false;
  late AppColors? appColors;

  @override
  void initState() {
    _clearVisible = widget.controller?.text.isNotEmpty == true;
    _color = widget.enabledBorderColor;
    super.initState();
  }

  late Color? _color;
  @override
  Widget build(BuildContext context) {
    appColors = Theme.of(context).extension<AppColors>();

    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          _hasFocus = hasFocus;
          _color =
              !hasFocus ? widget.enabledBorderColor : widget.focusedBorderColor;
        });
      },
      child: TextFormField(
        onChanged: (String text) {
          setState(() {
            _clearVisible = widget.controller?.text.isNotEmpty == true;
          });
          if (widget.onChanged != null) {
            widget.onChanged!(text);
          }
        },
        controller: widget.controller,
        inputFormatters: widget.inputFormatters,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: widget.hintStyle ??
              AppStyles.of(context).copyWith(
                fontSize: 16,
                color: appColors!.outerSpace,
                fontWeight: FontWeight.normal,
              ),
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: _passwordVisible
                      ? Icon(
                          Icons.remove_red_eye_outlined,
                          color: _color,
                          size: 20,
                        )
                      : SvgPicture.asset(
                          Assets.svgs.icEyeOff,
                          colorFilter:
                              ColorFilter.mode(_color!, BlendMode.srcIn),
                        ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                )
              : _clearVisible && (_hasFocus ?? false)
                  ? IconButton(
                      icon: Container(
                        width: 16,
                        height: 16,
                        padding: const EdgeInsets.all(4.3),
                        decoration: BoxDecoration(
                          color: _color,
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          Assets.svgs.icClose,
                          colorFilter: const ColorFilter.mode(
                              Colors.white, BlendMode.srcIn),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _clearVisible = false;
                        });
                        widget.controller?.clear();
                        if (widget.onClear != null) {
                          widget.onClear!();
                        }
                      },
                    )
                  : null,
          suffixIconConstraints: BoxConstraints(maxHeight: 40),
          focusedBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: widget.focusedBorderColor, width: 0.5),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: widget.enabledBorderColor, width: 0.5),
          ),
          contentPadding: widget.contentPadding ?? EdgeInsets.all(8),
        ),
        obscureText: (widget.obscureText == true && !_passwordVisible),
      ),
    );
  }
}

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? hintText;
  final TextStyle? hintStyle;
  bool obscureText;
  Color? enabledBorderColor;
  Color? focusedBorderColor;
  Color? closeColor;
  Function()? onTap;
  bool? readOnly;
  Widget? prefixIcon;
  Widget? suffixIcon;
  ShapeTextFieldButton shape;
  double? height;
  Color? backgroundColor;
  final List<TextInputFormatter>? inputFormatters;
  Function(String)? onFieldSubmitted;
  Function()? onClear;
  TextInputAction? textInputAction;
  final Function(String)? onChanged;
  final BorderRadius? borderRadius;
  final int? maxLines;
  final InputDecoration? decoration;
  final TextStyle? style;
  final bool? enabled;
  final FocusNode? focusNode;
  final FormFieldValidator<String>? validator;

  CustomTextFormField({
    super.key,
    required this.controller,
    this.keyboardType,
    this.hintText = "",
    this.hintStyle,
    this.obscureText = false,
    this.enabledBorderColor,
    this.focusedBorderColor,
    this.closeColor,
    this.onTap,
    this.readOnly = false,
    this.prefixIcon,
    this.suffixIcon,
    this.shape = ShapeTextFieldButton.rectangle,
    this.height,
    this.backgroundColor,
    this.inputFormatters,
    this.onFieldSubmitted,
    this.onClear,
    this.textInputAction,
    this.onChanged,
    this.borderRadius,
    this.maxLines = 1,
    this.decoration,
    this.style,
    this.enabled,
    this.focusNode,
    this.validator,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _passwordVisible = false;
  bool _clearVisible = false;
  bool? _hasFocus = false;
  late AppColors? appColors;
  Timer? _debounce;
  late TextEditingController controller;

  @override
  void initState() {
    _clearVisible = widget.controller.text.isNotEmpty == true;
    _color = widget.enabledBorderColor ?? AppColorss.borderColor;
    controller = widget.controller;
    controller.addListener(onChangeValue);
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    controller.removeListener(onChangeValue);
    super.dispose();
  }

  void onChangeValue() {
    setState(() {
      _clearVisible = controller.text.isNotEmpty;
    });
  }

  late Color? _color;
  @override
  Widget build(BuildContext context) {
    appColors = Theme.of(context).extension<AppColors>();

    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          _hasFocus = hasFocus;
          _color = !hasFocus
              ? (widget.enabledBorderColor ?? AppColorss.borderColor)
              : widget.focusedBorderColor ?? AppColorss.borderColor;
        });
      },
      child: SizedBox(
        height: widget.height,
        child: TextFormField(
          focusNode: widget.focusNode,
          style: widget.style,
          onTap: widget.onTap,
          onChanged: (String text) {
            if (_debounce?.isActive ?? false) _debounce?.cancel();
            _debounce = Timer(const Duration(milliseconds: 500), () {
              widget.onChanged?.call(text);
            });
          },
          enabled: widget.enabled,
          onFieldSubmitted: widget.onFieldSubmitted,
          textInputAction: widget.textInputAction,
          controller: controller,
          keyboardType: widget.keyboardType,
          readOnly: widget.readOnly ?? false,
          inputFormatters: widget.inputFormatters,
          maxLines: widget.maxLines,
          validator: widget.validator,
          decoration: widget.decoration ??
              InputDecoration(
                prefixIcon: widget.prefixIcon,
                fillColor: widget.backgroundColor ?? Colors.white,
                filled: true,
                hintText: widget.hintText,
                hintStyle: widget.hintStyle ??
                    AppStyles.of(context).copyWith(
                      fontSize: 14,
                      color: appColors!.manatee,
                      fontWeight: FontWeight.w500,
                    ),
                suffixIcon: widget.readOnly == true ? SizedBox() : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    widget.obscureText
                        ? IconButton(
                            icon: _passwordVisible
                                ? Icon(
                                    Icons.remove_red_eye_outlined,
                                    color: _color,
                                    size: 20,
                                  )
                                : SvgPicture.asset(
                                    Assets.svgs.icEyeOff,
                                    colorFilter: ColorFilter.mode(
                                        _color!, BlendMode.srcIn),
                                  ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          )
                        : _clearVisible &&
                                ((widget.readOnly ?? false)
                                    ? true
                                    : (_hasFocus ?? false))
                            ? IconButton(
                                icon: Container(
                                  width: 16,
                                  height: 16,
                                  padding: const EdgeInsets.all(4.3),
                                  decoration: BoxDecoration(
                                    color: _color,
                                    shape: BoxShape.circle,
                                  ),
                                  child: SvgPicture.asset(
                                    Assets.svgs.icClose,
                                    colorFilter: const ColorFilter.mode(
                                        Colors.white, BlendMode.srcIn),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _clearVisible = false;
                                  });
                                  controller.clear();
                                  if (widget.onClear != null) {
                                    widget.onClear!();
                                  }
                                  widget.onChanged?.call('');
                                },
                              )
                            : SizedBox(),
                    widget.suffixIcon ?? SizedBox(),
                  ],
                ),
                suffixIconConstraints: BoxConstraints(maxHeight: 40),
                focusedBorder: OutlineInputBorder(
                  borderRadius: widget.borderRadius ??
                      BorderRadius.circular(
                          widget.shape == ShapeTextFieldButton.circle
                              ? 100
                              : 5),
                  borderSide: BorderSide(
                    color: widget.focusedBorderColor ?? Colors.transparent,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: widget.borderRadius ??
                      BorderRadius.circular(
                          widget.shape == ShapeTextFieldButton.circle
                              ? 100
                              : 5),
                  borderSide: BorderSide(
                    color: widget.enabledBorderColor ?? Colors.transparent,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: widget.borderRadius ??
                      BorderRadius.circular(
                          widget.shape == ShapeTextFieldButton.circle
                              ? 100
                              : 5),
                  borderSide: BorderSide(color: appColors!.lightGray),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: widget.borderRadius ??
                      BorderRadius.circular(
                          widget.shape == ShapeTextFieldButton.circle
                              ? 100
                              : 5),
                  borderSide: BorderSide(color: appColors!.red),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: widget.borderRadius ??
                      BorderRadius.circular(
                          widget.shape == ShapeTextFieldButton.circle
                              ? 100
                              : 5),
                  borderSide: BorderSide(color: appColors!.red),
                ),
                contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
              ),
          obscureText: (widget.obscureText == true && !_passwordVisible),
        ),
      ),
    );
  }
}
