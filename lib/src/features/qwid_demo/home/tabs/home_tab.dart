import 'package:auto_route/auto_route.dart';
import 'package:qwid/src/components/scaffold/app_scaffold.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qwid/src/features/qwid_demo/home/widgets/card_carousel.dart';
import 'package:qwid/src/features/qwid_demo/home/widgets/exchange_card.dart';
import 'package:qwid/src/features/qwid_demo/home/widgets/select_currency_bottom_sheet.dart';
import 'package:qwid/src/features/qwid_demo/home/widgets/transaction_history_item.dart';
import 'package:qwid/src/router/router.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final ValueNotifier<List<String>> _currencies = ValueNotifier(['NGN', 'USD']);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(52),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(icQwidLogo, width: 100, height: 24),
                Row(
                  children: [
                    SvgPicture.asset(icQwidGift,
                        width: 24, height: 24),
                    SizedBox(width: 12),
                    SvgPicture.asset(icQwidNotification, width: 24, height: 24),
                    SizedBox(width: 12),
                    SvgPicture.asset(icQwidCloud, width: 24, height: 24),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          // Wallets Section
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "My Wallets",
                          style: TextStyle(
                              fontFamily: 'Creato Display',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        InkWell(
                            onTap: () {
                              _openCurrencySelector(context);
                            },
                            child: const Icon(Icons.add, color: Color(0xff0092FF)))
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Wallet PageView
                  ValueListenableBuilder<List<String>>(
                    valueListenable: _currencies,
                    builder: (context, value, child) {
                      final List<Map<String, String>> originalWallets = [
                        {
                          "bank": "NGN Wallet",
                          "country": "NG",
                          "account": "Access Bank • 0123456789",
                          "balance": "1,827,630.41",
                          "image": icQwidCardNGN,
                          "currency": "NGN",
                          "prefix": "₦",
                        },
                        {
                          "bank": "First American Bank",
                          "country": "US",
                          "account": "Access Bank • 9876543210",
                          "balance": "60,040.31",
                          "image": icQwidCardUSD,
                          "currency": "USD",
                          "prefix": "\$",
                        },
                        {
                          "bank": "CIBC",
                          "country": "CA",
                          "account": "Access Bank • 00123-045-1234567",
                          "balance": "40,060.13",
                          "image": icQwidCardCAD,
                          "currency": "CAD",
                          "prefix": "CA\$",
                        },
                      ];
                      final wallets = originalWallets.where((wallet) {
                        return value.contains(wallet['currency']);
                      }).toList();
                      if (wallets.isEmpty) {
                        return SizedBox(
                            width: double.infinity,
                            height: (MediaQuery.of(context).size.width * 333 / 375) * 200 / 333,
                            child: const Center(child: Text('No wallets')));
                      }
                      return WalletCarousel(wallets: wallets);
                    },
                  ),
                  const SizedBox(height: 16),
                  Container(width: double.infinity, height: 8, color: Color(0xffF3F5F7)),
                  const SizedBox(height: 16),
                  // Currency Converter
                  GestureDetector(
                    onTap: () {
                      context.router.push(CurrencyAndRateScreenRoute());
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Currency Converter and Rates",
                              style:
                              TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                  ExchangeCard(),
                  Container(width: double.infinity, height: 8, color: Color(0xffF3F5F7)),
                  // Transaction History
                  GestureDetector(
                    onTap: (){
                      context.router.push(TransactionHistoryScreenRoute());
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Transaction History",
                              style:
                              TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      TransactionHistoryItem(
                        name: 'Bassey Umoh',
                        currency: 'USD',
                        amount: '600',
                        date: '30th May, 08:35',
                        type: TransactionType.payment,
                        currencySymbol: '\$',
                        status: TransactionStatus.success,
                      ),
                      TransactionHistoryItem(
                        name: 'NGN Wallet',
                        currency: 'NGN',
                        amount: '20000',
                        date: '29th May, 08:35',
                        type: TransactionType.deposit,
                        currencySymbol: '₦',
                        status: TransactionStatus.success,
                      ),
                      TransactionHistoryItem(
                        name: 'USD Wallet',
                        currency: 'USD',
                        amount: '600',
                        date: '28th May, 09:00',
                        type: TransactionType.deposit,
                        currencySymbol: '\$',
                        status: TransactionStatus.success,
                      ),
                      TransactionHistoryItem(
                        name: 'NGN to USD',
                        currency: 'USD',
                        amount: '600',
                        date: '29th May, 08:35',
                        type: TransactionType.exchange,
                        currencySymbol: '\$',
                        status: TransactionStatus.success,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _openCurrencySelector(BuildContext context) async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) =>  SelectCurrencyBottomSheet(
        onSelected: (List<String> p1) {
          _currencies.value = List<String>.from(p1);
        },
        list: _currencies.value,
      ),
    );

    if (selected != null) {
      // setState(() {
      //   _countryCode = selected.split(' ')[1];
      //   _flag = selected.split(' ')[0];
      // });
    }
  }
}