import 'package:auto_route/auto_route.dart';
import 'package:qwid/src/components/text_field/custom_text_field.dart';
import 'package:qwid/src/configs/app_themes/app_colors.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:qwid/src/configs/app_themes/app_styles.dart';
import 'package:qwid/src/core/di/injections.dart';
import 'package:qwid/src/core/extensions/amount.dart';
import 'package:qwid/src/core/network/response/enum/progress_status.dart';
import 'package:qwid/src/features/home/domain/repositories/home_repository.dart';
import 'package:qwid/src/features/home/presentation/cubit/offer_cubit.dart';
import 'package:qwid/src/features/home/presentation/dialogs/presenters/option_presenter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MakeOfferWrapperDialog extends StatelessWidget{
  const MakeOfferWrapperDialog({
    required this.title,
    required this.originalPrice,
    required this.picture,
    required this.currency,
    required this.listingId,
    super.key,
  });

  final double originalPrice;
  final String title;
  final String picture;
  final String currency;
  final int listingId;

  void _showMessage({required String message, required BuildContext context}) {
    var snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    List<OptionPresenter> options = [
      OptionPresenter(id: 0, reducePercent: 15, price: double.parse((originalPrice * 15 / 100).toStringAsFixed(2)), currency: 'nzd'),
      OptionPresenter(id: 1, reducePercent: 10, price: double.parse((originalPrice * 10 / 100).toStringAsFixed(2)), currency: 'nzd', isRecommended: true),
      OptionPresenter(id: 2, reducePercent: 0, price: originalPrice, currency: 'nzd'),
    ];
    return MultiBlocProvider(
        providers: [
          BlocProvider<OfferCubit>(
            create: (context) => OfferCubit(di<HomeRepository>())..updateListingId(listingId))
        ],
        child: MultiBlocListener(
            listeners: [
              BlocListener<OfferCubit, OfferState>(
                  listener: (context, state) {
                    if(state.makeOfferStatus == ProgressStatus.success) {
                      context.router.pop();
                      _showMessage(message: 'Success!', context: context);
                    } else if(state.makeOfferStatus == ProgressStatus.failure) {
                      context.router.pop();
                      _showMessage(message: state.errorMessage ?? '', context: context);
                    }
                    /// do something here
                  }),
            ], child: MakeOfferDialog(
                  originalPrice: originalPrice,
                  title: title,
                  picture: picture,
                  currency: currency,
                  options: options
            ),
        ));
  }

}

class MakeOfferDialog extends StatefulWidget {
  const MakeOfferDialog({
    required this.title,
    required this.originalPrice,
    required this.picture,
    required this.currency,
    required this.options,
    super.key,
  });

  final double originalPrice;
  final String title;
  final String picture;
  final String currency;
  final List<OptionPresenter> options;

  @override
  State<MakeOfferDialog> createState() => _MakeOfferDialogState();
}

class _MakeOfferDialogState extends State<MakeOfferDialog> {
  final TextEditingController _textEditingController = TextEditingController();
  double get shortestSide => MediaQuery.of(context).size.shortestSide;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.all(16),
      child: BlocBuilder<OfferCubit, OfferState>(
        builder: (context, state) {
          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Title Row
                      Text(
                        "Make an Offer",
                        style: AppStyles.of(context).copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Product Row
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              widget.picture, // Replace with product image
                              width: 72,
                              height: 72,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 17),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.title,
                                  style: AppStyles.of(context).copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 3),
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Text(
                                      widget.originalPrice.asNZDFormat(),
                                      style: AppStyles.of(context).copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: 6),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "(Shipping Included)",
                                          style: AppStyles.of(context).copyWith(
                                              fontSize: 12,
                                              color: appColors.mediumGray,
                                              fontWeight: FontWeight.w400
                                          ),
                                        ),
                                        SizedBox(width: 3),
                                        SvgPicture.asset(
                                          icInfoGrey,
                                          width: 12.8,
                                          height: 12.8,
                                          color: appColors.mediumGray,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Offer Options
                      Row(
                        children: widget.options.map((e) =>
                            Expanded(child: _offerOption(option: e, context: context))).toList(),
                      ),
                      state.selectedId == 2 ? Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),

