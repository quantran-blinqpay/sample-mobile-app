import 'package:qwid/src/configs/app_themes/app_colors.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:qwid/src/configs/app_themes/app_styles.dart';
import 'package:flutter/material.dart';

class AddToSavedCard extends StatefulWidget {
  const AddToSavedCard({super.key});

  @override
  State<AddToSavedCard> createState() => _AddToSavedCardState();
}

class _AddToSavedCardState extends State<AddToSavedCard> {

  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return GestureDetector(
      onTap: (){
        setState(() {
          _isSelected = !_isSelected;
        });
      },
      child: Row(
        children: [
          SizedBox(
            width: 22,
            height: 22,
            child: Image.asset(!_isSelected ? icCheckbox: icCheckboxSelected),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Add to my saved cards',
              style: AppStyles.of(context).copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                color: appColors.outerSpace
              ),
            ),
          ),
        ],
      ),
    );
  }
}