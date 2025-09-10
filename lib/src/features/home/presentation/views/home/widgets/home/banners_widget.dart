import 'package:cached_network_image/cached_network_image.dart';
import 'package:qwid/src/features/home/data/remote/dtos/site_setting/carousel.dart';
import 'package:qwid/src/features/home/data/remote/dtos/site_setting/site_homepage_slides.dart';
import 'package:flutter/material.dart';

class BannersWidget extends StatelessWidget {
  final SiteHomepageSlides? items;

  const BannersWidget({super.key, this.items});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: MediaQuery.of(context).size.width * 333 / 393,
      height: MediaQuery.of(context).size.width * 135 / 393,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        itemCount: 3,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return AspectRatio(
            aspectRatio: 333 / 135,
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: index == 2
                  ? (items?.image4?.imageUrlMobile ?? '')
                  : index == 1
                  ? (items?.image2?.imageUrlMobile ?? '')
                  : (items?.image1?.imageUrlMobile ?? ''),
              placeholder: (context, url) => ColoredBox(color: Colors.grey.shade200),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          );
        },
      ),
    );
  }
}