import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qwid/gen/assets.gen.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:qwid/src/features/qwid_demo/home/widgets/transaction_history_item.dart';
import 'package:qwid/src/router/route_names.dart';

@RoutePage(name: transactionHistoryRoute)
class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  String selected = "All";

  final List<Map<String, dynamic>> transactions = [
    {
      "name": "NGN Wallet",
      "date": "30th May, 08:35",
      "amount": "+\$600",
      "currency": "NGN",
      "status": TransactionStatus.success,
      "type": TransactionType.payment
    },
    {
      "name": "NGN Wallet",
      "date": "30th May, 08:35",
      "amount": "+\$600",
      "status": TransactionStatus.processing,
      "type": TransactionType.payment,
      "currency": "NGN",
    },
    {
      "name": "NGN Wallet",
      "date": "30th May, 08:35",
      "amount": "+\$600",
      "status": TransactionStatus.failed,
      "type": TransactionType.payment,
      "currency": "NGN",
    },
    {
      "name": "USD Wallet",
      "date": "29th May, 08:35",
      "amount": "+\$600",
      "status": TransactionStatus.success,
      "type": TransactionType.deposit,
      "currency": "USD",
    },
    {
      "name": "USD Wallet",
      "date": "29th May, 08:35",
      "amount": "+\$600",
      "status": TransactionStatus.processing,
      "type": TransactionType.deposit,
      "currency": "USD",
    },
    {
      "name": "USD Wallet",
      "date": "29th May, 08:35",
      "amount": "+\$600",
      "status": TransactionStatus.processing,
      "type": TransactionType.deposit,
      "currency": "USD",
    },
    {
      "name": "USD Wallet",
      "date": "29th May, 08:35",
      "amount": "+\$600",
      "status": TransactionStatus.failed,
      "type": TransactionType.deposit,
      "currency": "USD",
    },
    {
      "name": "USD Wallet",
      "date": "29th May, 08:35",
      "amount": "+\$600",
      "status": TransactionStatus.checking,
      "type": TransactionType.deposit,
      "currency": "USD",
    },
    {
      "name": "USD Wallet",
      "date": "29th May, 08:35",
      "amount": "+\$600",
      "status": TransactionStatus.hold,
      "type": TransactionType.deposit,
      "currency": "USD",
    },
  ];

  final filters = ["All", "Transfers", "Deposits", "Withdrawals", "Conversions"];

  @override
  Widget build(BuildContext context) {
    final filtered = selected == "All"
        ? transactions
        : transactions
        .where((tx) => tx["category"] == selected)
        .toList();

    final today = filtered.where((tx) => tx["date"].contains("30th May")).toList();
    final yesterday = filtered.where((tx) => tx["date"].contains("29th May")).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        actions: [
          SvgPicture.asset(icQwidSearchNew, width: 24, height: 24),
          SizedBox(width: 16),
          SvgPicture.asset(icQwidSetting, width: 24, height: 24),
          SizedBox(width: 16),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return const Text(
                    "Transaction History",
                    style: TextStyle(
                      fontFamily: "Creato Display",
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  );
                },
                childCount: 1,
              ),
            ),
          ),
          // Tabs
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: ["All", "Transfers", "Deposits", "Withdrawals", "Conversions"]
                          .map((c) {
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
                        );})
                          .toList(),
                    ),
                  );
                },
                childCount: 1,
              ),
            ),
          ),
          // Today
          if (today.isNotEmpty) SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Text(
                    "Today",
                    style: TextStyle(
                      fontFamily: 'Creato Display',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  );
                },
                childCount: 1,
              ),
            ),
          ),
          if (today.isNotEmpty) _buildSection("Today", today),
          // Yesterday
          if (today.isNotEmpty) SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Text(
                    "Yesterday",
                    style: TextStyle(
                      fontFamily: 'Creato Display',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  );
                },
                childCount: 1,
              ),
            ),
          ),
          if (yesterday.isNotEmpty) _buildSection("Yesterday", yesterday),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Map<String, dynamic>> txs) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
          final tx = txs[index];
          return TransactionHistoryItem(
            name: tx["name"],
            currency: tx["currency"],
            amount: tx["amount"]!,
            date: tx["date"]!,
            type: tx["type"]!,
            currencySymbol: '₦',
            status: tx["status"]! ,
          );
        },
        childCount: txs.length,
      ),
    );
  }

  final chips = ["All", "Transfers", "Deposits", "Withdrawals", "Conversions"];
}