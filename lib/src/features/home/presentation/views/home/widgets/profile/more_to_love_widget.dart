import 'package:qwid/src/configs/app_themes/app_styles.dart';
import 'package:flutter/material.dart';

class MoreToLoveWidget extends StatelessWidget {
  const MoreToLoveWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.orange,
      child: SizedBox(
        width: double.infinity,
        height: 200,
        child: Center(
          child: Text('More To Love', style: AppStyles.of(context).copyWith(color: Colors.white),),
        ),
      ),
    );
  }

}