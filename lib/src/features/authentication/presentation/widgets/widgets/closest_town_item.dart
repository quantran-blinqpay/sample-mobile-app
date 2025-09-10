import 'package:qwid/src/components/button/app_button.dart';
import 'package:qwid/src/configs/app_themes/app_colors.dart';
import 'package:qwid/src/configs/app_themes/app_styles.dart';
import 'package:qwid/src/features/authentication/data/remote/dtos/register/country/closest_town.dart';
import 'package:flutter/material.dart';

class ClosestTownItem extends StatefulWidget {
  const ClosestTownItem({this.selectedItem, required this.onTap, required this.item, this.isAustralia, super.key});
  final ClosestTown item;
  final Function(String?) onTap;
  final String? selectedItem;
  final bool? isAustralia;

  @override
  State<ClosestTownItem> createState() => _ClosestTownItemState();
}

class _ClosestTownItemState extends State<ClosestTownItem> {
  bool _isCollapsed = true;

  @override
  void initState() {
    super.initState();
    // Aus
    if(widget.isAustralia ?? false) {
      _isCollapsed = false;
    }
    if(widget.item.towns?.contains(widget.selectedItem) == true){
      _isCollapsed = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>();
    return SliverList.separated(
      itemCount: widget.item.towns?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (index == 0 && !(widget.isAustralia ?? true))? Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isCollapsed = !_isCollapsed;
                  });
                },
                child: ColoredBox(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.item.groupName ?? '',
                        style: AppStyles.of(context).copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Divider(
                        color: appColors!.silverSand,
                        height: 0.5,
                      )
                    ],
                  ),
                ),
              ),
            ) : const SizedBox.shrink(),
            _isCollapsed ? SizedBox.shrink(): _buildItem(index),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return _isCollapsed ? SizedBox.shrink(): Divider(
          color: appColors!.silverSand,
          height: 0.5,
        );
      },
    );
  }

  Widget _buildItem(int index){
    return ElevatedAppButton(
      onPressed: () {
        widget.onTap.call(widget.item.towns?[index]);
        // setState(() {
        //   selectedItem = items.towns?[index];
        // });
      },
      height: 41,
      bgColor: Colors.white,
      radius: 0,
      padding: EdgeInsets.zero,
      child: Row(
        children: [
          SizedBox(width: 10),
          Expanded(
            child: Text(
              widget.item.towns?[index] ?? '',
              style: AppStyles.of(context).copyWith(
                fontSize: 14,
                fontWeight: widget.selectedItem == widget.item.towns?[index]
                    ? FontWeight.w600
                    : FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
          if (widget.selectedItem == widget.item.towns?[index])
            Icon(
              Icons.check,
              size: 24,
              color: Colors.black,
            )
        ],
      ),
    );
  }
}