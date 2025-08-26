import 'package:auto_route/auto_route.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_colors.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_images.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_styles.dart';
import 'package:designerwardrobe/src/features/home/presentation/views/home/presenters/setting_presenter.dart';
import 'package:designerwardrobe/src/features/home/presentation/views/home/widgets/profile/setting_item_widget.dart';
import 'package:designerwardrobe/src/router/router.dart';
import 'package:flutter/material.dart';

class SellingWidget extends StatelessWidget {
  const SellingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ColoredBox(
          color: Colors.transparent,
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Center(
                child: Text(
                  'Selling',
                  style: AppStyles.of(context).copyWith(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
        ColoredBox(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              color: appColors!.silverSand,
              height: 0.5,
            ),
          ),
        ),
        ColoredBox(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SettingItemWidget(
                onTap: () {
                  context.router.push(SellerScreenRoute());
                },
                item: SettingPresenter(
                    icon: icProfileMoney, text: "My Sales", isNew: false)),
          ),
        ),
        ColoredBox(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              color: appColors.silverSand,
              height: 0.5,
            ),
          ),
        ),
        ColoredBox(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SettingItemWidget(
                onTap: () {},
                item: SettingPresenter(
                    icon: icProfileBell, text: "Offers I've Received", isNew: false)),
          ),
        )
      ],
    );
  }

}

