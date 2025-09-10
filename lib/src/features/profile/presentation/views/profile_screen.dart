import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:qwid/src/components/loading_indicator/app_shimmer.dart';
import 'package:qwid/src/components/scaffold/app_scaffold.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:qwid/src/configs/app_themes/app_styles.dart';
import 'package:qwid/src/core/network/response/enum/progress_status.dart';
import 'package:qwid/src/features/profile/presentation/views/widgets/loading/avatar_loading.dart';
import 'package:qwid/src/features/profile/presentation/views/widgets/profile/feedback_view.dart';
import 'package:qwid/src/features/profile/presentation/views/widgets/profile/followers_view.dart';
import 'package:qwid/src/features/profile/presentation/views/widgets/profile/following_view.dart';
import 'package:qwid/src/features/profile/presentation/views/widgets/profile/for_sale_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qwid/src/configs/app_themes/app_colors.dart';
import 'package:qwid/src/core/di/injections.dart';
import 'package:qwid/src/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:qwid/src/router/route_names.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import '../../../authentication/presentation/cubit/auth_cubit.dart';

@RoutePage(name: profileScreenName)
class ProfileScreen extends StatefulWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<ProfileCubit>(
          create: ((context) => di<ProfileCubit>()..getMyProfile())),
      BlocProvider<AuthCubit>(create: ((context) => di<AuthCubit>())),
    ], child: this);
  }

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final tabs = ['For Sale', 'Following', 'Followers', 'Feedback'];
  double _rating = 0;

  @override
  void initState() {
    _tabController = TabController(length: tabs.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBodyWidget(context);
  }

  Widget _buildNameAndAvatar(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (prev, current) =>
        prev.fetchUserProfileStatus != current.fetchUserProfileStatus,
      builder: (context, state) {
        if(state.fetchUserProfileStatus == ProgressStatus.inProgress) {
          return const AvatarLoading();
        }
        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: CachedNetworkImage(
                imageUrl: state.profile?.profilePicture ?? '',
                errorWidget: (
                    BuildContext context,
                    String url,
                    Object error,
                ) => SvgPicture.asset(
                    icProfileFilled,
                    width: 40,
                    height: 40,
                    color: Colors.black,
                ),
              )
            ),
            // SvgPicture.asset(icProfileFilled, width: 40, height: 40, color: Colors.black),
            SizedBox(width: 8),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '@${state.profile?.username}',
                  style: AppStyles.of(context).copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: appColors.black,
                  ),
                ),
                SizedBox(height: 5),
                IgnorePointer(
                  ignoring: true,
                  child: RatingBar.builder(
                    initialRating: _rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 15,
                    // itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
                    onRatingUpdate: (rating) {
                      setState(() {
                        _rating = rating;
                      });
                    },
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  Widget _buildBodyWidget(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return AppScaffold(
      appBar: AppBar(
        toolbarHeight: 48,
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            'MY WARDROBE ON DW',
            style: AppStyles.of(context).copyWith(
              color: Colors.black,
              fontSize: 18,
              height: 13 / 14,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: SvgPicture.asset(
              icShare,
              width: 30,
              height: 30,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
          _buildNameAndAvatar(context),
          const SizedBox(height: 30),
          Text(
            'Add/Edit Photo',
            style: AppStyles.of(context).copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: appColors.black,
              decoration: TextDecoration.underline,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            'Based in New Zealand',
            style: AppStyles.of(context).copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: appColors.black,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(child: _buildPageView(context))
        ],
      ),
    );
  }

  Widget _buildPageView(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16),
        _buildTabBar(),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              ForSaleView(),
              FollowingView(),
              FollowersView(),
              FeedbackView()
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Stack(
      children: [
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: appColors.gainsboro.withAlpha(90),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  Expanded(child: SizedBox(width: double.infinity, height: 10)),
                  ColoredBox(color: appColors.mediumGray, child: SizedBox(width: 0.25, height: 20)),
                  Expanded(child: SizedBox(width: double.infinity, height: 10)),
                  ColoredBox(color: appColors.mediumGray, child: SizedBox(width: 0.25, height: 20)),
                  Expanded(child: SizedBox(width: double.infinity, height: 10)),
                  ColoredBox(color: appColors.mediumGray, child: SizedBox(width: 0.25, height: 20)),
                  Expanded(child: SizedBox(width: double.infinity, height: 10)),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 30,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: TabBar(
              dividerColor: Colors.transparent,
              controller: _tabController,
              labelColor: Colors.black,
              // unselectedLabelColor: Colors.grey[500],
              indicator: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: AppColorss.shadowColor,
                    blurRadius: 5,
                    offset: Offset(0, 0),
                  )
                ],
              ),
              indicatorPadding: EdgeInsets.all(2),
              indicatorSize: TabBarIndicatorSize.tab,
              labelStyle: AppStyles.of(context).copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 11,
              ),
              unselectedLabelStyle: AppStyles.of(context).copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 11,
              ),
              tabs: tabs.map((tab) => Tab(text: tab, height: 30))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  void _showMessage({required String message, required BuildContext context}) {
    var snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
