import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qwid/src/components/scaffold/app_scaffold.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:qwid/src/router/route_names.dart';

@RoutePage(name: setupPinSuccessRoute)
class SetupPinSuccessScreen extends StatelessWidget {
  const SetupPinSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              icQwidBg,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(32)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(icQwidCheckPNG, width: 64, height: 64),
                        SizedBox(height: 16),
                        Text(
                          "Security PIN Set Up Successful",
                          style: TextStyle(
                            fontFamily: "Creato Display",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff0A0A0C),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Security PIN created. You can now use it to protect your account and transactions.",
                          style: TextStyle(
                            fontFamily: "Creato Display",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff8C909C),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 32),
                        SizedBox(
                          height: 48,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed:  () {
                              context.router.pop();
                              context.router.pop();
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: const Color(0xff0092FF),
                              disabledBackgroundColor: Color(0xFFF4F4F4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            child: Text(
                              'Continue',
                              style: TextStyle(
                                fontFamily: 'Creato Display',
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}