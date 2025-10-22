import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:qwid/src/router/route_names.dart';

class MediaPickerBottomSheet extends StatelessWidget {
  const MediaPickerBottomSheet({
    super.key
  });


  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 4, 4, 4),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: Colors.white,
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 8),
            Container(
              width: 40,
              height: 4,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Color(0xffCCCCCC)
              ),
            ),
            SizedBox(height: 32),
            _stepTile(
              onTap: () {
                context.router.pop("gallery");
              },
              icon: icQwidGallery,
              subTitle: "Pick a file directly from your phone’s gallery.",
              title: "From Gallery",
            ),
            SizedBox(height: 16),
            _stepTile(
              onTap: () {
                context.router.pop("file");
              },
              icon: icQwidFolder,
              subTitle: "Browse your files to upload a document.",
              title: "From Files",
            ),
          ],
        ),
      ),
    );
  }

  Widget _stepTile({
    required String icon,
    required String title,
    required String subTitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: () => onTap.call(),
      child: Container(
        color: Colors.transparent,
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.only(right: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: SvgPicture.asset(icon, width: 24, height: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Creato Display',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff0A0A0C),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subTitle,
                    style: const TextStyle(
                      fontFamily: 'Creato Display',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff92939E),
                    ),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ),
            SvgPicture.asset(icQwidArrowRight, width: 24, height: 24),
          ],
        ),
      ),
    );
  }

}