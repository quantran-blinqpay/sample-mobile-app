import 'package:designerwardrobe/src/configs/app_themes/app_colors.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_styles.dart';
import 'package:designerwardrobe/src/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:designerwardrobe/src/features/home/presentation/views/home/presenters/setting_presenter.dart';
import 'package:designerwardrobe/src/features/home/presentation/views/home/widgets/profile/new_badge_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingItemWidget extends StatelessWidget {
  const SettingItemWidget({required this.onTap, required this.item, super.key});

  final SettingPresenter item;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: state.isSignedIn ? onTap : null,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            color: appColors.white,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SvgPicture.asset(
                    item.icon,
                    width: 25,
                    height: 25,
                    color: !state.isSignedIn ? appColors.manatee : Colors.black,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          item.text,
                          style: AppStyles.of(context).copyWith(
                            color: item.isNew
                                ? appColors.vividBlue
                                : !state.isSignedIn
                                    ? appColors.manatee
                                    : Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      item.isNew ? NewBadgeWidget() : SizedBox.shrink(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 15,
                    color: !state.isSignedIn ? appColors.manatee : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
