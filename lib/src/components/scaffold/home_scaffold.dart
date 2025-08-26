import 'package:flutter/material.dart';
import 'package:designerwardrobe/src/components/button/icon_button.dart';

import 'my_scaffold.dart';

class HomeScaffold extends MyScaffold {
  const HomeScaffold(
      {super.key, required this.onProfileTap, required super.child});

  final VoidCallback onProfileTap;

  @override
  Widget? get leading {
    return CustomIconButton(
      icon: const Icon(Icons.account_circle, size: 32),
      onTap: onProfileTap,
      width: 48,
      height: 48,
    );
  }

  @override
  Widget? get center => Text('VinhCine');
}
