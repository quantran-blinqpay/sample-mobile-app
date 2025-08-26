import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:designerwardrobe/src/features/banner/domain/models/banner.dart';
import 'package:designerwardrobe/src/features/banner/presentation/cubit/banner_cubit.dart';

class BannerSlider extends StatefulWidget {
  const BannerSlider({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  late List<BannerModel> _bannerList;
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return _content();
  }

  Widget _content() {
    return BlocBuilder<BannerCubit, BannerState>(builder: (context, state) {
      log('BannerState = ' + state.toString());
      if (state is BannerSuccess) {
        _bannerList = state.data;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(children: [
              Positioned(child: _bannerImages()),
              Positioned.fill(
                bottom: -widget.height + 20,
                child: _bannerIndicators(),
              )
            ]),
          ],
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }

  Widget _bannerImages() {
    return Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        clipBehavior: Clip.hardEdge,
        child: CarouselSlider.builder(
          itemCount: _bannerList.length,
          itemBuilder: (ctx, itemIndex, pageViewIndex) {
            return CachedNetworkImage(
              width: widget.width,
              height: widget.height,
              fit: BoxFit.fill,
              imageUrl: _bannerList[itemIndex].url ?? '',
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            );
          },
          options: CarouselOptions(
            height: widget.height,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              setState(() {
                _index = index;
              });
            },
          ),
        ));
  }

  Widget _bannerIndicators() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _bannerList.asMap().entries.map((entry) {
          return Container(
            width: 25,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color:
                    Colors.white.withOpacity(_index == entry.key ? 0.9 : 0.4)),
          );
        }).toList());
  }
}
