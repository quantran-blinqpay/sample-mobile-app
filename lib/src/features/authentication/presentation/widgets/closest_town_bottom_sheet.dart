import 'package:qwid/gen/assets.gen.dart';
import 'package:qwid/src/components/button/app_button.dart';
import 'package:qwid/src/configs/app_themes/app_colors.dart';
import 'package:qwid/src/configs/app_themes/app_styles.dart';
import 'package:qwid/src/features/authentication/data/remote/dtos/register/country/closest_town.dart';
import 'package:qwid/src/features/authentication/data/remote/dtos/register/country/local_country.dart';
import 'package:qwid/src/features/authentication/presentation/widgets/widgets/closest_town_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ClosestTownBottomSheet extends StatefulWidget {
  final String? initialItem;
  final List<ClosestTown> closestTowns;

  const ClosestTownBottomSheet({
    super.key,
    this.initialItem,
    required this.closestTowns,
  });

  @override
  State<ClosestTownBottomSheet> createState() => _ClosestTownBottomSheetState();
}

class _ClosestTownBottomSheetState extends State<ClosestTownBottomSheet> {
  late AppColors? appColors;
  String? selectedItem;

  @override
  void initState() {
    super.initState();
    if (widget.initialItem != null) {
      selectedItem = widget.initialItem;
    }
  }

  @override
  Widget build(BuildContext context) {
    appColors = Theme.of(context).extension<AppColors>();

    return ColoredBox(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              padding: EdgeInsets.all(5),
              icon: SvgPicture.asset(
                Assets.svgs.icClose,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              'SELECT CLOSEST TOWN',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(selectedItem);
                },
                child: Text('Done'),
              ),
            ],
          ),
          Flexible(
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    22, 0, 22, MediaQuery.of(context).padding.bottom),
                child: CustomScrollView(
                  shrinkWrap: true,
                  slivers: widget.closestTowns.map((e) => _buildListItems(e)).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          padding: EdgeInsets.all(5),
          icon: SvgPicture.asset(
            Assets.svgs.icClose,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'SELECT CLOSEST TOWN',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(selectedItem);
            },
            child: Text('Done'),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
            22, 0, 22, MediaQuery.of(context).padding.bottom),
        child: CustomScrollView(
          slivers: widget.closestTowns.map((e) => _buildListItems(e)).toList(),
        ),
      ),
    );
  }

  Widget _buildListItems(ClosestTown items) {
    return ClosestTownItem(
      onTap: (text) {
        setState(() {
          selectedItem = text;
        });
      },
      selectedItem: selectedItem,
      item: items,
      isAustralia: widget.closestTowns.first.groupName?.isEmpty,
    );
  }
}
