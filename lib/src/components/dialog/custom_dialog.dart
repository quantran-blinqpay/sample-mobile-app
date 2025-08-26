// ignore_for_file: use_build_context_synchronously

import 'package:designerwardrobe/src/configs/app_themes/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialog {
  static Future<bool> showConfirmDialog(
    BuildContext context, {
    required String title,
    String? subtitle,
    String? negativeText,
    Future<dynamic> Function()? onNegative,
    String? positiveText,
    Color? positiveColor,
    Future<dynamic> Function()? onPositive,
    Future<dynamic> Function()? onPop,
    bool? onlyConfirmButton = false,
    bool barrierDismissible = true,
  }) async {
    final appColors = Theme.of(context).extension<AppColors>()!;

    return await showCupertinoDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: appColors.black,
          ),
        ),
        content: subtitle?.isNotEmpty ?? false
            ? Text(
                subtitle ?? '',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: appColors.black,
                ),
              )
            : null,
        actions: [
          if (!(onlyConfirmButton ?? true))
            CupertinoDialogAction(
              onPressed: () async {
                if (onNegative != null) {
                  await onNegative();
                }
                Navigator.pop(ctx, false);
              },
              child: Text(
                negativeText ?? 'Cancel',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: appColors.vividBlue,
                ),
              ),
            ),
          CupertinoDialogAction(
            onPressed: () async {
              if (onPositive != null) {
                await onPositive();
              }
              Navigator.pop(ctx, true);
              if (onPop != null) {
                await onPop();
              }
            },
            child: Text(
              positiveText ?? 'Ok',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w400,
                color: positiveColor ?? appColors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
