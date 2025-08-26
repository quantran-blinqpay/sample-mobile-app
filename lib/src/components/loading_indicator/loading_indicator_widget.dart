import 'package:flutter/material.dart';

class LoadingIndicatorWidget extends StatelessWidget {
  final Color color;

  const LoadingIndicatorWidget({super.key, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          backgroundColor: color,
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
      ),
    );
  }
}
