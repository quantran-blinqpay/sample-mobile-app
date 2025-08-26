import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:designerwardrobe/gen/assets.gen.dart';
import 'package:designerwardrobe/src/components/image/app_image.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_themes.dart';
import 'package:designerwardrobe/src/features/item_detail/data/remote/dtos/listing_detail_response.dart';
import 'package:designerwardrobe/src/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselImageDetailItem extends StatefulWidget {
  const CarouselImageDetailItem({super.key, required this.data});

  final ListingDetailResponseData? data;

  @override
  State<CarouselImageDetailItem> createState() =>
      _CarouselImageDetailItemState();
}

class _CarouselImageDetailItemState extends State<CarouselImageDetailItem> {
  late AppColors? appColors;
  int activeIndex = 0;
  final controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    appColors = Theme.of(context).extension<AppColors>();
    return Stack(
      children: [
        CarouselSlider.builder(
          carouselController: controller,
          itemCount: widget.data?.getCarouselListImage().length ?? 0,
          options: CarouselOptions(
            aspectRatio: 393 / 472,
            viewportFraction: 1.0,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              setState(() {
                activeIndex = index;
              });
            },
          ),
          itemBuilder: (_, index, __) {
            final item = widget.data?.getCarouselListImage()[index];
            return GestureDetector(
              onTap: () {
                context.router.push(
                  PreviewImageScreenRoute(
                    imageUrls: widget.data
                            ?.getCarouselListImage()
                            .map((e) => e.url ?? '')
                            .toList() ??
                        <String>[],
                    initialIndex: index,
                    heroTag: 'previewItemDetail$index',
                  ),
                );
              },
              child: Hero(
                tag: 'previewItemDetail$index',
                child: AppImage(
                  width: double.infinity,
                  imageUrl: item?.url ?? '',
                ),
              ),
            );
          },
        ),
        Positioned(
          right: 14,
          bottom: 12,
          child: Container(
            padding: EdgeInsets.fromLTRB(16, 9, 16, 7),
            decoration: BoxDecoration(
              color: appColors!.white.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${widget.data?.numberOfWatchers ?? 0}',
                  style: AppStyles.of(context).copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: appColors!.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(width: 12),
                SvgPicture.asset(
                  widget.data?.isInWatchlist ?? false
                      ? Assets.svgs.icHeartFilled
                      : Assets.svgs.icHeart,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 20,
          child: Center(
            child: AnimatedSmoothIndicator(
              activeIndex: activeIndex,
              count: widget.data?.getCarouselListImage().length ?? 0,
              effect: ScaleEffect(
                dotHeight: 7,
                dotWidth: 7,
                activeDotColor: appColors!.white,
                dotColor: appColors!.white.withValues(alpha: 0.5),
              ),
              onDotClicked: (index) {
                controller.animateToPage(index);
              },
            ),
          ),
        ),
      ],
    );
  }
}
