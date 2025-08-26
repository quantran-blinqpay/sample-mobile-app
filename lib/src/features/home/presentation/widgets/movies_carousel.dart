import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:designerwardrobe/src/features/home/presentation/cubit/movie_data_cubit.dart';
import 'package:designerwardrobe/src/features/home/presentation/cubit/movie_selector_cubit.dart';

import '../../domain/models/movie.dart';

class MoviesCarousel extends StatelessWidget {
  const MoviesCarousel({super.key, required this.width, required this.height});
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieSelectorCubit, MovieSelectorState>(
        buildWhen: (previous, current) => current is MovieSelectorSelected,
        builder: (context, movieSelectorState) {
          if (movieSelectorState is MovieSelectorSelected) {
            final movieDataState = context.read<MovieDataCubit>().state;
            final data = (movieDataState as MovieDataLoaded).data;
            final initialIndex = movieSelectorState.index;
            return CarouselSlider.builder(
              itemCount: data.length,
              itemBuilder: (ctx, itemIndex, pageViewIndex) {
                String imageUrl = data[itemIndex].avatarUrl ?? '';
                return _carouselItemWidget(imageUrl);
              },
              options: _getCarouselOptions(
                  context: context, initialIndex: initialIndex, data: data),
            );
          } else {
            return const SizedBox.shrink();
          }
        });
  }

  Widget _carouselItemWidget(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: CachedNetworkImage(
        width: width,
        height: height,
        fit: BoxFit.cover,
        imageUrl: imageUrl,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }

  CarouselOptions _getCarouselOptions(
      {required BuildContext context,
      required int initialIndex,
      required List<MovieModel> data}) {
    return CarouselOptions(
      enlargeCenterPage: true,
      enlargeStrategy: CenterPageEnlargeStrategy.height,
      height: height,
      initialPage: initialIndex,
      viewportFraction: 0.75,
      onPageChanged: (index, reason) {
        context.read<MovieSelectorCubit>().onSelected(index, data[index]);
      },
    );
  }
}
