import 'package:designerwardrobe/gen/assets.gen.dart';
import 'package:designerwardrobe/src/components/button/app_button.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_themes.dart';
import 'package:designerwardrobe/src/features/authentication/data/remote/dtos/register/country/local_country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CountryBottomSheet extends StatefulWidget {
  final LocalCountry? initialItem;
  final List<LocalCountry> countries;

  const CountryBottomSheet({
    super.key,
    this.initialItem,
    required this.countries,
  });

  @override
  State<CountryBottomSheet> createState() => _CountryBottomSheetState();
}

class _CountryBottomSheetState extends State<CountryBottomSheet> {
  late AppColors? appColors;
  LocalCountry? selectedItem;

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
              'SELECT COUNTRY',
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
          SafeArea(
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.fromLTRB(
                  22, 0, 22, MediaQuery.of(context).padding.bottom),
              itemCount: widget.countries.length,
              separatorBuilder: (_, __) => Divider(
                color: appColors!.silverSand,
                height: 0.5,
              ),
              itemBuilder: (BuildContext context, int index) {
                return ElevatedAppButton(
                  onPressed: () {
                    setState(() {
                      selectedItem = widget.countries[index];
                    });
                  },
                  height: 41,
                  bgColor: Colors.white,
                  radius: 0,
                  padding: EdgeInsets.zero,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.countries[index].countryName ?? '',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: selectedItem == widget.countries[index]
                                ? FontWeight.w600
                                : FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      if (selectedItem == widget.countries[index])
                        Icon(
                          Icons.check,
                          size: 24,
                          color: Colors.black,
                        )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
