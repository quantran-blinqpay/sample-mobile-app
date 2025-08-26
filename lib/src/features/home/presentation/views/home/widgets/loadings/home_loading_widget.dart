import 'package:designerwardrobe/src/components/loading_indicator/app_shimmer.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_colors.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_images.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_styles.dart';
import 'package:designerwardrobe/src/features/home/presentation/views/home/widgets/home/filter_item_widget.dart';
import 'package:designerwardrobe/src/features/home/presentation/views/home/widgets/home/saved_brands_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeLoadingWidget extends StatelessWidget {
  const HomeLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top + 15),
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
                return _buildFilterTabs(context);
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
                return _buildBanners(context);
              },
              // Or, uncomment the following line:
              childCount: 1,
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.only(top: 24),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return _buildWatchList(context);
              },
              // Or, uncomment the following line:
              childCount: 1,
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.only(top: 10),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return _buildSavedBrandTabs(context);
              },
              // Or, uncomment the following line:
              childCount: 1,
            ),
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
                      Text(
                        "Recommended for you",
                        style: TextStyle(
                          fontFamily: 'FeatureDeckCondensed',
                          fontSize: 20,
                          color: appColors.black,
                          fontWeight: FontWeight.w400,
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
          sliver: _buildRecommendBrands(context),
        ),
      ],
    );
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
                      child: TextFormField(
                        decoration: InputDecoration(
                          // fillColor: appColor?.greyStone,
                          filled: true,
                          fillColor: Colors.transparent, // transparent background
                          border: InputBorder.none,
                          hintText: "Search for anything",
                          hintStyle: AppStyles.of(context).copyWith(
                              fontSize: 13, color: appColor?.coalBlack, fontWeight: FontWeight.w300),
                          contentPadding: const EdgeInsets.symmetric(vertical: 12),
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

  Widget _buildFilterTabs(BuildContext context) {
    final List<String> categories = [
      "Shop All",
      "List & Win",
      "Trending Brands",
      "Deals",
      "New Arrivals",
    ];
    return SizedBox(
      height: 32,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return FilterItemWidget(categories[index]);
        },
      ),
    );
  }

  Widget _buildBanners(BuildContext context) {
    return SizedBox(
      // width: MediaQuery.of(context).size.width * 333 / 393,
      height: MediaQuery.of(context).size.width * 135 / 393,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        itemCount: 2,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return AspectRatio(
            aspectRatio: 333 / 135,
            child: AppShimmer(),
          );
        },
      ),
    );
  }

  Widget _buildSavedBrandTabs(BuildContext context) {
    return SavedBrandsWidget();
  }

  Widget _buildWatchList(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Column(
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Watchlist",
                style: TextStyle(
                  fontFamily: 'FeatureDeckCondensed',
                  fontSize: 20,
                  color: appColors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "See all",
                style: AppStyles.of(context).copyWith(
                  fontSize: 11,
                  color: appColors.cobatBlue,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Horizontal list
        SizedBox(
          height: 231,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 5,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return _buildBrandItemWidget(context);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBrandItemWidget(BuildContext context){
    final appColors = Theme.of(context).extension<AppColors>()!;
    return SizedBox(
      width: 160,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          AspectRatio(
            aspectRatio: 136 / 148,
            child: AppShimmer(),
          ),
          const SizedBox(height: 8),

          // Title & price
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 26 + 4),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Brand',
                        style: AppStyles.of(context).copyWith(
                          color: appColors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Text(
                              "NZD 0.00",
                              style: AppStyles.of(context).copyWith(
                                color: appColors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned.fill(
                    child:
                    Align(
                      alignment: Alignment.bottomRight,
                      child: SvgPicture.asset(
                        icLiked,
                        width: 26,
                        height: 26,
                      ),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendBrands(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return _buildBrandItemWidget(context);
        },
        childCount: 4,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // number of columns
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 135 / 179
      ),
    );
  }

}