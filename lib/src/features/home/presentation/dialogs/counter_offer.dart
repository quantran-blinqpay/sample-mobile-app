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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CounterOfferWrapperDialog extends StatelessWidget{
  const CounterOfferWrapperDialog({
    required this.title,
    required this.askingPrice,
    required this.buyerOfferPrice,
    required this.picture,
    required this.currency,
    required this.listingId,
    required this.listingOfferId,
    required this.isSeller,
    super.key,
  });

  final double askingPrice;
  final double buyerOfferPrice;
  final String title;
  final String picture;
  final String currency;
  final int listingId;
  final int listingOfferId;
  final bool isSeller;

  void _showMessage({required String message, required BuildContext context}) {
    var snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<OfferCubit>(
              create: (context) => OfferCubit(di<HomeRepository>())
                ..updateListingId(listingId)
                ..updateListingOfferId(listingOfferId)
                ..updateCurrency(currency))
        ],
        child: MultiBlocListener(
            listeners: [
              BlocListener<OfferCubit, OfferState>(
                  listener: (context, state) {
                    if(state.counterOfferStatus == ProgressStatus.success) {
                      context.router.pop();
                      _showMessage(message: 'Success!', context: context);
                    } else if(state.counterOfferStatus == ProgressStatus.failure) {
                      context.router.pop();
                      _showMessage(message: state.errorMessage ?? '', context: context);
                    }
                    /// do something here
                  }),
            ], child: CounterOfferDialog(
                  askingPrice: askingPrice,
                  buyerOfferPrice: buyerOfferPrice,
                  title: title,
                  picture: picture,
                  currency: currency,
                  isSeller: isSeller,
              ),
        ),
    );
  }

}

class CounterOfferDialog extends StatefulWidget {
  const CounterOfferDialog({
    required this.title,
    required this.askingPrice,
    required this.buyerOfferPrice,
    required this.picture,
    required this.currency,
    required this.isSeller,
    super.key,
  });

  final double askingPrice;
  final double buyerOfferPrice;
  final String title;
  final String picture;
  final String currency;
  final bool isSeller;

  @override
  State<CounterOfferDialog> createState() => _CounterOfferDialogState();
}

class _CounterOfferDialogState extends State<CounterOfferDialog> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title Row
                Text(
                  "Counter Offer",
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
                        widget.picture,
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
                            "Asking price · \$${widget.askingPrice.asDFormat()}",
                            style: AppStyles.of(context).copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: appColors.mediumGray,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            "Buyer’s offer: NZD \$${widget.buyerOfferPrice.asDFormat()}",
                            style: AppStyles.of(context).copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 3),
                          Row(
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
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Divider(height: 1, color: appColors.silverSand,),
                // Offer Options
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    // Custom Offer
                    Text(
                      "Your counter offer:",
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
                    const SizedBox(height: 10),
                    Text(
                      "This price includes shipping",
                      style: AppStyles.of(context).copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: appColors.mediumGray,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 34),

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
                      final isValid = state.price?.isNotEmpty ?? false ;
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: (isValid) ? Colors.black : Colors.black.withAlpha(50),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          if(!isValid) return;
                          context.read<OfferCubit>().counterOffer(widget.isSeller);
                        },
                        child: (state.counterOfferStatus == ProgressStatus.inProgress)
                            ? CupertinoActivityIndicator(
                            color: Colors.white,
                            radius: 16)
                            : Text(
                          "Submit Offer",
                          style: AppStyles.of(context).copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: appColors.white
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
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