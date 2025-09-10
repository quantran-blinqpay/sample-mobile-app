import 'package:qwid/src/configs/app_themes/app_styles.dart';
import 'package:flutter/material.dart';

class FeedbackView extends StatelessWidget {
  const FeedbackView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: 15),
        Text(
          "No Feedback Received",
          style: AppStyles.of(context).copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildFeedbackItem(
              context: context,
              icon: Icons.sentiment_satisfied,
              color: Colors.green,
              count: 0,
              label: "positive",
            ),
            SizedBox(width: 40),
            buildFeedbackItem(
              context: context,
              icon: Icons.sentiment_neutral,
              color: Colors.orange,
              count: 0,
              label: "neutral",
            ),
            SizedBox(width: 40),
            buildFeedbackItem(
              context: context,
              icon: Icons.sentiment_dissatisfied,
              color: Colors.red,
              count: 0,
              label: "negative",
            ),
          ],
        ),
      ],
    );
  }

  Widget buildFeedbackItem({
    required BuildContext context,
    required IconData icon,
    required Color color,
    required int count,
    required String label,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 50,
        ),
        SizedBox(height: 5),
        Text(
          "$count $label",
          style: AppStyles.of(context).copyWith(
            fontSize: 16,
            color: Colors.black87,
            fontWeight: FontWeight.w400
          ),
        ),
      ],
    );
  }

}