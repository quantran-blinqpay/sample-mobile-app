// ignore_for_file: must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:qwid/gen/assets.gen.dart';
import 'package:qwid/src/components/button/app_button.dart';
import 'package:qwid/src/configs/app_themes/app_themes.dart';
import 'package:qwid/src/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SigninDialog extends StatelessWidget {
  SigninDialog({
    super.key,
    this.title,
    this.subTitle,
  });

  final String? title;
  final String? subTitle;

  late AppColors? appColors;

  @override
  Widget build(BuildContext context) {
    appColors = Theme.of(context).extension<AppColors>();

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 56.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (title?.isNotEmpty ?? false)
                Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Text(
                    title!,
                    style: AppStyles.of(context).copyWith(
                      color: appColors!.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              if (subTitle?.isNotEmpty ?? false)
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    subTitle ?? '',
                    style: AppStyles.of(context).copyWith(
                      color: appColors!.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 21),
                child: ElevatedAppButton(
                  onPressed: () {},
                  bgColor: Color(0xFF1877F2),
                  padding: EdgeInsets.zero,
                  radius: 8,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: appColors!.lightGray),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          Assets.svgs.icFacebook,
                          width: 18,
                          height: 18,
                          colorFilter: ColorFilter.mode(
                            appColors!.white,
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Sign in with Facebook',
                          style: AppStyles.of(context).copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: appColors!.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedAppButton(
                      onPressed: () {
                        context.router.pop();
                        context.router.push(RegisterScreenRoute());
                      },
                      bgColor: appColors!.outerSpace,
                      padding: EdgeInsets.all(13.5),
                      radius: 8,
                      child: Text(
                        "SIGN UP",
                        style: TextStyle(
                          color: appColors!.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedAppButton(
                      onPressed: () async {
                        context.router.pop();
                        await context.router.push(SignInScreenRoute());
                      },
                      bgColor: appColors!.white,
                      padding: EdgeInsets.zero,
                      radius: 8,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(12.5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: appColors!.black,
                          ),
                        ),
                        child: Text(
                          "SIGN IN",
                          style: TextStyle(
                            color: appColors!.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
