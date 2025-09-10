import 'package:auto_route/auto_route.dart';
import 'package:qwid/src/core/di/injections.dart';
import 'package:qwid/src/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:qwid/src/features/item_detail/presentation/cubit/item_detail_cubit.dart';
import 'package:qwid/src/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage(name: itemDetailWrapperScreenName)
class ItemDetailWrapperScreen extends StatelessWidget
    implements AutoRouteWrapper {
  const ItemDetailWrapperScreen({super.key, required this.id});

  final int id;

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<AuthCubit>(
          create: ((context) => di<AuthCubit>()..initData())),
      BlocProvider<ItemDetailCubit>(
          create: (context) => di<ItemDetailCubit>()..initData(id)),
    ], child: this);
  }

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
