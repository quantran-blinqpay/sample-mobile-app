import 'package:flutter/material.dart';
import '../../../../configs/app_themes/app_themes.dart';

class CinemaDirection extends StatelessWidget {
  const CinemaDirection({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    return Container(
      width: double.maxFinite,
      height: 48,
      padding: EdgeInsets.symmetric(horizontal: 10),
      color: Colors.white,
      child: GestureDetector(
        onTap: () {
          debugPrint('go to cinema location');
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Vinh Cine - Nghệ An',
              style: AppStyles.of(context)
                  .copyWith(color: appColors?.hintGray),
            ),
            Row(
              children: [
                Text(
                  '500m',
                  style: AppStyles.of(context)
                      .copyWith(color: appColors?.red),
                ),
                const SizedBox(width: 5),
                Icon(
                  Icons.directions,
                  size: 32,
                  color: appColors?.red,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
