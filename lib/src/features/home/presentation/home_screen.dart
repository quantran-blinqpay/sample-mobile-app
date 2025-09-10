import 'package:auto_route/auto_route.dart';
import 'package:qwid/src/components/dialog/signin_dialog.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:qwid/src/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:qwid/src/features/home/presentation/cubit/main_tab_cubit.dart';
import 'package:qwid/src/features/home/presentation/views/favourites_view.dart';
import 'package:qwid/src/features/home/presentation/views/home/home_view.dart';
import 'package:qwid/src/features/home/presentation/views/list_view.dart';
import 'package:qwid/src/features/home/presentation/views/profile_view.dart';
import 'package:qwid/src/features/home/presentation/views/search_view.dart';
import 'package:qwid/src/features/home/presentation/widgets/custom_nav_bar.dart';
import 'package:qwid/src/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qwid/src/router/route_names.dart';

final List<String> moviesList = [
  'https://www.cgv.vn/media/catalog/product/cache/1/image/c5f0a1eff4c394a251036189ccddaacd/7/0/700x1000_2_.jpg',
  'https://www.cgv.vn/media/catalog/product/cache/1/image/c5f0a1eff4c394a251036189ccddaacd/p/o/poster_gttdy_1.jpg',
  'https://www.cgv.vn/media/catalog/product/cache/1/image/c5f0a1eff4c394a251036189ccddaacd/l/m/lm6_2x3_layout.jpg',
  'https://www.cgv.vn/media/catalog/product/cache/1/image/c5f0a1eff4c394a251036189ccddaacd/7/0/700x1000-tid-noi.jpg',
  'https://www.cgv.vn/media/catalog/product/cache/1/image/c5f0a1eff4c394a251036189ccddaacd/g/h/ghost-station_main_fin_viethoa.jpg',
  'https://www.cgv.vn/media/catalog/product/cache/1/image/c5f0a1eff4c394a251036189ccddaacd/7/0/700x1000_4_.jpg'
];

@RoutePage(name: homeScreenName)
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // disable swipe
        children: [
          HomeView(),
          SearchView(),
          ListItemsView(),
          FavouritesView(),
          ProfileView(),
        ],
      ),
      bottomNavigationBar: BlocBuilder<MainTabCubit, MainTabState>(
        builder: (context, state) {
          return CustomBottomNavBar(
            currentIndex: state.currentIndex,
            onTap: (int index) async {
              if (index == 2) {
                if (context.read<AuthCubit>().state.isSignedIn) {
                  context.router.push(CreateListingWrapperScreenRoute());
                } else {
                  await showDialog(
                    context: context,
                    builder: (context) => SigninDialog(
                      title: 'Join DW',
                      subTitle:
                          'Buy & sell pre-loved designer fashion! Join us now.',
                    ),
                  );
                }
              } else {
                context.read<MainTabCubit>().changeTab(index);
                _pageController.jumpToPage(index);
              }
            },
            items: [
              NavItem(
                index: 0,
                icon: icHome,
                iconSelected: icHomeSelected,
                label: 'Home',
              ),
              NavItem(
                index: 1,
                icon: icSearch,
                iconSelected: icSearchSelected,
                label: 'Search',
              ),
              NavItem(
                index: 2,
                icon: icList,
                iconSelected: icListSelected,
                label: 'List',
              ),
              NavItem(
                index: 3,
                icon: icFavorites,
                iconSelected: icFavoritesSelected,
                label: 'Favourites',
              ),
              NavItem(
                index: 4,
                icon: icProfile,
                iconSelected: icProfileSelected,
                label: 'MY ACCOUNT',
              ),
            ],
          );
        },
      ),
    );
  }
}
