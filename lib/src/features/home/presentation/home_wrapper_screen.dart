import 'package:auto_route/auto_route.dart';
import 'package:designerwardrobe/src/core/di/injections.dart';
import 'package:designerwardrobe/src/core/network/response/enum/progress_status.dart';
import 'package:designerwardrobe/src/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:designerwardrobe/src/features/home/presentation/cubit/main_tab_cubit.dart';
import 'package:designerwardrobe/src/features/home/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:designerwardrobe/src/features/home/domain/models/movie.dart';
import 'package:designerwardrobe/src/features/home/presentation/cubit/movie_data_cubit.dart';
import 'package:designerwardrobe/src/features/home/presentation/cubit/movie_selector_cubit.dart';
import 'package:designerwardrobe/src/router/route_names.dart';

import 'cubit/home_cubit.dart';

final List<String> moviesList = [
  'https://www.cgv.vn/media/catalog/product/cache/1/image/c5f0a1eff4c394a251036189ccddaacd/7/0/700x1000_2_.jpg',
  'https://www.cgv.vn/media/catalog/product/cache/1/image/c5f0a1eff4c394a251036189ccddaacd/p/o/poster_gttdy_1.jpg',
  'https://www.cgv.vn/media/catalog/product/cache/1/image/c5f0a1eff4c394a251036189ccddaacd/l/m/lm6_2x3_layout.jpg',
  'https://www.cgv.vn/media/catalog/product/cache/1/image/c5f0a1eff4c394a251036189ccddaacd/7/0/700x1000-tid-noi.jpg',
  'https://www.cgv.vn/media/catalog/product/cache/1/image/c5f0a1eff4c394a251036189ccddaacd/g/h/ghost-station_main_fin_viethoa.jpg',
  'https://www.cgv.vn/media/catalog/product/cache/1/image/c5f0a1eff4c394a251036189ccddaacd/7/0/700x1000_4_.jpg'
];

@RoutePage(name: homeWrapperScreenName)
class HomeWrapperScreen extends StatelessWidget {
  const HomeWrapperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<MovieDataCubit>(
              create: (context) => di<MovieDataCubit>()),
          BlocProvider(
            create: (context) => di<MovieSelectorCubit>(),
          ),
          BlocProvider(
            create: (context) => di<HomeCubit>()..loadRecommendedItems()..loadAllSiteSettings()..loadLoveItems(),
          ),
          BlocProvider(
            create: (context) => di<MainTabCubit>(),
          ),
        ],
        child: MultiBlocListener(listeners: [
          BlocListener<MovieDataCubit, MovieDataState>(
              listener: (context, state) {
                if (state is MovieDataLoaded && state.data.isNotEmpty) {
                  int initialIndex = (state.data.length / 2).round();
                  MovieModel data = state.data[initialIndex];
                  context.read<MovieSelectorCubit>().onSelected(initialIndex, data);
                } else if (state is MovieDataFailure) {
                  context.read<MovieSelectorCubit>().unSelected();
                }
              }),
          BlocListener<AuthCubit, AuthState>(listener: (context, state) {
            if (state.signInStatus == ProgressStatus.success ||
                state.forgotPasswordStatus == ProgressStatus.success) {
              context.read<HomeCubit>().loadWatchList();
            }
          })
        ], child: HomeScreen()));
  }
}
