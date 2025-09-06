import 'package:auto_route/auto_route.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_colors.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_images.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_styles.dart';
import 'package:designerwardrobe/src/core/network/response/enum/progress_status.dart';
import 'package:designerwardrobe/src/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:designerwardrobe/src/features/home/data/remote/dtos/product_tile.dart';
import 'package:designerwardrobe/src/features/home/data/remote/dtos/site_setting/category_entity.dart';
import 'package:designerwardrobe/src/features/home/data/remote/dtos/site_setting/site_homepage_slides.dart';
import 'package:designerwardrobe/src/features/home/data/remote/dtos/watchlist/watchlist_data.dart';
import 'package:designerwardrobe/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:designerwardrobe/src/features/home/presentation/views/home/widgets/home/banners_widget.dart';
import 'package:designerwardrobe/src/features/home/presentation/views/home/widgets/home/filter_tabs_widget.dart';
import 'package:designerwardrobe/src/features/home/presentation/views/home/widgets/home/recommended_for_you_widget.dart';
import 'package:designerwardrobe/src/features/home/presentation/views/home/widgets/home/saved_brands_widget.dart';
import 'package:designerwardrobe/src/features/home/presentation/views/home/widgets/home/watchlist_section_widget.dart';
import 'package:designerwardrobe/src/features/home/presentation/views/home/widgets/loadings/home_empty_view.dart';
import 'package:designerwardrobe/src/features/home/presentation/views/home/widgets/loadings/home_loading_widget.dart';
import 'package:designerwardrobe/src/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart' as refresh;

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBodyWidget(context),
    );
  }

  Widget _buildBodyWidget(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      if (state.fetchRecommendedItemsStatus == ProgressStatus.inProgress ||
          state.fetchSiteSettingStatus == ProgressStatus.inProgress ||
          state.fetchWatchlistStatus == ProgressStatus.inProgress) {
        return const HomeLoadingWidget();
      } else if (state.recommendedItems?.isNotEmpty ?? false) {
        return refresh.SmartRefresher(
          // footer: CustomFooterWidget(),
          controller: state.refreshController,
          onLoading: () async {
            await context.read<HomeCubit>().loadNextItems();
            state.refreshController.loadComplete();
          },
          enablePullUp: state.canLoadMoreItems,
          enablePullDown: false,
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).viewPadding.top + 15),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return _buildSearchInputField(context);
                    },
                    // Or, uncomment the following line:
                    childCount: 1,
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(top: 4),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return _buildFilterTabs(
                          context, state.siteSetting?.home?.category ?? []);
                    },
                    // Or, uncomment the following line:
                    childCount: 1,
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(top: 17),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return _buildBanners(
                          context, state.siteSetting?.siteHomepageSlides);
                    },
                    // Or, uncomment the following line:
                    childCount: 1,
                  ),
                ),
              ),
              // SliverList(
              //   delegate: SliverChildBuilderDelegate(
              //         (BuildContext context, int index) {
              //       return _buildWatchList(context, state.watchlistItem?.data ?? []);
              //     },
              //     // Or, uncomment the following line:
              //     childCount: 1,
              //   ),
              // ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return _buildSavedBrandTabs(context);
                  },
                  // Or, uncomment the following line:
                  childCount: 1,
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(top: 24),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.router.push(OnboardingOneScreenRoute());
                              },
                              child: Text(
                                "Recommended for you",
                                style: TextStyle(
                                  fontFamily: 'FeatureDeckCondensed',
                                  fontSize: 20,
                                  color: appColors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Text(
                              "From your favourite brands and sellers",
                              style: AppStyles.of(context).copyWith(
                                fontSize: 11,
                                color: appColors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    // Or, uncomment the following line:
                    childCount: 1,
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(top: 10, left: 15, right: 15),
                sliver: _buildRecommendBrands(
                    context, state.recommendedItems ?? []),
              ),
            ],
          ),
        );
      } else {
        return CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return HomeEmptyView();
                },
                // Or, uncomment the following line:
                childCount: 1,
              ),
            )
          ],
        );
      }
    });
  }

  Widget _buildSearchInputField(BuildContext context) {
    final appColor = Theme.of(context).extension<AppColors>();
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          // Search field
          Expanded(
            child: SizedBox(
              height: 31,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: appColor?.greyStone,
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: [
                    const SizedBox(width: 7),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                      child: SvgPicture.asset(icSearch, width: 24, height: 24),
                    ),
                    const SizedBox(width: 7),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        onTap: () {
                          context.router.push(FilterWrapperScreenRoute());
                        },
                        readOnly: true,
                        decoration: InputDecoration(
                          // fillColor: appColor?.greyStone,
                          filled: true,
                          fillColor:
                              Colors.transparent, // transparent background
                          border: InputBorder.none,
                          hintText: "Search for anything",
                          hintStyle: AppStyles.of(context).copyWith(
                              fontSize: 13,
                              color: appColor?.coalBlack,
                              fontWeight: FontWeight.w300),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Message icon
          GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(icMail, width: 24, height: 24),
          ),
          const SizedBox(width: 7),
          // Notification icon
          GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(icNotification, width: 24, height: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs(BuildContext context, List<CategoryEntity> items) {
    return FilterTabsWidget(
      categories: items,
    );
  }

  Widget _buildBanners(BuildContext context, SiteHomepageSlides? items) {
    return BannersWidget(items: items);
  }

  Widget _buildWatchList(BuildContext context, List<WatchlistData> items) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return state.isSignedIn ? Padding(
          padding: const EdgeInsets.only(top: 24),
          child: WatchlistSectionWidget(items: items),
        ): SizedBox.shrink();
      },
    );
  }

  Widget _buildSavedBrandTabs(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return state.isSignedIn ? Padding(
          padding: const EdgeInsets.only(top: 24),
          child: SavedBrandsWidget(),
        ) : SizedBox.shrink();
      },
    );
  }

  Widget _buildRecommendBrands(BuildContext context, List<ProductTile> items) {
    return RecommendedForYouWidget(items: items);
  }

  Widget _buildDivider({required BuildContext context, required double height}) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return SliverPadding(
        padding: EdgeInsets.only(top: 0),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return ColoredBox(
                color: appColors.gainsboro,
                child: SizedBox(height: height),
              );
            },
            // Or, uncomment the following line:
            childCount: 1,
          ),
        )
    );
  }
}
