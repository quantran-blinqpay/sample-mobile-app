// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:designerwardrobe/src/components/button/app_button.dart';
import 'package:designerwardrobe/src/components/image/app_image.dart';
import 'package:designerwardrobe/src/components/scaffold/app_scaffold.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_themes.dart';
import 'package:designerwardrobe/src/core/network/response/enum/progress_status.dart';
import 'package:designerwardrobe/src/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:designerwardrobe/src/core/di/injections.dart';
import 'package:designerwardrobe/src/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:designerwardrobe/src/router/route_names.dart';
import '../../../authentication/presentation/cubit/auth_cubit.dart';

@RoutePage(name: draftsScreenName)
class DraftsScreen extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<ProfileCubit>(
          create: ((context) => di<ProfileCubit>()..getDrafts())),
      BlocProvider<AuthCubit>(create: ((context) => di<AuthCubit>())),
    ], child: this);
  }

  DraftsScreen({super.key});
  late AppColors appColors;

  @override
  Widget build(BuildContext context) {
    appColors = Theme.of(context).extension<AppColors>()!;
    return _buildBodyWidget(context);
  }

  Widget _buildBodyWidget(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return AppScaffold(
          backgroundColor: appColors.lavender,
          isLoading: state.fetchDraftsStatus == ProgressStatus.inProgress ||
              state.fetchDetailStatus == ProgressStatus.inProgress,
          appBar: AppBar(
            toolbarHeight: 48,
            centerTitle: true,
            surfaceTintColor: Colors.transparent,
            backgroundColor: appColors.white,
            title: Text(
              'DRAFTS',
              style: AppStyles.of(context).copyWith(
                color: Colors.black,
                fontSize: 18,
                height: 13 / 14,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          body: Builder(
            builder: (context) {
              if (state.fetchDraftsStatus == ProgressStatus.inProgress) {
                return SizedBox();
              }

              return ListView.separated(
                padding: EdgeInsets.fromLTRB(
                    0, 16, 0, MediaQuery.of(context).padding.bottom),
                itemCount: state.dataDrafts?.length ?? 0,
                separatorBuilder: (_, __) => SizedBox(height: 16),
                itemBuilder: (BuildContext context, int index) {
                  final item = state.dataDrafts![index];
                  return ElevatedAppButton(
                    onPressed: () async {
                      final res = await context
                          .read<ProfileCubit>()
                          .getListingDetail(item.id ?? 0);

                      if (res != null) {
                        await context.router
                            .push(CreateListingWrapperScreenRoute(
                          dataDetail: res,
                        ))
                            .then(
                          (value) {
                            if (value == true) {
                              context.read<ProfileCubit>().getDrafts();
                            }
                          },
                        );
                      }
                    },
                    padding: EdgeInsets.zero,
                    radius: 0,
                    bgColor: appColors.white,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: AppImage(
                              imageUrl: item.primaryImage?.data?.url ?? ''),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.urlTitle ?? '',
                                style: AppStyles.of(context).copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                item.title ?? '',
                                style: AppStyles.of(context).copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                item.priceNzd?.toStringAsFixed(2) ?? '',
                                style: AppStyles.of(context).copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
