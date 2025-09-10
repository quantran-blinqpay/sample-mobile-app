import 'package:auto_route/annotations.dart';
import 'package:designerwardrobe/src/router/route_names.dart';
import 'package:flutter/material.dart';

class WalletCarouselScreen extends StatefulWidget {
  const WalletCarouselScreen({super.key});

  @override
  State<WalletCarouselScreen> createState() => _WalletCarouselState();
}

class _WalletCarouselState extends State<WalletCarouselScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> wallets = [
    {
      "bank": "Access Bank",
      "account": "0123456789",
      "balance": "₦1,827,630.41",
      "image": "https://picsum.photos/400/200?random=1"
    },
    {
      "bank": "First American Bank",
      "account": "0123456789",
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
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _pageController,
            itemCount: wallets.length,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
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
                      colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        wallet["bank"]!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        wallet["account"]!,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        "Wallet Balance",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70,
                        ),
                      ),
                      Text(
                        wallet["balance"]!,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),

        // Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(wallets.length, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index
                    ? const Color(0xff0092FF)
                    : const Color(0xffE1E5EA),
              ),
            );
          }),
        ),
      ],
    );
  }
}