import 'package:auto_route/auto_route.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_colors.dart';
import 'package:designerwardrobe/src/features/home/presentation/views/home/presenters/setting_presenter.dart';
import 'package:designerwardrobe/src/features/home/presentation/views/home/widgets/profile/setting_item_widget.dart';
import 'package:designerwardrobe/src/router/router.dart';
import 'package:flutter/material.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    return SliverList.separated(
      itemCount: settings.length,
      itemBuilder: (BuildContext context, int index) {
        return ColoredBox(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SettingItemWidget(
                  onTap: () {
                    if (settings[index].text.toLowerCase() ==
                        'My Profile'.toLowerCase()) {
                      context.router.push(ProfileScreenRoute());
                    } else if (settings[index].text.toLowerCase() ==
                        'My wallet'.toLowerCase()) {
                      context.router.push(WalletScreenRoute());
                    } else if (settings[index].text.toLowerCase() ==
                        'My drafts'.toLowerCase()) {
                      context.router.push(DraftsScreenRoute());
                    }
                  },
                  item: settings[index]),
            ));
      },
      separatorBuilder: (BuildContext context, int index) {
        return ColoredBox(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              color: appColors!.silverSand,
              height: 0.5,
            ),
          ),
        );
      },
    );
  }
}
