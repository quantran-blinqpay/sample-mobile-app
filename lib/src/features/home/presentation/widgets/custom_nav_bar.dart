import 'package:qwid/src/configs/app_themes/app_colors.dart';
import 'package:qwid/src/configs/app_themes/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<NavItem> items;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    return Container(
      padding: EdgeInsets.only(
        top: 4,
        bottom: MediaQuery.of(context).viewPadding.bottom > 0
            ? MediaQuery.of(context).viewPadding.bottom
            : 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: appColors?.black.withAlpha(30) ?? Colors.black,
              blurRadius: 6),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.asMap().entries.map((item) {
          return Expanded(
            child: GestureDetector(
              onTap: () => onTap(item.key),
              child: _buildTabBarItem(
                context,
                label: item.value.label,
                icon: item.value.icon,
                iconSelected: item.value.iconSelected,
                index: item.value.index,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTabBarItem(BuildContext context,
      {required String label,
      required String icon,
      required String iconSelected,
      required int index}) {
    final appColors = Theme.of(context).extension<AppColors>();
    return ColoredBox(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 28,
            height: 28,
            child: SvgPicture.asset(
              currentIndex == index ? iconSelected : icon,
            ),
          ),
          Text(
            label.toUpperCase(),
            style: AppStyles.of(context).copyWith(
                fontSize: 9,
                fontWeight:
                    currentIndex == index ? FontWeight.w600 : FontWeight.w400,
                color: appColors?.black),
          ),
        ],
      ),
    );
  }
}

class NavItem {
  final int index;
  final String icon;
  final String iconSelected;
  final String label;

  NavItem(
      {required this.icon,
      required this.iconSelected,
      required this.label,
      required this.index});
}
