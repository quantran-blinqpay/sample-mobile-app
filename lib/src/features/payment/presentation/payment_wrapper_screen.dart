import 'package:auto_route/auto_route.dart';
import 'package:designerwardrobe/src/core/di/injections.dart';
import 'package:designerwardrobe/src/features/item_detail/data/remote/dtos/listing_detail_response.dart';
import 'package:designerwardrobe/src/features/payment/domain/repositories/payment_repository.dart';
import 'package:designerwardrobe/src/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:designerwardrobe/src/features/payment/presentation/payment_screen.dart';
import 'package:designerwardrobe/src/features/profile/domain/repositories/profile_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:designerwardrobe/src/router/route_names.dart';

@RoutePage(name: paymentWrapperScreenName)
class PaymentWrapperScreen extends StatelessWidget {
  const PaymentWrapperScreen({required this.data, super.key});
  final ListingDetailResponseData? data;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<PaymentCubit>(
              create: (context) => PaymentCubit(di<PaymentRepository>(), di<ProfileRepository>())
                ..loadCountries()
                ..getCurrencyRate()
                ..getMyProfile()
                ..loadShippingAddress()
                ..updateProductInfo(data)
                ..updateListingId(data?.id ?? -1)
                ..loadWindCaveCards()
          ),
        ],
        child: PaymentScreen(),
    );
  }
}
