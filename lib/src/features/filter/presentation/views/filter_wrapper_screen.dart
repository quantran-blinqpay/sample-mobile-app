import 'package:auto_route/auto_route.dart';
import 'package:designerwardrobe/src/core/di/injections.dart';
import 'package:designerwardrobe/src/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:designerwardrobe/src/features/filter/presentation/cubit/filter_sort_cubit.dart';
import 'package:designerwardrobe/src/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage(name: filterWrapperScreenName)
class FilterWrapperScreen extends StatelessWidget implements AutoRouteWrapper {
  const FilterWrapperScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<AuthCubit>(
          create: ((context) => di<AuthCubit>()..initData())),
      BlocProvider<FilterSortCubit>(
          create: (context) => di<FilterSortCubit>()..initData()),
    ], child: this);
  }

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
