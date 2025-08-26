import 'package:flutter/material.dart';
import 'package:designerwardrobe/src/components/button/icon_button.dart';

import 'my_scaffold.dart';

class BackScaffold extends MyScaffold {
  const BackScaffold(
      {super.key,
      required this.title,
      required this.onBackTap,
      required super.child});

  final String title;
  final VoidCallback onBackTap;

  @override
  Widget? get leading {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomIconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 32),
          onTap: onBackTap,
          width: 48,
          height: 48,
        ),
        Text(title)
      ],
    );
  }
}
