// ignore_for_file: must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:designerwardrobe/src/core/di/injections.dart';
import 'package:designerwardrobe/src/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:designerwardrobe/src/features/create_listing/presentation/cubit/create_listing_cubit.dart';
import 'package:designerwardrobe/src/features/item_detail/data/remote/dtos/listing_detail_response.dart';
import 'package:designerwardrobe/src/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage(name: createListingWrapperScreenName)
class CreateListingWrapperScreen extends StatelessWidget
    implements AutoRouteWrapper {
  CreateListingWrapperScreen({
    super.key,
    this.dataDetail,
  });

  ListingDetailResponseData? dataDetail;

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<AuthCubit>(
          create: ((context) => di<AuthCubit>()..initData())),
      BlocProvider<CreateListingCubit>(
          create: (context) =>
              di<CreateListingCubit>()..initData(dataDetail: dataDetail)),
    ], child: this);
  }

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
