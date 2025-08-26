import 'package:designerwardrobe/src/configs/app_themes/app_images.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OtherPaymentMethod extends StatelessWidget {
  const OtherPaymentMethod({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.paymentMethodSelected,
    super.key,
  });

  final int id;
  final String logoPath;
  final String name;
  final bool paymentMethodSelected;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            SizedBox(
              width: 21,
              height: 21,
              child: SvgPicture.asset(
                  paymentMethodSelected ? icRadioSelected: icRadio
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                name,
                style: AppStyles.of(context).copyWith(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 28,
              child: Image.asset(logoPath),
            ),
          ],
        ),
      ),
    );
  }

}