import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:qwid/src/features/authentication/presentation/views/home/widgets/card_carousel.dart';
import 'package:qwid/src/features/authentication/presentation/views/home/widgets/exchange_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      children: const [
                        Text(
                          "My Wallets",
                          style: TextStyle(
                              fontFamily: 'Creato Display',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        Icon(Icons.add, color: Color(0xff0092FF))
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Wallet PageView
                  WalletCarousel(),

                  const SizedBox(height: 16),
                  Container(width: double.infinity, height: 8, color: Color(0xffF3F5F7)),
                  const SizedBox(height: 16),
                  // Currency Converter
                  Padding(
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
                  ExchangeCard(),
                  Container(width: double.infinity, height: 8, color: Color(0xffF3F5F7)),
                  // Transaction History
                  Padding(
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
                  Column(
                    children: const [
                      ListTile(
                        leading: CircleAvatar(child: Text("BU")),
                        title: Text("Bassey Umoh"),
                        subtitle: Text("30th May, 08:35"),
                        trailing: Text("+\$600",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.green)),
                      ),
                      ListTile(
                        leading: CircleAvatar(child: Text("NG")),
                        title: Text("NGN Wallet"),
                        subtitle: Text("29th May, 08:35"),
                        trailing: Text("+₦20,000",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.green)),
                      ),
                      ListTile(
                        leading: CircleAvatar(child: Text("US")),
                        title: Text("USD Wallet"),
                        subtitle: Text("28th May, 09:00"),
                        trailing: Text("-\$3,000",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.red)),
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
}