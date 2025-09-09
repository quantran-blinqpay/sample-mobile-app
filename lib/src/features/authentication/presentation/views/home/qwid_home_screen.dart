import 'package:auto_route/annotations.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_images.dart';
import 'package:designerwardrobe/src/features/authentication/presentation/views/home/widgets/card_carousel.dart';
import 'package:designerwardrobe/src/features/authentication/presentation/views/home/widgets/exchange_card.dart';
import 'package:designerwardrobe/src/router/route_names.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage(name: qwidHomeRoute)
class QwidHomeScreen extends StatefulWidget {
  const QwidHomeScreen({super.key});

  @override
  State<QwidHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<QwidHomeScreen> {
  final List<Map<String, String>> wallets = [
    {
      "bank": "NGN Wallet",
      "country": "NG",
      "account": "Access Bank • 0123456789",
      "balance": "1,827,630.41",
      "image": "https://t4.ftcdn.net/jpg/03/79/96/25/360_F_379962515_j4dQNtf6gp1WyS4Jo2LTZ8KXe85ncZWC.jpg",
      "currency": "₦",
    },
    {
      "bank": "First American Bank",
      "country": "US",
      "account": "Access Bank • 9876543210",
      "balance": "60,040.31",
      "image": "https://images.squarespace-cdn.com/content/v1/62015f66f840ef671da14ae7/1aa35437-4cd2-4e39-aabc-2df68baac830/NYC-skyline-033.JPG",
      "currency": "\$",
    },
    {
      "bank": "CIBC",
      "country": "CA",
      "account": "Access Bank • 00123-045-1234567",
      "balance": "40,060.13",
      "image": "https://images.fineartamerica.com/images/artworkimages/mediumlarge/2/landscape-of-city-vancouver-in-canada-deejpilot.jpg",
      "currency": "CA\$",
    },
  ];

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
                    SvgPicture.asset(icQwidGift, width: 24, height: 24, color: Colors.black),
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
      body: SafeArea(
        child: Column(
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
                    WalletCarousel(wallets: wallets),

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
      ),

      // Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xff0092FF),
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: SvgPicture.asset(icQwidHome), label: "Home"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(icQwidBeneficiares), label: "Beneficiaries"),
          BottomNavigationBarItem(icon: SvgPicture.asset(icQwidCoin), label: "Trade"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(icQwidBuilding), label: "Accounts"),
          BottomNavigationBarItem(icon: SvgPicture.asset(icQwidProfile), label: "Profile"),
        ],
      ),
    );
  }
}