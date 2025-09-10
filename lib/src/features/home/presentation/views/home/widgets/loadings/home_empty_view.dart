import 'package:qwid/src/configs/app_themes/app_styles.dart';
import 'package:flutter/material.dart';

class HomeEmptyView extends StatelessWidget {
  const HomeEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Empty', style: AppStyles.of(context).copyWith(color: Colors.black),),
    );
  }

}