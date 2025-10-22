import 'package:auto_route/annotations.dart';
import 'package:qwid/src/components/scaffold/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:qwid/src/router/route_names.dart';

@RoutePage(name: bankTransferRoute)
class BankTransferScreen extends StatefulWidget {
  const BankTransferScreen({super.key});

  @override
  State<BankTransferScreen> createState() => _BankTransferScreenState();
}

class _BankTransferScreenState extends State<BankTransferScreen> {
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
              "Bank Transfer",
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
              "Send a transfer to the account details below, and your wallet will be topped up instantly.",
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
              title: "Bank transfer",
              subtitle: "Access Bank",
              onTap: () {
                // Get.toNamed(AppRoutes.createPersonalAccountRoute);
              },
              showBadge: false,
            ),
            _accountItem(
              context,
              title: "Account Number",
              subtitle:
                  "0123456789",
              onTap: () {
                // Get.toNamed(AppRoutes.convertFundsRoute);
              },
              showBadge: true,
            ),
            _accountItem(
              context,
              title: "Beneficiary Name",
              subtitle: "BLINQPAY LTD-Q DAPHNE MARTINS 100",
              onTap: () {
                // Get.toNamed(AppRoutes.createBusinessAccount);
              },
              showBadge: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _accountItem(
    BuildContext context, {
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
            Expanded(
              child: Row(
                children: [
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
                  !showBadge
                      ? SizedBox.shrink()
                      : GestureDetector(
                        onTap: () {
                          if (_isCopied) return;
                          setState(() {
                            _isCopied = true;
                          });
                          showCopiedSnackBar(context);
                        },
                        child: DecoratedBox(
                                            decoration: BoxDecoration(
                        color: _isCopied ? Color(0xff0092FF) :Color(0xffF4F4F4),
                        borderRadius: BorderRadius.circular(100),
                                            ),
                                            child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 8.0,
                        ),
                        child: Text(
                          _isCopied ? "Copied" : "Copy",
                          style: TextStyle(
                            fontFamily: "Creato Display",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: _isCopied ? Colors.white : Color(0xff0A0A0C),
                          ),
                        ),
                                            ),
                                          ),
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isCopied = false;

  void showCopiedSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  "Account number copied",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      duration: const Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
