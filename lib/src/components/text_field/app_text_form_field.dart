// ignore_for_file: must_be_immutable

import 'package:designerwardrobe/gen/assets.gen.dart';
import 'package:designerwardrobe/src/components/button/app_button.dart';
import 'package:designerwardrobe/src/components/form/app_form.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

enum EnumStatusValidate { error, success }

class AppTextFormField extends AppFormField<String> {
  AppTextFormField({
    super.key,
    this.controller,
    super.validator,
    Widget? prefixIcon,
    Widget? suffixIcon,
    Color? backgroundColor,
    Color? errorColor,
    Color? helperTextColor,
    Color? borderErrorColor,
    Color? borderColor,
    Color? focusColor,
    bool autoFocus = false,
    bool enabled = true,
    bool readOnly = false,
    bool obscureText = false,
    TextInputType? keyboardType,
    VoidCallback? onTap,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    Function? onClear,
    String? initialValue,
    AutovalidateMode? autovalidateMode,
    int? maxLength,
    int? maxLines = 1,
    String? hintText,
    TextStyle? hintStyle,
    FocusNode? focusNode,
    List<TextInputFormatter>? inputFormatters,
  }) : super(
          autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
          initialValue:
              controller != null ? controller.text : (initialValue ?? ''),
          builder: (AppFormFieldState<String> field) {
            final state = field as _FTextFormFieldState;

            void onChangedHandler(String value) {
              if (onChanged != null) {
                onChanged(value);
              }
              field.didChange(value);
            }

            return AbsorbPointer(
              absorbing: !enabled,
              child: AppTextField(
                key: key,
                controller: state._effectiveController,
                inputFormatters: inputFormatters,
                focusNode: focusNode,
                hintStyle: hintStyle,
                hintText: hintText,
                helperText: field.statusText,
                helperTextColor: field.status == TFStatus.normal
                    ? helperTextColor
                    : field.status == TFStatus.success
                        ? Colors.green
                        : errorColor,
                prefixIcon: prefixIcon,
                maxLength: maxLength,
                maxLines: maxLines,
                onFieldSubmitted: onSubmitted,
                suffixIcon: suffixIcon,
                backgroundColor: backgroundColor,
                autoFocus: autoFocus,
                readOnly: readOnly,
                keyboardType: keyboardType,
                onChanged: onChangedHandler,
                onTap: onTap,
                obscureText: obscureText,
                onClear: onClear,
                borderColor: borderColor,
                borderErrorColor: borderErrorColor,
                enabled: enabled,
                focusColor: focusColor,
              ),
            );
          },
        );

  final TextEditingController? controller;

  @override
  AppFormFieldState<String> createState() {
    return _FTextFormFieldState();
  }
}

class _FTextFormFieldState extends AppFormFieldState<String> {
  late TextEditingController _controller;

  TextEditingController get _effectiveController =>
      widget.controller ?? _controller;

  @override
  AppTextFormField get widget => super.widget as AppTextFormField;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = TextEditingController(text: widget.initialValue);
    } else {
      widget.controller!.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(AppTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _controller =
            TextEditingController.fromValue(oldWidget.controller?.value);
      }
      if (widget.controller != null) {
        setValue(widget.controller!.text);
        if (oldWidget.controller == null) {
          _controller = TextEditingController();
        }
      }
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    super.dispose();
  }

  @override
  void didChange(String? value) {
    super.didChange(value);

    if (_effectiveController.text != value) {
      _effectiveController.text = value!;
    }
  }

  @override
  void reset() {
    super.reset();
    setState(() {
      _effectiveController.text = widget.initialValue ?? '';
    });
  }

  void _handleControllerChanged() {
    if (_effectiveController.text != value) {
      didChange(_effectiveController.text);
    }
  }
}

class AppTextField extends StatefulWidget {
  AppTextField({
    super.key,
    this.helperText,
    this.prefixIcon,
    this.suffixIcon,
    this.backgroundColor,
    this.borderColor,
    this.autoFocus = false,
    this.controller,
    this.enabled = true,
    this.readOnly = false,
    this.focusColor,
    this.keyboardType,
    this.onTap,
    this.onChanged,
    this.validator,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.obscureText = false,
    this.obscuringCharacter = '*',
    this.maxLength,
    this.maxLines,
    this.inputFormatters,
    this.borderErrorColor = Colors.red,
    this.hintText = '',
    this.hintStyle,
    this.focusNode,
    this.padding,
    this.helperTextColor,
    this.onClear,
  });

