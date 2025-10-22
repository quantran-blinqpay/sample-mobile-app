// ignore_for_file: must_be_immutable

import 'package:qwid/gen/assets.gen.dart';
import 'package:qwid/src/components/text_field/custom_text_field.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:qwid/src/configs/app_themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchTextField extends CustomTextField {
  SearchTextField({
    super.key,
    super.controller,
    super.keyboardType,
    super.hintText = "",
    super.hintStyle,
    super.obscureText = false,
    super.enabledBorderColor = AppColorss.borderColor,
    super.focusedBorderColor = AppColorss.borderColor,
    super.closeColor,
    super.contentPadding,
    super.inputFormatters,
    super.onChanged,
    super.onClear,
  });

  @override
  State<CustomTextField> createState() => SearchTextFieldState();
}

class SearchTextFieldState extends CustomTextFieldState {
  @override
  InputDecoration decoration() {
    return InputDecoration(
      suffixIcon:
          widget.obscureText
              ? IconButton(
                icon:
                    passwordVisible
                        ? Icon(
                          Icons.remove_red_eye_outlined,
                          color: color,
                          size: 20,
                        )
                        : SvgPicture.asset(
                          Assets.svgs.icEyeOff,
                          colorFilter: ColorFilter.mode(
                            color!,
                            BlendMode.srcIn,
                          ),
                        ),
                onPressed: () {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
              )
              : clearVisible
              ? IconButton(
                icon: SvgPicture.asset(icQwidClear, width: 20, height: 20),
                onPressed: () {
                  setState(() {
                    clearVisible = false;
                  });
                  widget.controller?.clear();
                  if (widget.onClear != null) {
                    widget.onClear!();
                  }
                },
              )
              : null,
      prefixIcon: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SvgPicture.asset(icQwidSearch, width: 5, height: 5),
      ),
      hintText: "Search for a country",
      hintStyle: const TextStyle(
        fontFamily: "Creato Display",
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color(0xFF8C909C),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 0),
      filled: true,
      fillColor: const Color(0xFFFAFAFA),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(100),
        borderSide: BorderSide.none,
      ),
    );
  }
}
