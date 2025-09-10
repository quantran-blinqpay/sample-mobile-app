import 'package:qwid/gen/assets.gen.dart';
import 'package:qwid/src/components/scaffold/app_scaffold.dart';
import 'package:qwid/src/configs/app_themes/app_colors.dart';
import 'package:qwid/src/configs/app_themes/app_styles.dart';
import 'package:qwid/src/features/payment/presentation/widgets/loading/widgets/delivery_method_loading.dart';
import 'package:qwid/src/features/payment/presentation/widgets/loading/widgets/order_summary_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentLoading extends StatelessWidget {
  const PaymentLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return AppScaffold(
      appBar: AppBar(
        toolbarHeight: 48,
        automaticallyImplyLeading: false,
        leading: SizedBox(width: 30, height: 30),
        backgroundColor: appColors.lavender,
        title: Center(
          child: Text(
            'SECURE CHECKOUT',
            style: AppStyles.of(context).copyWith(
              color: Colors.black,
              fontSize: 18,
              height: 13 / 14,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.all(5),
            icon: SvgPicture.asset(
              Assets.svgs.icClose,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.only(top: 4),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return _buildDeliverMethod(context);
                },
                // Or, uncomment the following line:
                childCount: 1,
              ),
            ),
          ),
          _buildDivider(context: context, height: 14),
          SliverPadding(
            padding: EdgeInsets.only(top: 4),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return _buildOrderSummary(context);
                },
                // Or, uncomment the following line:
                childCount: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliverMethod(BuildContext context) {
    return DeliveryMethodLoading();
  }

  Widget _buildDivider({required BuildContext context, required double height}) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return SliverPadding(
        padding: EdgeInsets.only(top: 15),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return ColoredBox(
                color: appColors.gainsboro,
                child: SizedBox(height: height),
              );
            },
            // Or, uncomment the following line:
            childCount: 1,
          ),
        )
    );
  }

  Widget _buildOrderSummary(BuildContext context) {
    return OrderSummaryLoading();
  }


}