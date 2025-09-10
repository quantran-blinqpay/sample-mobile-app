import 'package:qwid/src/configs/app_themes/app_colors.dart';
import 'package:qwid/src/configs/app_themes/app_styles.dart';
import 'package:qwid/src/core/extensions/amount.dart';
import 'package:qwid/src/features/payment/presentation/widgets/order_summary/list_order/list_order.dart';
import 'package:flutter/material.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({required this.item, super.key});
  final OrderPresenter item;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with discount badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  item.image, // Replace with your image
                  width: 65,
                  height: 65,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                bottom: 4,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: item.discountPercent == 0
                      ? SizedBox.shrink()
                      : Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: appColors.paleYellow,
                      borderRadius: BorderRadius.circular(1.6),
                    ),
                    child: Text(
                      '${item.discountPercent}% off',
                      style: AppStyles.of(context).copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: appColors.vividBlue,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 15),
          // Product info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: AppStyles.of(context).copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: appColors.black,
                    ),
                ),
                SizedBox(height: 2),
                Text(
                  item.description,
                  style: AppStyles.of(context).copyWith(
                      fontSize: 12,
                      color: appColors.dimGray,
                      fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  item.size,
                  style: AppStyles.of(context).copyWith(
                      fontSize: 12,
                      color: appColors.dimGray,
                      fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          // Price info
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                item.discountPrice.asNZDFormat(),
                style: AppStyles.of(context).copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: item.discountPercent == 0 ? appColors.black: appColors.vividBlue,
                ),
              ),
              item.discountPercent == 0
                  ? SizedBox.shrink()
                  : Text(
                item.price.asDFormat(),
                style: AppStyles.of(context).copyWith(
                  fontSize: 12,
                  color: appColors.black,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              Text(
                'Shipping included',
                style: AppStyles.of(context).copyWith(
                    fontSize: 12,
                    color: appColors.dimGray,
                    fontWeight: FontWeight.w400,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}