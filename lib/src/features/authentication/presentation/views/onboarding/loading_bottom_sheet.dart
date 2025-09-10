import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingBottomSheet extends StatefulWidget {
  const LoadingBottomSheet({
    this.title = "We are setting up your account",
    this.caption = "This may take a few minutes...",
    super.key});
  final String title;
  final String caption;

  @override
  State<LoadingBottomSheet> createState() => _LoadingBottomSheetState();
}

class _LoadingBottomSheetState extends State<LoadingBottomSheet> {
  @override
  void initState() {
    super.initState();
    // Auto close after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pop("Done");
        // you can change "AutoClosedValue" to whatever string you want to return
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Cupertino spinner
              CupertinoActivityIndicator(
                radius: 14, // similar size to your design (27px → 14 radius)
                color: Color(0xFF0092FF), // blue color from JSON
              ),
              SizedBox(height: 20),

              // Title
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Creato Display",
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF0A0A0C),
                ),
              ),
              SizedBox(height: 4),

              // Caption
              Text(
                widget.caption,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Creato Display",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF92939E),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}