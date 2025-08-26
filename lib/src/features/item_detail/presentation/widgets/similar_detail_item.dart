// ignore_for_file: must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:designerwardrobe/gen/assets.gen.dart';
import 'package:designerwardrobe/src/components/button/app_button.dart';
import 'package:designerwardrobe/src/components/image/app_image.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_themes.dart';
import 'package:designerwardrobe/src/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:designerwardrobe/src/features/helper/cubit/helper_cubit.dart';
import 'package:designerwardrobe/src/features/home/data/remote/dtos/product_info.dart';
import 'package:designerwardrobe/src/features/item_detail/data/remote/dtos/listing_detail_response.dart';
import 'package:designerwardrobe/src/features/item_detail/presentation/cubit/item_detail_cubit.dart';
import 'package:designerwardrobe/src/router/router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';

class SimilarDetailItem extends StatelessWidget {
  SimilarDetailItem({super.key, required this.data});

  final ListingDetailResponseData? data;
  late AppColors? appColors;

  @override
  Widget build(BuildContext context) {
    appColors = Theme.of(context).extension<AppColors>();
    return BlocBuilder<ItemDetailCubit, ItemDetailState>(
      buildWhen: (previous, current) =>
          previous.recommendedItems != current.recommendedItems,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(9, 4, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Similar listings',
                      style: AppStyles.of(context).copyWith(
                        color: appColors!.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Text(
                          'View all',
                          style: AppStyles.of(context).copyWith(
                            color: appColors!.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: 8),
                        Transform.flip(
                          flipX: true, // horizontal mirror
                          child: SvgPicture.asset(
                            Assets.svgs.icArrowBack,
                            width: 14,
                            height: 14,
                            colorFilter: ColorFilter.mode(
                              appColors!.black,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.fromLTRB(0, 0, 9, 8),
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 21,
                  childAspectRatio: 181 / (218 + 88),
                ),
                itemCount: state.recommendedItems?.take(4).length ?? 0,
                itemBuilder: (context, index) {
                  final item = state.recommendedItems![index].values;
                  return ElevatedAppButton(
                    onPressed: () {
                      context.router.push(
                        ItemDetailWrapperScreenRoute(
                            id: int.tryParse(
                                    state.recommendedItems![index].id ?? '0') ??
                                0),
                      );
                    },
                    bgColor: appColors!.white,
                    padding: EdgeInsets.zero,
                    radius: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image
                        Stack(
                          children: [
                            AspectRatio(
                              aspectRatio: 181 / 218,
                              child: AppImage(imageUrl: item?.imageUrl ?? ''),
                            ),
                            if (item?.isSale ?? false)
                              Positioned(
                                bottom: 7,
                                right: 7,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 7, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: appColors!.white,
                                    border: Border.all(
                                        width: 0.82,
                                        color: appColors!.gainsboro),
                                    borderRadius: BorderRadius.circular(6.6),
                                  ),
                                  child: Text(
                                    "filter.sale".tr(),
                                    style: AppStyles.of(context).copyWith(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: appColors!.brightRed,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Title & price
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    item?.title ?? '',
                                    style: AppStyles.of(context).copyWith(
                                      color: appColors!.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                if (item?.description?.isNotEmpty ?? false)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      item?.description ?? '',
                                      style: AppStyles.of(context).copyWith(
                                        color: appColors!.dimGray,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                if (item?.sizesStr?.isNotEmpty ?? false)
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      item?.sizesStr ?? '',
                                      style: AppStyles.of(context).copyWith(
                                        color: appColors!.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 4.0),
                                        child: _buildPrice(context, item),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 0.0),
                                      child: ElevatedAppButton(
                                        width: 32,
                                        height: 32,
                                        onPressed: () {},
                                        bgColor: Colors.transparent,
                                        radius: 32,
                                        padding: EdgeInsets.zero,
                                        child: SvgPicture.asset(
                                          Assets.svgs.icHeartFilled,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }

  RichText _buildPrice(BuildContext context, ProductInfo? item) {
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

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text:
                '\$${(price ?? 0) % 1 == 0 ? price?.toInt() : price?.toStringAsFixed(2) ?? ''} ',
            style: AppStyles.of(context).copyWith(
              color: item?.isSale ?? false ? appColors!.red : appColors!.black,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (originalPrice != price)
            TextSpan(
              text:
                  '\$${(originalPrice ?? 0) % 1 == 0 ? originalPrice?.toInt() : originalPrice?.toStringAsFixed(2) ?? ''}',
              style: AppStyles.of(context).copyWith(
                color: appColors!.nobel,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          if (discount != 0)
            TextSpan(
              text: '  $discount% off',
              style: AppStyles.of(context).copyWith(
                color: appColors!.black,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
        ],
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }
}
