// ignore_for_file: must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:qwid/gen/assets.gen.dart';
import 'package:qwid/src/components/button/app_button.dart';
import 'package:qwid/src/configs/app_themes/app_themes.dart';
import 'package:qwid/src/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:qwid/src/features/filter/data/remote/dtos/filter_hits_response.dart';
import 'package:qwid/src/features/helper/cubit/helper_cubit.dart';
import 'package:qwid/src/features/home/presentation/dialogs/make_offer.dart';
import 'package:qwid/src/features/item_detail/data/remote/dtos/listing_detail_response.dart';
import 'package:qwid/src/features/item_detail/presentation/cubit/item_detail_cubit.dart';
import 'package:qwid/src/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';

class HeaderDetailItem extends StatelessWidget {
  HeaderDetailItem({super.key, required this.data});

  final ListingDetailResponseData? data;
  late AppColors? appColors;

  @override
  Widget build(BuildContext context) {
    appColors = Theme.of(context).extension<AppColors>();

    return Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 12, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (data?.numberOfWatchers != 0 &&
              data?.counts?.data?.offerCount != 0)
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Color(0xffF3DEF9),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          data?.isInWatchlist ?? false
                              ? Assets.svgs.icHeartFilled
                              : Assets.svgs.icHeart,
                          width: 13,
                          height: 13,
                        ),
                        SizedBox(width: 8),
                        Text(
                          '${data?.numberOfWatchers ?? 0} watching',
                          style: AppStyles.of(context).copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: appColors!.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 6),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Color(0xffF3DEF9),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          Assets.svgs.icOffer,
                          width: 14,
                          height: 14,
                        ),
                        SizedBox(width: 8),
                        Text(
                          '${data?.counts?.data?.offerCount ?? 0} offers sent',
                          style: AppStyles.of(context).copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: appColors!.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(height: 18),
          Text(
            data?.title ?? '',
            style: AppStyles.of(context).copyWith(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: appColors!.black,
              letterSpacing: -0.2,
            ),
          ),
          SizedBox(height: 4),
          Wrap(
            children: [
              Text(
                (data?.brand?.title ?? '').toUpperCase(),
                style: AppStyles.of(context).copyWith(
                  shadows: [
                    Shadow(color: appColors!.black, offset: Offset(0, -2))
                  ],
                  color: Colors.transparent,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                  letterSpacing: 0.2,
                ),
              ),
              Text(
                '  ·  '
                '${data?.sizes?.data?.map((e) => '${e.genericSize} / ${e.altSize}').join(', ') ?? ''}',
                style: AppStyles.of(context).copyWith(
                  shadows: [
                    Shadow(color: appColors!.black, offset: Offset(0, -2))
                  ],
                  color: Colors.transparent,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          _buildPrice(context, data?.pricePattern),
          SizedBox(height: 4),
          Row(
            children: [
              if (data?.canShipToAu ?? false)
                Expanded(
                  /**
                       * Viewer and seller have the same country: Shipping included
                         Viewer and seller have different country: Shipping included to {viewer's country}
                         Can't shipping to viewer's country: Shipping N/A
                      */
                  child: Text(
                    _buildShippingInclued(context).toUpperCase(),
                    style: AppStyles.of(context).copyWith(
                      color: appColors!.black,
                      fontSize: 8,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              Text(
                (data?.condition?.title ?? '').toUpperCase(),
                style: AppStyles.of(context).copyWith(
                  color: appColors!.black,
                  fontSize: 8,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          if (data?.isSold != true)
            Column(
              children: [
                SizedBox(height: 12),
                AppButton(
                  title: 'Buy now',
                  onPressed: () {
                    context.router.push(PaymentWrapperScreenRoute(data: data));
                  },
                  backgroundColor: appColors!.vividBlue,
                  textColor: appColors!.white,
                  radius: 5,
                ),
                SizedBox(height: 8),
                AppButton(
                  title: 'Make an offer',
                  onPressed: () {
                    final helperState = GetIt.instance<HelperCubit>().state;

                    final price = data?.pricePattern?.calSalePrice(
                        'NZ', helperState.currencyRate?.rateAudToNzd ?? 1);
                    // final originalPrice = data?.pricePattern?.calOriginalPrice(
                    //     'NZ', helperState.dataCurrencyRate?.rateAudToNzd ?? 1);
                    // final discount = data?.pricePattern?.calDiscountPercent(
                    //     salePrice: price ?? 0, originalPrice: originalPrice ?? 0);
                    showDialog(
                      context: context,
                      builder: (_) => MakeOfferWrapperDialog(
                        listingId: data?.id ?? -1,
                        title: data?.title ?? '',
                        originalPrice: price?.toDouble() ?? 0.0,
                        picture: data?.primaryImage?.data?.urlThumb ?? '',
                        currency: 'nz',
                      ),
                    );
                  },
                  backgroundColor: appColors!.black,
                  textColor: appColors!.white,
                  radius: 5,
                ),
              ],
            ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  // TODO_(Quangdm): add to fav
                  context.read<ItemDetailCubit>().addToFav(data?.id ?? 0);
                },
                child: Row(
                  children: [
                    SvgPicture.asset(
                      Assets.svgs.icHeart,
                      width: 14,
                      height: 14,
                      colorFilter: ColorFilter.mode(
                        appColors!.black,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Add to favourites',
                      style: AppStyles.of(context).copyWith(
                        color: appColors!.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 4),
              TextButton(
                onPressed: () {},
                child: Row(
                  children: [
                    SvgPicture.asset(
                      Assets.svgs.icBundle,
                      width: 14,
                      height: 14,
                      colorFilter: ColorFilter.mode(
                        appColors!.black,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Build a bundle',
                      style: AppStyles.of(context).copyWith(
                        color: appColors!.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _buildShippingInclued(BuildContext context) {
    final sellerCountry = data?.user?.data?.country?.toLowerCase();
    final userCountry =
        context.read<AuthCubit>().state.isFromAud ?? false ? 'au' : 'nz';

    bool isFromNz = true;
    if ((sellerCountry?.contains('nz') ?? false) ||
        (sellerCountry?.contains('new zealand') ?? false)) {
      isFromNz = true;
    } else {
      isFromNz = false;
    }

    if ((isFromNz && userCountry == 'nz') ||
        (!isFromNz && userCountry == 'au')) {
      return 'Shipping included';
    } else {
      return 'Shipping included to ${userCountry == 'nz' ? 'New Zealand' : 'AUSTRALIA'}';
    }
  }

  Row _buildPrice(BuildContext context, PricePattern? item) {
    final helperState = GetIt.instance<HelperCubit>().state;
    final isFromAud = context.read<AuthCubit>().state.isFromAud;

    final price = item?.calSalePrice(
      isFromAud ?? false ? 'AU' : 'NZ',
      helperState.currencyRate?.rateAudToNzd ?? 1,
    );
    final originalPrice = item?.calOriginalPrice(
      isFromAud ?? false ? 'AU' : 'NZ',
      helperState.currencyRate?.rateAudToNzd ?? 1,
    );
    final discount = item?.calDiscountPercent(
      salePrice: price ?? 0,
      originalPrice: originalPrice ?? 0,
    );

    return Row(
      children: [
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '\$${price?.toStringAsFixed(2) ?? ''}  ',
                  style: AppStyles.of(context).copyWith(
                    color: appColors!.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (originalPrice != price)
                  TextSpan(
                    text: '\$${originalPrice?.toStringAsFixed(2) ?? ''}',
                    style: AppStyles.of(context).copyWith(
                      color: appColors!.nobel,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (discount != 0)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.68, vertical: 0.52),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1.6),
              color: appColors!.paleYellow,
            ),
            child: Text(
              '$discount% off RRP',
              style: AppStyles.of(context).copyWith(
                color: appColors!.cobatBlue,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}