  final TextEditingController? controller;
  final String? helperText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? focusColor;
  final Color? borderErrorColor;
  final bool autoFocus;
  final bool enabled;
  final bool readOnly;
  final TextInputType? keyboardType;
  final VoidCallback? onTap;
  final Function(String)? onChanged;
  final FormFieldValidator<String>? validator;
  final VoidCallback? onEditingComplete;
  final Function(String)? onFieldSubmitted;
  final bool obscureText;
  final String obscuringCharacter;
  final int? maxLength;
  final Color? helperTextColor;
  final String? hintText;
  final TextStyle? hintStyle;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final EdgeInsets? padding;
  Function? onClear;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _isFocus = false;
  bool _isShowClear = false;
  TextEditingController _controller = TextEditingController();
  late AppColors _appColors;

  @override
  void initState() {
    if (widget.controller != null) {
      _controller = widget.controller!;
      _isShowClear = widget.controller!.text.isNotEmpty;
    }
    _controller.addListener(clearIconHandle);

    super.initState();
  }

  void clearIconHandle() {
    if (mounted) {
      if (_controller.text.isEmpty && _isShowClear) {
        setState(() {
          _isShowClear = false;
        });
      } else if (_controller.text.isNotEmpty && !_isShowClear) {
        setState(() {
          _isShowClear = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _appColors = Theme.of(context).extension<AppColors>()!;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: widget.padding,
          constraints: BoxConstraints(minHeight: 48),
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? _appColors.white,
            borderRadius: BorderRadius.all(Radius.circular(6)),
            border: Border.all(
              width: 1,
              color: widget.helperText != null
                  ? widget.borderErrorColor ?? _appColors.red
                  : _isFocus
                      ? widget.focusColor ?? _appColors.silverSand
                      : widget.borderColor ?? _appColors.silverSand,
            ),
          ),
          child: Row(
            children: [
              _buildPrefixIcon(),
              Expanded(
                child: Focus(
                  onFocusChange: (value) {
                    setState(() {
                      _isFocus = value;
                    });
                  },
                  child: Material(
                    color: Colors.transparent,
                    child: TextFormField(
                      enableInteractiveSelection: !widget.readOnly,
                      scrollPadding: EdgeInsets.all(20.0) +
                          EdgeInsets.fromLTRB(0, 0, 0, 44.0),
                      focusNode: widget.focusNode,
                      inputFormatters: widget.inputFormatters,
                      maxLines: widget.maxLines,
                      maxLength: widget.maxLength,
                      onChanged: widget.onChanged,
                      onTap: widget.onTap,
                      onFieldSubmitted: widget.onFieldSubmitted,
                      validator: widget.validator,
                      keyboardType: widget.keyboardType,
                      controller: widget.controller,
                      autofocus: widget.autoFocus,
                      enabled: widget.enabled,
                      readOnly: widget.readOnly,
                      textAlignVertical: TextAlignVertical.center,
                      obscureText: widget.obscureText,
                      obscuringCharacter: widget.obscuringCharacter,
                      onEditingComplete: widget.onEditingComplete,
                      decoration: InputDecoration(
                        hintText: widget.hintText,
                        constraints: BoxConstraints(maxHeight: 120),
                        hintStyle: widget.hintStyle ??
                            AppStyles.of(context).copyWith(
                              fontSize: 14,
                              color: _appColors.manatee,
                              fontWeight: FontWeight.w500,
                            ),
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                ),
              ),
              ((widget.readOnly) ? true : (_isFocus))
                  ? _buildClear()
                  : SizedBox(),
              _buildSuffix(),
            ],
          ),
        ),
        if (widget.helperText?.isNotEmpty ?? false)
          Padding(
            padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
            child: Text(
              widget.helperText ?? '',
              overflow: TextOverflow.ellipsis,
              style: AppStyles.of(context).copyWith(
                fontSize: 12,
                color: widget.helperTextColor ?? _appColors.red,
                fontWeight: FontWeight.normal,
              ),
              maxLines: 2,
            ),
          ),
      ],
    );
  }

  Widget _buildPrefixIcon() => widget.prefixIcon != null
      ? Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: widget.prefixIcon,
        )
      : SizedBox(width: 16);

  Widget _buildClear() {
    if (_isShowClear) {
      return ElevatedAppButton(
        onPressed: () {
          widget.controller!.clear();
          if (widget.onClear != null) {
            widget.onClear!();
          }
        },
        bgColor: Colors.transparent,
        padding: EdgeInsets.zero,
        radius: 100,
        width: 40,
        height: 40,
        child: SvgPicture.asset(Assets.svgs.icCloseCircle),
      );
    }
    return SizedBox();
  }

  Widget _buildSuffix() => widget.suffixIcon != null
      ? GestureDetector(
          onTap: widget.onTap,
          child: Container(
            height: widget.suffixIcon is Text ? null : 32,
            width: widget.suffixIcon is Text ? null : 32,
            padding: EdgeInsets.only(right: 16),
            alignment: Alignment.center,
            child: widget.suffixIcon,
          ),
        )
      : SizedBox(width: 8);
}
