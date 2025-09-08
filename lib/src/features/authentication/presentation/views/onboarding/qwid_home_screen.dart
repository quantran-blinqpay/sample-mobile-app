import 'package:auto_route/annotations.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_images.dart';
import 'package:designerwardrobe/src/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage(name: qwidHomeRoute)
class QwidHomeScreen extends StatefulWidget {
  const QwidHomeScreen({super.key});

  @override
  State<QwidHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<QwidHomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> wallets = [
    {
      "bank": "Access Bank",
      "account": "0123456789",
      "balance": "₦1,827,630.41",
      "image": "https://picsum.photos/400/200?random=1"
    },
    {
      "bank": "First American Bank",
      "account": "9876543210",
      "balance": "\$60,040.31",
      "image": "https://picsum.photos/400/200?random=2"
    },
    {
      "bank": "CIBC",
      "account": "00123-045-1234567",
      "balance": "CA\$40,060.13",
      "image": "https://picsum.photos/400/200?random=3"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Nav Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "qwid",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0092FF),
                    ),
                  ),
                  Row(
                    children: const [
                      Icon(Icons.card_giftcard, size: 24, color: Colors.black),
                      SizedBox(width: 12),
                      Icon(Icons.notifications_none,
                          size: 24, color: Colors.black),
                      SizedBox(width: 12),
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Icon(Icons.chat_bubble_outline,
                              size: 24, color: Colors.black),
                          CircleAvatar(
                            radius: 7,
                            backgroundColor: Colors.red,
                            child: Text(
                              "2",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),

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
                    SizedBox(
                      height: 200,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: wallets.length,
                        onPageChanged: (i) => setState(() => _currentPage = i),
                        itemBuilder: (context, index) {
                          final wallet = wallets[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                image: NetworkImage(wallet["image"]!),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.black.withOpacity(0.6),
                                    Colors.transparent
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(wallet["bank"]!,
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.white)),
                                  Text(wallet["account"]!,
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.white70)),
                                  const Spacer(),
                                  const Text("Wallet Balance",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white70)),
                                  Text(wallet["balance"]!,
                                      style: const TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Indicators
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(wallets.length, (index) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _currentPage == index ? 8 : 6,
                          height: _currentPage == index ? 8 : 6,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentPage == index
                                ? const Color(0xff0092FF)
                                : const Color(0xffE1E5EA),
                          ),
                        );
                      }),
                    ),

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
                    Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey.shade300)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Amount", style: TextStyle(color: Colors.grey)),
                          SizedBox(height: 4),
                          Text("₦0", style: TextStyle(fontSize: 24)),
                          Divider(),
                          Text("You get", style: TextStyle(color: Colors.grey)),
                          SizedBox(height: 4),
                          Text("\$0", style: TextStyle(fontSize: 24)),
                          Divider(),
                          Text("Exchange rate: \$1 = ₦0.000624",
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),

                    // Transaction History
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
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