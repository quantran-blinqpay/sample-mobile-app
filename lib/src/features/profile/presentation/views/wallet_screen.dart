import 'package:auto_route/auto_route.dart';
import 'package:qwid/src/components/scaffold/app_scaffold.dart';
import 'package:qwid/src/configs/app_themes/app_colors.dart';
import 'package:qwid/src/configs/app_themes/app_styles.dart';
import 'package:qwid/src/features/payment/presentation/payment_wrapper_screen.dart';
import 'package:qwid/src/router/route_names.dart';
import 'package:qwid/src/router/router.dart';
import 'package:flutter/material.dart';

@RoutePage(name: walletScreenName)
class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return AppScaffold(
      appBar: AppBar(
        toolbarHeight: 48,
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            'MY DW WALLET',
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: SizedBox(
              width: 30,
              height: 30,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // DW Cash Box
              SizedBox(
                width: double.infinity,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'DW Cash',
                        style: AppStyles.of(context).copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'NZD \$0.06',
                        style: AppStyles.of(context).copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Available for use on DW or to be withdrawn.',
                style: AppStyles.of(context).copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: appColors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              // Withdraw Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {
                    // do something here
                  },
                  child: Text(
                    'MAKE A WITHDRAWAL',
                    style: AppStyles.of(context).copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Pending Cash & DW Credit
              Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black.withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Pending Cash',
                                style: AppStyles.of(context).copyWith(
                                    fontSize: 11, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'NZD \$0.00',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Not yet available.',
                          style: AppStyles.of(context).copyWith(
                              color: appColors.black,
                              fontSize: 11,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black.withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'DW Credit',
                                style: AppStyles.of(context).copyWith(
                                    fontSize: 11, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'NZD \$0.00',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Available for use on DW.',
                          style: AppStyles.of(context).copyWith(
                              color: appColors.black,
                              fontSize: 11,
                              fontWeight: FontWeight.w400
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
