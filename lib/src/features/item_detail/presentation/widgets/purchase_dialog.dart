import 'package:designerwardrobe/gen/assets.gen.dart';
import 'package:designerwardrobe/src/components/bottom_sheet/app_webview.dart';
import 'package:designerwardrobe/src/components/bottom_sheet/bottom_sheet.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PurchaseDialog extends StatelessWidget {
  const PurchaseDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(right: 8),
              alignment: Alignment.centerRight,
              child: IconButton(
                padding: EdgeInsets.all(5),
                icon: SvgPicture.asset(Assets.svgs.icClose),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'How does Purchase Protection work?',
                      style: AppStyles.of(context).copyWith(
                        fontFamily: 'FeatureDeckCondensed',
                        fontSize: 21,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Every time you shop with us, you're always covered by our Purchase Protection policy, giving you peace of mind with every transaction. We've got you!",
                      style: AppStyles.of(context).copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12),
                    Text(
                      "What’s Covered?",
                      style: AppStyles.of(context).copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "If your item never ships or doesn’t match the listing description, we’ll give you a full refund ensuring a hassle‑free experience.",
                      style: AppStyles.of(context).copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Once your item is scanned as “delivered” you’ll have 24 hours to inspect it before the payment is released to the seller.",
                      style: AppStyles.of(context).copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12),
                    Text(
                      "What’s Not Covered?",
                      style: AppStyles.of(context).copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "If you simply change your mind or the item doesn’t fit, we can’t provide a refund (but you can always re‑list the item on our platform!)",
                      style: AppStyles.of(context).copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Trades or transactions completed off our platform aren’t covered (we want to keep you safe, so please don’t do this!)",
                      style: AppStyles.of(context).copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12),
                    Text(
                      "How to Make a Claim",
                      style: AppStyles.of(context).copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "If your item is different from the listing description or you believe it’s a replica/fake, open a dispute immediately!",
                      style: AppStyles.of(context).copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Remember",
                      style: AppStyles.of(context).copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Purchase Protection is in place to ensure a secure and trustworthy marketplace for both buyers and sellers.",
                      style: AppStyles.of(context).copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Always thoroughly read the listing description and don’t hesitate ask the seller questions.",
                      style: AppStyles.of(context).copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Terms and conditions apply.",
                      style: AppStyles.of(context).copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12),
                    GestureDetector(
                      onTap: () async {
                        await showFMBS(
                          context: context,
                          builder: (builder) => AppWebview(
                            url:
                                'https://designerwardrobe.helpscoutdocs.com/article/39-dw-purchase-protection',
                          ),
                        );
                      },
                      child: Center(
                          child: Text(
                        "Learn more",
                        style: AppStyles.of(context).copyWith(
                          shadows: [
                            Shadow(color: Colors.black, offset: Offset(0, -2))
                          ],
                          color: Colors.transparent,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                        textAlign: TextAlign.center,
                      )),
                    ),
                    SizedBox(height: 12),
                    Center(
                        child: Text(
                      "Stay safe and happy shopping!",
                      style: AppStyles.of(context).copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
