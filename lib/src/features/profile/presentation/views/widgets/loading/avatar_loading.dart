import 'package:designerwardrobe/src/components/loading_indicator/app_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shimmer/shimmer.dart';

class AvatarLoading extends StatelessWidget {
  const AvatarLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
            width: 40,
            height: 40,
            child: AppShimmer(
              cornerRadius: 20,
            )
        ),
        // SvgPicture.asset(icProfileFilled, width: 40, height: 40, color: Colors.black),
        SizedBox(width: 8),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppShimmer(
              width: 80,
              height: 14,
              cornerRadius: 5,
            ),
            SizedBox(height: 5),
            IgnorePointer(
              ignoring: true,
              child: Shimmer.fromColors(
                baseColor: Colors.grey[350]!,
                highlightColor: Colors.grey[100]!,
                child: RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 15,
                  // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
                  onRatingUpdate: (rating) {},
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

}