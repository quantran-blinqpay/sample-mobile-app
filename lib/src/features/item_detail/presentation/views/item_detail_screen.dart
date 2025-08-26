// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:designerwardrobe/gen/assets.gen.dart';
import 'package:designerwardrobe/src/components/dialog/custom_dialog.dart';
import 'package:designerwardrobe/src/components/divider/custom_divider.dart';
import 'package:designerwardrobe/src/components/loading_indicator/app_shimmer.dart';
import 'package:designerwardrobe/src/components/scaffold/app_scaffold.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_themes.dart';
import 'package:designerwardrobe/src/core/network/response/enum/progress_status.dart';
import 'package:designerwardrobe/src/features/item_detail/presentation/cubit/item_detail_cubit.dart';
import 'package:designerwardrobe/src/features/item_detail/presentation/views/item_detail_wrapper_screen.dart';
import 'package:designerwardrobe/src/features/item_detail/presentation/widgets/carousel_image_detail_item.dart';
import 'package:designerwardrobe/src/features/item_detail/presentation/widgets/description_detail_item.dart';
import 'package:designerwardrobe/src/features/item_detail/presentation/widgets/header_detail_item.dart';
import 'package:designerwardrobe/src/features/item_detail/presentation/widgets/question_detail_item.dart';
import 'package:designerwardrobe/src/features/item_detail/presentation/widgets/seller_detail_item.dart';
import 'package:designerwardrobe/src/features/item_detail/presentation/widgets/share_report_detail_item.dart';
import 'package:designerwardrobe/src/features/item_detail/presentation/widgets/similar_detail_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:designerwardrobe/src/router/route_names.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

@RoutePage(name: itemDetailScreenName)
class ItemDetailScreen extends StatelessWidget {
  ItemDetailScreen({super.key});

  late AppColors? appColors;
  final TextEditingController questionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    appColors = Theme.of(context).extension<AppColors>();

