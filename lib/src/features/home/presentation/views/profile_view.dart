// ignore_for_file: must_be_immutable

import 'package:qwid/src/configs/app_themes/app_colors.dart';
import 'package:qwid/src/configs/app_themes/app_styles.dart';
import 'package:qwid/src/features/home/data/remote/dtos/product_tile.dart';
import 'package:qwid/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:qwid/src/features/home/presentation/views/home/widgets/home/recommended_for_you_widget.dart';
import 'package:qwid/src/features/home/presentation/views/home/widgets/loadings/home_loading_widget.dart';
import 'package:qwid/src/features/home/presentation/views/home/widgets/profile/auth_banner_widget.dart';
import 'package:qwid/src/features/home/presentation/views/home/widgets/profile/buying_widget.dart';
import 'package:qwid/src/features/home/presentation/views/home/widgets/profile/logout_widget.dart';
import 'package:qwid/src/features/home/presentation/views/home/widgets/profile/notification_center_widget.dart';
import 'package:qwid/src/features/home/presentation/views/home/widgets/profile/referral_banner_widget.dart';
import 'package:qwid/src/features/home/presentation/views/home/widgets/profile/selling_widget.dart';
import 'package:qwid/src/features/home/presentation/views/home/widgets/profile/settings_widget.dart';
import 'package:qwid/src/components/scaffold/app_scaffold.dart';
import 'package:qwid/src/core/network/response/enum/progress_status.dart';
import 'package:qwid/src/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart' as refresh;
import 'home/widgets/loadings/home_empty_view.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key, this.appColors});
  late AppColors? appColors;

  @override
  Widget build(BuildContext context) {
    appColors = Theme.of(context).extension<AppColors>();

    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (prev, current) =>
          prev.signOutStatus != current.signOutStatus,
      listener: (context, state) {
        if (state.signOutStatus == ProgressStatus.inProgress) {
          print('quanth: signOutStatus == ProgressStatus.inProgress');
        } else if (state.signOutStatus == ProgressStatus.failure) {
          print('quanth: signOutStatus == ProgressStatus.failure');
        } else if (state.signOutStatus == ProgressStatus.success) {
          print('quanth: signOutStatus == ProgressStatus.success');
        }
      },
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          debugPrint(state.token);
          return AppScaffold(
            isBackBtnVisible: false,
            backgroundColor: appColors!.white,
            isLoading: state.signOutStatus == ProgressStatus.inProgress,
            appBar: AppBar(
              toolbarHeight: 48,
              backgroundColor: Colors.transparent,
              title: Center(
                child: Text(
                  'MY ACCOUNT',
                  style: AppStyles.of(context).copyWith(
                    color: Colors.black,
                    fontSize: 18,
                    height: 13 / 14,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            body: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
              if (state.fetchMoreWithLovesStatus == ProgressStatus.inProgress) {
                return const HomeLoadingWidget();
              } else if (state.moreWithLoves?.isNotEmpty ?? false) {
                return refresh.SmartRefresher(
                  // footer: CustomFooterWidget(),
                  controller:
                      refresh.RefreshController() /*state.refreshController*/,
                  onLoading: () async {
                    // await context.read<HomeCubit>().loadNextLoveItems();
                    state.refreshLoveController.loadComplete();
                  },
                  enablePullUp: false /*state.canLoadMoreLoveItems*/,
                  enablePullDown: false,
                  child: CustomScrollView(
                    slivers: [
                      _buildAuthBanner(context),
                      _buildReferralBanner(context),
                      _buildDivider(context: context, height: 16),
                      SliverPadding(
                        padding: EdgeInsets.only(top: 0),
                        sliver: _buildSettingWidget(context),
                      ),
                      _buildDivider(context: context, height: 16),
                      SliverPadding(
                        padding: EdgeInsets.only(top: 0),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return _buildNotificationCentre(context);
                            },
                            // Or, uncomment the following line:
                            childCount: 1,
                          ),
                        ),
                      ),
                      _buildDivider(context: context, height: 16),
                      SliverPadding(
                        padding: EdgeInsets.only(top: 0),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return _buildBuyingWidget(context);
                            },
                            // Or, uncomment the following line:
                            childCount: 1,
                          ),
                        ),
                      ),
                      _buildDivider(context: context, height: 16),
                      SliverPadding(
                        padding: EdgeInsets.only(top: 0),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return _buildSellingWidget(context);
                            },
                            // Or, uncomment the following line:
                            childCount: 1,
                          ),
                        ),
                      ),
                      _buildDivider(context: context, height: 16),
                      SliverPadding(
                        padding: EdgeInsets.only(top: 0),
                        sliver: _buildLogoutWidget(context),
                      ),
                      _buildDivider(context: context, height: 16),
                      SliverPadding(
                        padding: EdgeInsets.only(top: 16, left: 15, right: 15),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return Center(
                                child: Text(
                                  'More to Love',
                                  style: AppStyles.of(context).copyWith(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            },
                            // Or, uncomment the following line:
                            childCount: 1,
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: EdgeInsets.only(top: 16, left: 15, right: 15),
                        sliver: _buildMoreToLoveWidget(
                            context, state.moreWithLoves ?? []),
                      )
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
            }),
          );
        },
      ),
    );
  }

  Widget _buildSettingWidget(BuildContext context) {
    return SettingsWidget();
  }

  Widget _buildNotificationCentre(BuildContext context) {
    return NotificationCenterWidget();
  }

  Widget _buildBuyingWidget(BuildContext context) {
    return BuyingWidget();
  }

  Widget _buildSellingWidget(BuildContext context) {
    return SellingWidget();
  }

  Widget _buildLogoutWidget(BuildContext context) {
    return LogoutWidget();
  }

  Widget _buildMoreToLoveWidget(BuildContext context, List<ProductTile> items) {
    return RecommendedForYouWidget(items: items);
  }

  Widget _buildAuthBanner(BuildContext context) {
    return AuthBannerWidget();
  }

  Widget _buildReferralBanner(BuildContext context) {
    return ReferralBannerWidget();
  }

  Widget _buildDivider(
      {required BuildContext context, required double height}) {
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
        ));
  }
}
