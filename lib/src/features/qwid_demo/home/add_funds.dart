import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:qwid/src/components/scaffold/app_scaffold.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:qwid/src/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qwid/src/router/router.dart';

@RoutePage(name: addFundsRoute)
class AddFundsScreen extends StatelessWidget {
  const AddFundsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              "Add Funds",
              style: const TextStyle(
                fontFamily: "Creato Display",
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: Color(0xFF0A0A0C), // rgb(10,10,12)
              ),
            ),
            const SizedBox(height: 4),

            // Subtitle
            Text(
              "How would you like to fund your wallet?",
              style: const TextStyle(
                fontFamily: "Creato Display",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF92939E), // rgb(146,147,158)
              ),
            ),
            const SizedBox(height: 24),

            // List
            _accountItem(
              context,
              icon: icQwidBank,
              title: "Bank transfer",
              subtitle: "Transfer funds from your local bank to your Qwid virtual naira account.",
              onTap: () {
                context.router.push(const BankTransferScreenRoute());
              },
              showBadge: false,
            ),
            _accountItem(
              context,
              icon: icQwidExchange,
              title: "Convert Funds",
              subtitle:
                  "Fund your wallet by moving funds from any of your other wallets ",
              onTap: () {
                context.router.push(const ConvertFundsScreenRoute());
              },
              showBadge: false,
            ),
            _accountItem(
              context,
              icon: icQwidBank,
              title: "Other Methods",
              subtitle: "Top up your wallet using your card or mobile money.",
              onTap: () {
                // Get.toNamed(AppRoutes.createBusinessAccount);
              },
              showBadge: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _accountItem(
    BuildContext context, {
    required String icon,
    required String title,
    required String subtitle,
    required bool showBadge,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFFF3F5F7), width: 1),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              icon,
              width: 24,
              height: 24,
              color: Color(0xFF92939E),
            ),
            Expanded(
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                fontFamily: "Creato Display",
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF0A0A0C),
                              ),
                            ),
                            SizedBox(width: 8),
                            !showBadge
                                ? SizedBox.shrink()
                                : DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Color(0xffFFFAEB),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 4,
                                    ),
                                    child: Text(
                                      "unavailable",
                                      style: TextStyle(
                                        fontFamily: "Creato Display",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xffFFBF00),
                                      ),
                                    ),
                                  ),
                                ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            fontFamily: "Creato Display",
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF92939E),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Color(0xFF92939E),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
