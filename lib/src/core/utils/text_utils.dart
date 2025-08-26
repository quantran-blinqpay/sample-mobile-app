import 'package:flutter/material.dart';

class TextUtils {
  static void setTextSafely(TextEditingController ctl, String txt) {
    if (ctl.text == txt) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ctl.value = ctl.value.copyWith(
        text: txt,
        selection: TextSelection.collapsed(offset: txt.length),
        composing: TextRange.empty,
      );
    });
  }
}