                          // Custom Offer
                          Text(
                            "Custom offer:",
                            style: AppStyles.of(context).copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          const SizedBox(height: 8),
                          CustomTextFormField(
                            inputFormatters: [CommaToDotTextFormatter()],
                            prefixIcon: Text(
                              "\$",
                              style: AppStyles.of(context).copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: appColors.black
                              ),
                            ),
                            controller: _textEditingController,
                            style: AppStyles.of(context).copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: appColors.manatee
                            ),
                            decoration: InputDecoration(
                              prefixText: '\$ ',
                              hintStyle: AppStyles.of(context).copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: appColors.manatee
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              hintText: "0.00",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                            ),
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            onChanged: (text) {
                              context.read<OfferCubit>().updatePrice(text);
                            },
                          ),
                        ],
                      ) : SizedBox.shrink(),
                      const SizedBox(height: 12),

                      // Terms
                      Text(
                        "All offers are binding for 72 hours. Accepted offers must be completed. Additional shipping fee applies to rural addresses.",
                        style: AppStyles.of(context).copyWith(
                          fontSize: 11,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),

                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        child: BlocBuilder<OfferCubit, OfferState>(
                          builder: (context, state) {
                            final isValid = (state.selectedId != 2
                                && state.selectedId != null
                                && state.selectedId != -1);
                            final isCustomValid = state.selectedId == 2
                                && _textEditingController.text.isNotEmpty
                                && (state.selectedId != null
                                && state.selectedId! > 0);
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: (isValid || isCustomValid) ? Colors.black : Colors.black.withAlpha(50),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                if(!isValid && !isCustomValid) return;
                                context.read<OfferCubit>().makeOffer();
                              },
                              child: (state.makeOfferStatus == ProgressStatus.inProgress)
                                  ? CupertinoActivityIndicator(
                                      color: Colors.white,
                                      radius: 16)
                                  : Text(
                                      "Submit Offer",
                                      style: AppStyles.of(context).copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: appColors.white),
                              )
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _offerOption({
    required OptionPresenter option,
    required BuildContext context,
  }) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          context.read<OfferCubit>().updateCurrency(option.currency);
          context.read<OfferCubit>().updatePrice(option.price.toString());
          context.read<OfferCubit>().updateSelectedId(option.id);
        },
        child: Stack(
          children: [
            BlocBuilder<OfferCubit, OfferState>(
              builder: (context, state) {
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(4, 6, 4, 0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: state.selectedId == option.id
                          ? appColors.black
                          : option.isRecommended
                            ? appColors.cornflower
                            : AppColorss.borderColor,
                      width: (state.selectedId == option.id || option.isRecommended) ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.fromLTRB(0, 12, 0, 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        option.id == 2
                          ? 'Custom'
                          : option.price.asDFormat(),
                        style: AppStyles.of(context).copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: shortestSide < 376 ? 13: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 1),
                      Text(
                        option.id == 2
                          ? 'Set your price'
                          : '${option.reducePercent}% off',
                        style: AppStyles.of(context).copyWith(
                          color: appColors.mediumGray,
                          fontWeight: FontWeight.w500,
                          fontSize: shortestSide < 376 ? 10: 12,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Positioned(
              child: Align(
                alignment: Alignment.topCenter,
                child: !option.isRecommended ? SizedBox() : Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: appColors.cornflower,
                    borderRadius: BorderRadius.circular(1.4),
                  ),
                  child: Text(
                    "RECOMMENDED",
                    style: AppStyles.of(context).copyWith(
                      color: appColors.cobatBlue,
                      fontSize: 7.52,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommaToDotTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // Replace commas with dots
    String newText = newValue.text.replaceAll(',', '.');

    // Allow only one dot
    if (RegExp(r'\..*\.').hasMatch(newText)) {
      return oldValue;
    }

    // Limit to max 2 decimal places
    if (newText.contains('.')) {
      List<String> parts = newText.split('.');
      if (parts.length > 1 && parts[1].length > 2) {
        return oldValue;
      }
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}