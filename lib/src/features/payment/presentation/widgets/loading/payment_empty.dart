import 'package:qwid/gen/assets.gen.dart';
import 'package:qwid/src/components/scaffold/app_scaffold.dart';
import 'package:qwid/src/configs/app_themes/app_colors.dart';
import 'package:qwid/src/configs/app_themes/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentEmpty extends StatelessWidget {
  const PaymentEmpty({super.key, required this.error});

  final String error;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return AppScaffold(
      appBar: AppBar(
        toolbarHeight: 48,
        automaticallyImplyLeading: false,
        leading: SizedBox(width: 30, height: 30),
        backgroundColor: appColors.lavender,
        title: Center(
          child: Text(
            'SECURE CHECKOUT',
            style: AppStyles.of(context).copyWith(
              color: Colors.black,
              fontSize: 18,
              height: 13 / 14,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.all(5),
            icon: SvgPicture.asset(
              Assets.svgs.icClose,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
      body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Text(
              error,
              style: AppStyles.of(context).copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
            ),
          ),
      ),
    );
  }

}