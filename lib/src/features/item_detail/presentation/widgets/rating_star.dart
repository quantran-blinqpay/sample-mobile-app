import 'package:designerwardrobe/src/configs/app_themes/app_colors.dart';
import 'package:flutter/material.dart';

class StarRatingWidget extends StatelessWidget {
  final double rating;
  final int starCount;
  final Color? color;
  final double size;

  const StarRatingWidget({
    super.key,
    required this.rating,
    this.starCount = 5,
    this.color,
    this.size = 18.0,
  });

  Widget buildStar(BuildContext context, int index) {
    if (index >= rating) {
      return Icon(
        Icons.star_border_rounded,
        size: size,
        color: color ?? Theme.of(context).extension<AppColors>()!.vividBlue,
      );
    } else if (index > rating - 1 && index < rating) {
      return Icon(
        Icons.star_half_rounded,
        size: size,
        color: color ?? Theme.of(context).extension<AppColors>()!.vividBlue,
      );
    } else {
      return Icon(
        Icons.star_rounded,
        size: size,
        color: color ?? Theme.of(context).extension<AppColors>()!.vividBlue,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        starCount,
        (index) => buildStar(context, index),
      ),
    );
  }
}