    return BlocBuilder<ItemDetailCubit, ItemDetailState>(
      buildWhen: (previous, current) =>
          previous.fetchAllQuestionStatus != current.fetchAllQuestionStatus ||
          previous.fetchMoreitemStatus != current.fetchMoreitemStatus ||
          previous.fetchDetailStatus != current.fetchDetailStatus ||
          previous.fetchSimilarStatus != current.fetchSimilarStatus ||
          previous.dataListingDetail != current.dataListingDetail ||
          previous.refreshController != current.refreshController,
      builder: (context, state) {
        if (state.fetchDetailStatus == ProgressStatus.inProgress ||
            state.fetchAllQuestionStatus == ProgressStatus.inProgress ||
            state.fetchMoreitemStatus == ProgressStatus.inProgress ||
            state.fetchSimilarStatus == ProgressStatus.inProgress) {
          return _buildLoadingFilter(context);
        }

        if (state.fetchDetailStatus == ProgressStatus.failure) {
          WidgetsBinding.instance.addPostFrameCallback(
            (timeStamp) async {
              await CustomDialog.showConfirmDialog(
                context,
                title: 'Listing with that id not found',
                positiveText: 'OK',
                positiveColor: appColors?.vividBlue,
                onlyConfirmButton: true,
                barrierDismissible: false,
                onPositive: () async {
                  context.router.maybePop();
                },
              );
            },
          );
          return _buildLoadingFilter(context);
        }

        final data = state.dataListingDetail?.data;

        return AppScaffold(
          backgroundColor: Colors.white,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            toolbarHeight: 32,
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              padding: EdgeInsets.all(5),
              icon: SvgPicture.asset(
                Assets.svgs.icArrowBack,
                width: 18,
                height: 18,
                colorFilter: ColorFilter.mode(
                  appColors!.white,
                  BlendMode.srcIn,
                ),
              ),
              onPressed: () => context.router.maybePop(),
            ),
          ),
          body: SmartRefresher(
            controller: state.refreshController,
            enablePullUp: false,
            onRefresh: () async {
              final wrapper = context
                  .findAncestorWidgetOfExactType<ItemDetailWrapperScreen>();
              final id = wrapper?.id;

              if (id != null) {
                context.read<ItemDetailCubit>().initData(id);
              }

              state.refreshController.refreshCompleted();
            },
            child: ListView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + 32),
              children: [
                /// Carousel Image
                CarouselImageDetailItem(data: data),

                /// Header
                HeaderDetailItem(data: data),
                CustomDivider(),

                ///Description
                DescriptionDetailItem(data: data),
                CustomDivider(),

                /// Share & Report
                ShareReportDetailItem(data: data),
                CustomDivider(),

                /// SELLER
                SellerDetailItem(
                  data: data,
                  controller: questionController,
                ),
                CustomDivider(),

                /// QUESTION
                QuestionDetailItem(data: data),
                CustomDivider(),

                /// SIMILAR LISTINGS
                SimilarDetailItem(data: data),
              ],
            ),
          ),
        );
      },
    );
  }

  AppScaffold _buildLoadingFilter(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return AppScaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 32,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          padding: EdgeInsets.all(5),
          icon: SvgPicture.asset(
            Assets.svgs.icArrowBack,
            width: 18,
            height: 18,
            colorFilter: ColorFilter.mode(
              appColors!.white,
              BlendMode.srcIn,
            ),
          ),
          onPressed: () => context.router.maybePop(),
        ),
      ),
      body: SingleChildScrollView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 32),
        child: Column(
          children: [
            AspectRatio(aspectRatio: 393 / 472, child: AppShimmer()),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 21, 10, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppShimmer(
                      cornerRadius: 2, width: mq.width / 1.2, height: 18),
                  SizedBox(height: 8),
                  AppShimmer(
                      cornerRadius: 2, width: mq.width / 1.5, height: 18),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      AppShimmer(
                          cornerRadius: 2, width: mq.width / 2, height: 18),
                      Spacer(),
                      AppShimmer(
                          cornerRadius: 2, width: mq.width / 5, height: 18),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      AppShimmer(
                          cornerRadius: 2, width: mq.width / 3, height: 9),
                      Spacer(),
                      AppShimmer(
                          cornerRadius: 2, width: mq.width / 5, height: 9),
                    ],
                  ),
                  SizedBox(height: 12),
                  AppShimmer(cornerRadius: 5, width: mq.width, height: 50),
                  SizedBox(height: 8),
                  AppShimmer(cornerRadius: 5, width: mq.width, height: 50),
                  SizedBox(height: 21),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppShimmer(
                          cornerRadius: 2, width: mq.width / 3, height: 15),
                      SizedBox(width: 32),
                      AppShimmer(
                          cornerRadius: 2, width: mq.width / 3, height: 15),
                    ],
                  ),
                  SizedBox(height: 21),
                ],
              ),
            ),
            CustomDivider(),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 21, 10, 0),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppShimmer(
                      cornerRadius: 2, width: mq.width / 1.2, height: 18),
                  SizedBox(height: 8),
                  AppShimmer(
                      cornerRadius: 2, width: mq.width / 1.5, height: 18),
                  SizedBox(height: 8),
                  AppShimmer(cornerRadius: 2, width: mq.width / 2, height: 18),
                  SizedBox(height: 8),
                  AppShimmer(cornerRadius: 2, width: mq.width / 3, height: 9),
                  SizedBox(height: 21),
                ],
              ),
            ),
            CustomDivider(),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 21, 10, 0),
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppShimmer(
                      cornerRadius: 2, width: mq.width / 1.2, height: 18),
                  SizedBox(height: 8),
                  AppShimmer(
                      cornerRadius: 2, width: mq.width / 1.5, height: 18),
                  SizedBox(height: 8),
                  AppShimmer(cornerRadius: 2, width: mq.width / 2, height: 18),
                  SizedBox(height: 8),
                  AppShimmer(cornerRadius: 2, width: mq.width / 3, height: 9),
                  SizedBox(height: 21),
                ],
              ),
            ),
            CustomDivider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 21, 10, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AppShimmer(cornerRadius: 37, width: 37, height: 37),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppShimmer(
                              cornerRadius: 2, width: mq.width / 4, height: 18),
                          SizedBox(height: 4),
                          AppShimmer(
                              cornerRadius: 2, width: mq.width / 5, height: 12),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      AppShimmer(
                          cornerRadius: 2, width: mq.width / 4, height: 9),
                      Spacer(),
                      AppShimmer(
                          cornerRadius: 2, width: mq.width / 6, height: 9),
                    ],
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
            SizedBox(
              height: 80,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 10),
                itemCount: 12,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (_, __) => SizedBox(width: 10),
                itemBuilder: (BuildContext context, int index) {
                  return AppShimmer(cornerRadius: 6, width: 80, height: 80);
                },
              ),
            ),
            SizedBox(height: 21),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppShimmer(cornerRadius: 2, width: mq.width / 3, height: 15),
                SizedBox(width: 32),
                AppShimmer(cornerRadius: 2, width: mq.width / 3, height: 15),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
