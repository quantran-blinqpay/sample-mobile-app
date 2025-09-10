import 'package:qwid/gen/assets.gen.dart';
import 'package:qwid/src/components/button/app_button.dart';
import 'package:qwid/src/components/scaffold/app_scaffold.dart';
import 'package:qwid/src/configs/app_themes/app_colors.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:qwid/src/configs/app_themes/app_styles.dart';
import 'package:qwid/src/core/extensions/amount.dart';
import 'package:qwid/src/core/network/response/enum/progress_status.dart';
import 'package:qwid/src/features/payment/presentation/widgets/delivery_method/delivery_method.dart';
import 'package:qwid/src/features/payment/presentation/widgets/loading/payment_loading.dart';
import 'package:qwid/src/features/payment/presentation/widgets/order_summary/order_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'cubit/payment_cubit.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> with TickerProviderStateMixin, WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PaymentCubit, PaymentState>(
            listenWhen: (prev, current) => prev.getPaymentInfoStatus != current.getPaymentInfoStatus,
            listener: (context, state) {
              if (state.getPaymentInfoStatus == ProgressStatus.success) {
                // _showMessage(message: 'getPaymentInfo success!', context: context);
              }
            }),
        BlocListener<PaymentCubit, PaymentState>(
            listenWhen: (prev, current) => prev.completePurchaseStatus != current.completePurchaseStatus,
            listener: (context, state) {
              if (state.completePurchaseStatus == ProgressStatus.success) {
                _showMessage(message: 'completePurchase success!', context: context);
              } else if (state.completePurchaseStatus == ProgressStatus.failure) {
                _showMessage(message: state.errorMessage ?? '', context: context);
              }
            }),
      ],
      child: BlocBuilder<PaymentCubit, PaymentState>(
          builder: (context, state) {
            if(state.getMyAddressStatus == ProgressStatus.inProgress
                || state.getMyAddressStatus == ProgressStatus.initial) {
              return PaymentLoading();
            } else if(state.getWindcaveCardsStatus == ProgressStatus.inProgress
                || state.getWindcaveCardsStatus == ProgressStatus.initial) {
              return PaymentLoading();
            } else if(state.getPaymentInfoStatus == ProgressStatus.inProgress
                || state.getPaymentInfoStatus == ProgressStatus.initial ) {
              return PaymentLoading();
            } else if(state.fetchCurrencyStatus == ProgressStatus.inProgress
                || state.fetchCurrencyStatus == ProgressStatus.initial) {
              return PaymentLoading();
            } /*if(state.getMyAddressStatus == ProgressStatus.failure) {
            return PaymentEmpty(error: 'getMyAddress fail');
          } else if(state.getWindcaveCardsStatus == ProgressStatus.failure) {
            return PaymentEmpty(error: 'getWindcaveCards fail');
          } else if(state.getPaymentInfoStatus == ProgressStatus.failure) {
            return PaymentEmpty(error: 'getPaymentInfo fail');
          } else if(state.fetchCurrencyStatus == ProgressStatus.failure) {
            return PaymentEmpty(error: 'fetchCurrency fail');
          }*/
            return _buildBodyWidget(context);
            /// do something here
          }),
    );
  }

  final ValueNotifier<bool> _isShowStickyHeader = ValueNotifier(false);

  late Animation<Offset> _animation;

  late AnimationController _animationController;

  final GlobalKey _stickyHeaderKey = GlobalKey();

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Start "off screen" at bottom (y = 1), slide up to visible (y = 0)
    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 1),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  double _lastOffset = 0; // store previous scroll position

  bool _scrollListener(ScrollNotification scrollNotification) {
    if (scrollNotification.metrics.axis == Axis.vertical) {
      final currentOffset = scrollNotification.metrics.pixels;

      if (scrollNotification.metrics.pixels > _lastOffset && currentOffset > 50) {
        // 👉 scrolling DOWN → show
        if (!_isShowStickyHeader.value) {
          _isShowStickyHeader.value = true;
          _animationController.forward(from: 0);
        }
      } else if (currentOffset < _lastOffset) {
        // 👉 scrolling UP → hide
        if (_isShowStickyHeader.value) {
          _isShowStickyHeader.value = false;
          _animationController.reverse(from: 1);
        }
      }

      _lastOffset = currentOffset;
    }
    return true;
  }

  Widget _buildBodyWidget(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        return AppScaffold(
          isLoading: state.completePurchaseStatus == ProgressStatus.inProgress
              || state.getPaymentInfoInSilenceStatus == ProgressStatus.inProgress,
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
          body: NotificationListener(
            onNotification: _scrollListener,
            child: Stack(
              children: [
                CustomScrollView(
                  controller: _scrollController,
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
                    SliverPadding(
                      padding: EdgeInsets.only(top: 4, bottom: 15, left: 15, right: 15),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            return _buildButton(context);
                          },
                          // Or, uncomment the following line:
                          childCount: 1,
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.only(top: 4, bottom: 0, left: 0, right: 0),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            return _buildFooter(context);
                          },
                          // Or, uncomment the following line:
                          childCount: 1,
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SlideTransition(
                    position: _animation,
                    child: ColoredBox(
                      key:_stickyHeaderKey,
                      color: appColors.white,
                      child: SizedBox(
                        key:_stickyHeaderKey,
                        width: double.infinity,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 15),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: _buildTotal(context),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 4, bottom: 15, left: 15, right: 15),
                              child: BlocBuilder<PaymentCubit, PaymentState>(
                                builder: (context, state) {
                                  if(state.paymentInfo?.pricing?.totalToPay == 0) {
                                    return AppButton(
                                      title: 'Pay now',
                                      onPressed: () {
                                        context.read<PaymentCubit>().completePurchase();
                                      },
                                      backgroundColor: appColors.black,
                                      textColor: appColors.white,
                                      radius: 5,
                                    );
                                  }
                                  bool isCardValid = state.selectedCards != null;
                                  bool isAddressValid = state.selectedAddress != null;
                                  bool isValid = isCardValid && isAddressValid;
                                  return AppButton(
                                    title: 'Pay now',
                                    onPressed: !isValid ? null :() {
                                      context.read<PaymentCubit>().completePurchase();
                                    },
                                    backgroundColor: !isValid ? appColors.black.withAlpha(80) : appColors.black,
                                    textColor: appColors.white,
                                    radius: 5,
                                  );
                                },
                              ),
                            ),
                            SafeArea(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 30.0),
                                child: Text('All transactions are encrypted & secure',
                                  style: AppStyles.of(context).copyWith(
                                  fontSize: 11,
                                  color: appColors.black,
                                  fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTotal(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Row(
      children: [
        Expanded(
          child: Text(
            'Total to pay',
            style: AppStyles.of(context).copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: appColors.black,
            ),
          ),
        ),
        BlocBuilder<PaymentCubit, PaymentState>(
          builder: (context, state) {
            return RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text:
                    'NZD ',
                    style: AppStyles.of(context).copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: appColors.black,
                    ),
                  ),
                  TextSpan(
                    text:
                    state.paymentInfo?.pricing?.totalToPay?.asDFormat(fallback: '\$0.00'),
                    style: AppStyles.of(context).copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: appColors.black,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildOrderSummary(BuildContext context) {
    return OrderSummary();
  }

  Widget _buildDeliverMethod(BuildContext context) {
    return DeliveryMethod();
  }

  Widget _buildButton(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Column(
      children: [
        BlocBuilder<PaymentCubit, PaymentState>(
          builder: (context, state) {
            if(state.paymentInfo?.pricing?.totalToPay == 0) {
              return AppButton(
                title: 'Pay now',
                onPressed: () {
                  context.read<PaymentCubit>().completePurchase();
                },
                backgroundColor: appColors.black,
                textColor: appColors.white,
                radius: 5,
              );
            }
            bool isCardValid = state.selectedCards != null;
            bool isAddressValid = state.selectedAddress != null;
            bool isValid = isCardValid && isAddressValid;
            return AppButton(
              title: 'Pay now',
              onPressed: !isValid ? null :() {
                context.read<PaymentCubit>().completePurchase();
              },
              backgroundColor: !isValid ? appColors.black.withAlpha(80) : appColors.black,
              textColor: appColors.white,
              radius: 5,
            );
          },
        ),
        SizedBox(height: 15),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(icProtection, width: 12, height: 14),
            SizedBox(width: 15),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text:
                    'DW Purchase protection ',
                    style: AppStyles.of(context).copyWith(
                      color: appColors.black,
                      fontSize: 10.8,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  TextSpan(
                    text:
                    'included',
                    style: AppStyles.of(context).copyWith(
                      color: appColors.black,
                      fontSize: 10.8,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        )
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(color: appColors.lavender),
        child: Image.asset(icWindcave, width: 91, height: 65),
      ),
    );
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

  void _showMessage({required String message, required BuildContext context}) {
    var snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
