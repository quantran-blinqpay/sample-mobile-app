import 'package:country_flags/country_flags.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExchangeCard extends StatelessWidget {
  const ExchangeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Color(0xffF3F5F7),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildExchangeRate(),
          Container(width: double.infinity,
              height: 8,
              color: Color(0xffF3F5F7)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Exchange rate",
                  style: TextStyle(
                      fontFamily: 'Creato Display',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey),
                ),
                Text("\$1 = ₦0.000624",
                  style: TextStyle(
                      fontFamily: 'Creato Display',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExchangeRate() {
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade300)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Amount", style: TextStyle(
                                fontFamily: 'Creato Display',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff92939E))),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '₦',
                                    style: const TextStyle(
                                        fontFamily: 'Helonik',
                                        fontSize: 24,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: '0',
                                    style: const TextStyle(
                                        fontFamily: 'Helonik',
                                        fontSize: 24,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff92939E)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CountryFlag.fromCountryCode(
                            "NG",
                            width: 20,
                            height: 14,
                          ),
                          Text(" NGN",
                              style: TextStyle(
                                  fontFamily: 'Creato Display',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff1D1D20))),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: SvgPicture.asset(icQwidArrowDown, width: 24,
                                height: 24,
                                color: Color(0xFF92939E)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(width: double.infinity, height: 4, color: Color(0xffF3F5F7)),
            DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade300)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("You get",
                                style: TextStyle(
                                    fontFamily: 'Creato Display',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff92939E))),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '\$',
                                    style: const TextStyle(
                                        fontFamily: 'Helonik',
                                        fontSize: 24,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: '0',
                                    style: const TextStyle(
                                        fontFamily: 'Helonik',
                                        fontSize: 24,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff92939E)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CountryFlag.fromCountryCode(
                            "US",
                            width: 20,
                            height: 14,
                          ),
                          Text(" USD",
                              style: TextStyle(
                                  fontFamily: 'Creato Display',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff1D1D20))),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: SvgPicture.asset(icQwidArrowDown, width: 24,
                                height: 24,
                                color: Color(0xFF92939E)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Color(0xffF3F5F7), width: 2)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SvgPicture.asset(icQwidExchange, width: 20, height: 20),
              ),
            ),
          ),
        )
      ],
    );
  }
}