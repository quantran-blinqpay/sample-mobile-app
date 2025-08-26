import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/movie_selector_cubit.dart';

class HomeBackgroundShadow extends StatelessWidget {
  const HomeBackgroundShadow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.2, 0.5, 0.7, 1],
          colors: [
            Color.fromRGBO(0, 0, 0, 0.6),
            Color.fromRGBO(0, 0, 0, 0.45),
            Color.fromRGBO(0, 0, 0, 0.3),
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}

class HomeBackgroundSwitcher extends StatelessWidget {
  const HomeBackgroundSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieSelectorCubit, MovieSelectorState>(
      builder: (context, state) {
        if (state is MovieSelectorSelected) {
          int index = state.index;
          String imageUrl = state.movie.avatarUrl ?? '';
          return AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              switchOutCurve: Curves.easeInOut,
              child: CachedNetworkImage(
                width: double.maxFinite,
                height: double.maxFinite,
                key: ValueKey(index),
                fit: BoxFit.cover,
                imageUrl: imageUrl,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
  // Widget _backgroundImage() {
  //   return Container(
  //       decoration: const BoxDecoration(
  //     image: DecorationImage(
  //       image: AssetImage("assets/images/poster_latmat6.jpg"),
  //       fit: BoxFit.cover,
  //     ),
  //   ));
  // }
