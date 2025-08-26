// Fullscreen Page
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:designerwardrobe/gen/assets.gen.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_themes.dart';
import 'package:designerwardrobe/src/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

@RoutePage(name: previewImageScreenName)
class PreviewImageScreen extends StatefulWidget {
  final List<String> imageUrls;
  final int initialIndex;
  final String heroTag;
  final bool usingPath;

  const PreviewImageScreen({
    super.key,
    required this.imageUrls,
    required this.initialIndex,
    required this.heroTag,
    this.usingPath = false,
  });

  @override
  State<PreviewImageScreen> createState() => _PreviewImageScreenState();
}

class _PreviewImageScreenState extends State<PreviewImageScreen> {
  late int index = widget.initialIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 32,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          padding: EdgeInsets.all(5),
          icon: SvgPicture.asset(
            Assets.svgs.icArrowBack,
            width: 18,
            height: 18,
            colorFilter: ColorFilter.mode(
              Theme.of(context).extension<AppColors>()!.white,
              BlendMode.srcIn,
            ),
          ),
          onPressed: () => context.router.maybePop(),
        ),
      ),
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            pageController: PageController(initialPage: widget.initialIndex),
            scrollPhysics: const BouncingScrollPhysics(),
            builder: (BuildContext context, int index) {
              if (widget.usingPath) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: FileImage(File(widget.imageUrls[index])),
                  heroAttributes: PhotoViewHeroAttributes(tag: widget.heroTag),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.contained * 4,
                );
              }

              return PhotoViewGalleryPageOptions(
                imageProvider:
                    CachedNetworkImageProvider(widget.imageUrls[index]),
                heroAttributes: PhotoViewHeroAttributes(tag: widget.heroTag),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.contained * 4,
              );
            },
            itemCount: widget.imageUrls.length,
            onPageChanged: (i) => setState(() => index = i),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: MediaQuery.of(context).padding.bottom + 16,
            child: Text(
              '${index + 1} of ${widget.imageUrls.length}',
              style: AppStyles.of(context).copyWith(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Theme.of(context).extension<AppColors>()!.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
