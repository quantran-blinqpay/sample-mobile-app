import 'package:qwid/src/configs/app_themes/app_colors.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:qwid/src/configs/app_themes/app_styles.dart';
import 'package:qwid/src/features/home/presentation/views/home/presenters/setting_presenter.dart';
import 'package:qwid/src/features/home/presentation/views/home/widgets/profile/setting_item_widget.dart';
import 'package:flutter/material.dart';

class BuyingWidget extends StatelessWidget {
  const BuyingWidget({super.key});

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
                  'Buying',
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
                onTap: (){},
                item: SettingPresenter(
                    icon: icProfileBag, text: "My purchases", isNew: false)),
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
                onTap: (){},
                item: SettingPresenter(
                    icon: icProfileBell, text: "Offers I've sent", isNew: false)),
          ),
        )
      ],
    );
  }
}
