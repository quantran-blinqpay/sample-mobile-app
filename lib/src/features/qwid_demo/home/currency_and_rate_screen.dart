import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qwid/src/components/scaffold/app_scaffold.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:qwid/src/router/route_names.dart';
import 'package:qwid/src/router/router.dart';

@RoutePage(name: currencyAndRateRoute)
class CurrencyAndRateScreen extends StatefulWidget {
  const CurrencyAndRateScreen({super.key});

  @override
  State<CurrencyAndRateScreen> createState() => _CurrencyAndRateScreenState();
}

class _CurrencyAndRateScreenState extends State<CurrencyAndRateScreen> {
  int _seconds = 59;
  Timer? _timer;
  final chips = ["NGN", "USD", "CAD", "EUR", "GBP", "CNY", "TRY"];
  var selected = "NGN";

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel(); // cancel old timer if exists
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        setState(() => _seconds = 59);
      } else {
        setState(() => _seconds--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return AppScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Text(
                "Rates update in ${_seconds}s",
                style: const TextStyle(
                  fontFamily: "Creato Display",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff0092FF),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text(
              "Rates",
              style: TextStyle(
                fontFamily: "Creato Display",
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Get real-time exchange rates and send money at the best price.",
              style: TextStyle(
                fontFamily: "Creato Display",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF92939E),
              ),
            ),
            const SizedBox(height: 16),

            // Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    chips.map((c) {
                      final isSelected = c == selected;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selected = c;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color:
                                isSelected
                                    ? const Color(0xFF0092FF)
                                    : const Color(0xFFFAFAFA),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            c,
                            style: TextStyle(
                              fontFamily: "Creato Display",
                              fontSize: 14,
                              fontWeight:
                                  isSelected ? FontWeight.w500 : FontWeight.w400,
                              color:
                                  isSelected
                                      ? Colors.white
                                      : const Color(0xFF8C909C),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
            const SizedBox(height: 16),

            // Rates list
            Expanded(
              child: ListView.separated(
                itemCount: selected.rates.length,
                separatorBuilder:
                    (_, __) =>
                        const Divider(height: 1, color: Color(0xFFF3F5F7)),
                itemBuilder: (context, index) {
                  final item = selected.rates[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CountryFlag.fromCurrencyCode(
                                  item["from"]!,
                                  width: 20,
                                  height: 14,
                                  shape: Rectangle(),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  item["from"]!,
                                  style: const TextStyle(
                                    fontFamily: "Creato Display",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                SvgPicture.asset(
                                  icQwidRate,
                                  width: 16,
                                  height: 16,
                                ),
                                const SizedBox(width: 8),
                                CountryFlag.fromCurrencyCode(
                                  item["to"]!,
                                  width: 20,
                                  height: 14,
                                  shape: Rectangle(),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  item["to"]!,
                                  style: const TextStyle(
                                    fontFamily: "Creato Display",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item["rate"]!,
                              style: const TextStyle(
                                fontFamily: "Arial",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF92939E),
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            context.router.push(const BeneficiariesScreenRoute());
                          },
                          child: Container(
                            height: 34,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF4F4F4),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.north_east,
                                  size: 14,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  "Send",
                                  style: TextStyle(
                                    fontFamily: "Creato Display",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension StringEx on String {
  List<Map<String, dynamic>> get rates {
    switch (this) {
      case "NGN":
        return [
          {"from": "NGN", "to": "USD", "rate": "₦1 = \$0.00082"},
          {"from": "NGN", "to": "CAD", "rate": "₦1 = CA\$0.0011"},
          {"from": "NGN", "to": "EUR", "rate": "₦1 = €0.00076"},
          {"from": "NGN", "to": "GBP", "rate": "₦1 = £0.00065"},
          {"from": "NGN", "to": "CNY", "rate": "₦1 = ¥0.0051"},
          {"from": "NGN", "to": "TRY", "rate": "₦1 = ₺0.026"},
          {"from": "NGN", "to": "MXN", "rate": "₦1 = Mex\$0.014"},
          {"from": "NGN", "to": "AED", "rate": "₦1 = AED 0.003"},
        ];
      case "USD":
        return [
          {"from": "USD", "to": "NGN", "rate": "\$1 = ₦1,219.51"},
          {"from": "USD", "to": "CAD", "rate": "\$1 = CA\$1.36"},
          {"from": "USD", "to": "EUR", "rate": "\$1 = €0.88"},
          {"from": "USD", "to": "GBP", "rate": "\$1 = £0.75"},
          {"from": "USD", "to": "CNY", "rate": "\$1 = ¥7.21"},
          {"from": "USD", "to": "TRY", "rate": "\$1 = ₺32.21"},
          {"from": "USD", "to": "MXN", "rate": "\$1 = Mex\$17.74"},
          {"from": "USD", "to": "AED", "rate": "\$1 = AED 3.67"},
        ];
      case "CAD":
        return [
          {"from": "CAD", "to": "NGN", "rate": "CA\$1 = ₦909.09"},
          {"from": "CAD", "to": "USD", "rate": "CA\$1 = \$0.74"},
          {"from": "CAD", "to": "EUR", "rate": "CA\$1 = €0.65"},
          {"from": "CAD", "to": "GBP", "rate": "CA\$1 = £0.55"},
          {"from": "CAD", "to": "CNY", "rate": "CA\$1 = ¥5.30"},
          {"from": "CAD", "to": "TRY", "rate": "CA\$1 = ₺23.68"},
          {"from": "CAD", "to": "MXN", "rate": "CA\$1 = Mex\$13.04"},
          {"from": "CAD", "to": "AED", "rate": "CA\$1 = AED 2.70"},
        ];
      case "EUR":
        return [
          {"from": "EUR", "to": "NGN", "rate": "€1 = ₦1,315.79"},
          {"from": "EUR", "to": "USD", "rate": "€1 = \$1.13"},
          {"from": "EUR", "to": "CAD", "rate": "€1 = CA\$1.54"},
          {"from": "EUR", "to": "GBP", "rate": "€1 = £0.85"},
          {"from": "EUR", "to": "CNY", "rate": "€1 = ¥8.20"},
          {"from": "EUR", "to": "TRY", "rate": "€1 = ₺36.65"},
          {"from": "EUR", "to": "MXN", "rate": "€1 = Mex\$19.74"},
          {"from": "EUR", "to": "AED", "rate": "€1 = AED 4.15"},
        ];
      case "GBP":
        return [
          {"from": "GBP", "to": "NGN", "rate": "£1 = ₦1,538.46"},
          {"from": "GBP", "to": "USD", "rate": "£1 = \$1.33"},
          {"from": "GBP", "to": "CAD", "rate": "£1 = CA\$1.82"},
          {"from": "GBP", "to": "EUR", "rate": "£1 = €1.18"},
          {"from": "GBP", "to": "CNY", "rate": "£1 = ¥9.65"},
          {"from": "GBP", "to": "TRY", "rate": "£1 = ₺43.12"},
          {"from": "GBP", "to": "MXN", "rate": "£1 = Mex\$23.23"},
          {"from": "GBP", "to": "AED", "rate": "£1 = AED 4.89"},
        ];
      case "CNY":
        return [
          {"from": "CNY", "to": "NGN", "rate": "¥1 = ₦196.08"},
          {"from": "CNY", "to": "USD", "rate": "¥1 = \$0.14"},
          {"from": "CNY", "to": "CAD", "rate": "¥1 = CA\$0.19"},
          {"from": "CNY", "to": "EUR", "rate": "¥1 = €0.12"},
          {"from": "CNY", "to": "GBP", "rate": "¥1 = £0.10"},
          {"from": "CNY", "to": "TRY", "rate": "¥1 = ₺4.47"},
          {"from": "CNY", "to": "MXN", "rate": "¥1 = Mex\$2.41"},
          {"from": "CNY", "to": "AED", "rate": "¥1 = AED 0.51"},
        ];
      case "TRY":
        return [
          {"from": "TRY", "to": "NGN", "rate": "₺1 = ₦38.46"},
          {"from": "TRY", "to": "USD", "rate": "₺1 = \$0.031"},
          {"from": "TRY", "to": "CAD", "rate": "₺1 = CA\$0.042"},
          {"from": "TRY", "to": "EUR", "rate": "₺1 = €0.027"},
          {"from": "TRY", "to": "GBP", "rate": "₺1 = £0.023"},
          {"from": "TRY", "to": "CNY", "rate": "₺1 = ¥0.22"},
          {"from": "TRY", "to": "MXN", "rate": "₺1 = Mex\$0.54"},
          {"from": "TRY", "to": "AED", "rate": "₺1 = AED 0.11"},
        ];
      default:
        return [];
    }
  }
}
