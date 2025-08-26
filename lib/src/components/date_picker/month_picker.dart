import 'package:designerwardrobe/src/components/date_picker/custom_cupertino_date_picker.dart';
import 'package:flutter/material.dart';

class MonthPicker extends StatefulWidget {
  final DateTime? selectedDateTime;

  const MonthPicker({
    super.key,
    this.selectedDateTime,
  });

  @override
  State<MonthPicker> createState() => _MonthPickerState();
}

class _MonthPickerState extends State<MonthPicker> {
  final now = DateTime.now();
  DateTime? selectedDateTime;

  @override
  void initState() {
    super.initState();
    if (widget.selectedDateTime != null) {
      selectedDateTime = widget.selectedDateTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFCFD2D8),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: Color(0xFFd8d8d8),
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.pop(context, selectedDateTime);
              },
              child: Text('Done'),
            ),
          ),
          SizedBox(
            height: 200,
            child: CustomCupertinoDatePicker(
              backgroundColor: Color(0xFFCFD2D8),
              mode: CustomCupertinoDatePickerMode.monthYear,
              initialDateTime:
                  widget.selectedDateTime ?? DateTime(now.year, now.month),
              minimumDate: DateTime(1900),
              maximumDate: DateTime(now.year, now.month),
              onDateTimeChanged: (dt) {
                selectedDateTime = dt;
              },
            ),
          ),
        ],
      ),
    );
  }
}
