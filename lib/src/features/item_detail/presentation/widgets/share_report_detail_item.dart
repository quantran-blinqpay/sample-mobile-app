// ignore_for_file: must_be_immutable

import 'package:designerwardrobe/gen/assets.gen.dart';
import 'package:designerwardrobe/src/components/button/app_button.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_themes.dart';
import 'package:designerwardrobe/src/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:designerwardrobe/src/features/helper/cubit/helper_cubit.dart';
import 'package:designerwardrobe/src/features/item_detail/data/remote/dtos/listing_detail_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';

class ShareReportDetailItem extends StatelessWidget {
  ShareReportDetailItem({super.key, required this.data});

  final ListingDetailResponseData? data;
  late AppColors? appColors;

  @override
  Widget build(BuildContext context) {
    appColors = Theme.of(context).extension<AppColors>();

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 21, 12, 21),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              _buildShippingInclued(context),
              style: AppStyles.of(context).copyWith(
                color: appColors!.black,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 15),
              Flexible(
                child: Text(
                  _calPayIn4(data),
                  style: AppStyles.of(context).copyWith(
                    color: appColors!.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: 10),
              if (data?.showAfterpay ?? false) ...[
                Image.asset(
                  Assets.images.imgAfterpay.path,
                  height: 15,
                ),
                SizedBox(width: 4),
              ],
              if (data?.showLaybuy ?? false) ...[
                Image.asset(
                  Assets.images.imgLaybuy.path,
                  height: 15,
                ),
                SizedBox(width: 4),
              ],
              if (data?.showZip ?? false)
                Image.asset(
                  Assets.images.imgZip.path,
                  height: 15,
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(3, 8, 0, 8),
            child: TextButton(
              onPressed: () {
                // TODO_(Quangdm): show dialog hardcode
              },
              child: Text(
                'Size guide',
                style: AppStyles.of(context).copyWith(
                  shadows: [
                    Shadow(color: appColors!.black, offset: Offset(0, -3))
                  ],
                  color: Colors.transparent,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedAppButton(
                onPressed: () {
                  // TODO_(Quangdm): show dialog hardcode
                },
                height: 32,
                bgColor: appColors!.whiteSmoke,
                padding: EdgeInsets.fromLTRB(12, 6, 12, 6),
                radius: 7,
                child: Row(
                  children: [
                    Text(
                      'Share listing',
                      style: AppStyles.of(context).copyWith(
                        color: appColors!.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 12),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: SvgPicture.asset(
                        Assets.svgs.icSent,
                        colorFilter: ColorFilter.mode(
                          appColors!.black,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12),
              // TODO_(Quangdm): Check neu la seller thi khong hien thi button nay
              ElevatedAppButton(
                onPressed: () {
                  // TODO_(Quangdm): show bts hardcode
                },
                height: 32,
                bgColor: appColors!.whiteSmoke,
                padding: EdgeInsets.fromLTRB(12, 4, 12, 4),
                radius: 7,
                child: Row(
                  children: [
                    Text(
                      'Report listing',
                      style: AppStyles.of(context).copyWith(
                        color: appColors!.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 12),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: SvgPicture.asset(
                        Assets.svgs.icWarning,
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
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 26, 0, 0),
            child: Text(
              _buildCategoryText(data),
              style: AppStyles.of(context).copyWith(
                color: appColors!.black,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _buildShippingInclued(BuildContext context) {
    /**
    * NZ -> NZ: 1-3 business days
      NZ -> AU: 4-7 business days
      AU -> AU: 1-5 business days
      AU -> NZ: 4-7 business days
    */
    final sellerCountry = data?.user?.data?.country?.toLowerCase();

    final userCountry =
        context.read<AuthCubit>().state.isFromAud ?? false ? 'au' : 'nz';

    bool isFromNz = (sellerCountry?.contains('nz') ?? false) ||
        (sellerCountry?.contains('new zealand') ?? false);

    switch ('${isFromNz ? 'nz' : 'au'}_$userCountry') {
      case 'nz_nz':
        return 'Ships from New Zealand (1-3 days)';
      case 'nz_au':
        return 'Ships from New Zealand (4-7 days)';
      case 'au_au':
        return 'Ships from Australia (1-5 days)';
      default:
        return 'Ships from Australia (4-7 days)';
    }
  }

  String _buildCategoryText(ListingDetailResponseData? data) {
    return data?.category?.urlTitle
            ?.split('-')
            .map((word) => word.isNotEmpty
                ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
                : '')
            .where((w) => w.isNotEmpty)
            .join('  /  ') ??
        '';
  }

  String _calPayIn4(ListingDetailResponseData? data) {
    final helperState = GetIt.instance<HelperCubit>().state;

    final price = data?.pricePattern
        ?.calSalePrice('NZ', helperState.currencyRate?.rateAudToNzd ?? 1);

    return 'Pay in 4 x \$${((price ?? 1) / 4).toStringAsFixed(2)} with';
  }
}
