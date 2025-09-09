import 'package:country_flags/country_flags.dart';
import 'package:designerwardrobe/src/configs/app_themes/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WalletCarousel extends StatefulWidget {
  const WalletCarousel({super.key, required this.wallets});
  final List<Map<String, String>> wallets;
  @override
  State<WalletCarousel> createState() => _WalletCarouselState();
}

class _WalletCarouselState extends State<WalletCarousel> {
  late final PageController _controller;

  // Tweak these two to taste
  static const double viewportFraction = 0.93; // how wide each card is (<= 1)
  static const double gap = 6;
  int _currentPage = 0;// space between cards

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: viewportFraction);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _controller,
            padEnds: true, // 👈 first/last show only one side
            itemCount: widget.wallets.length,
            itemBuilder: (context, index) {
              final wallet = widget.wallets[index];

              // Equal side gaps for middle pages; only inner gap for edges.
              final left = index == 0 ? 0.0 : gap / 2;
              final right = index == widget.wallets.length - 1 ? 0.0 : gap / 2;

              return Padding(
                padding: EdgeInsets.only(left: left, right: right),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(wallet["image"]!, fit: BoxFit.cover),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.6),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CountryFlag.fromCountryCode(
                                            wallet["country"]!,
                                            width: 20,
                                            height: 14,
                                          ),
                                          Text(' ${wallet["bank"]!}',
                                              style: const TextStyle(
                                                fontFamily: 'Creato Display',
                                                fontSize: 16, color: Colors.white,
                                              )),
                                        ],
                                      ),
                                      SizedBox(height: 4),
                                      Text(wallet["account"]!,
                                          style: const TextStyle(
                                              fontFamily: 'Creato Display',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12, color: Colors.white)),
                                    ],
                                  ),
                                ),
                                SvgPicture.asset(icQwidMenu, width: 24, height: 24),
                              ],
                            ),
                            const Spacer(),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(icQwidBank, width: 16, height: 16),
                                const Text("Wallet Balance",
                                    style: TextStyle(
                                        fontFamily: 'Creato Display',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12, color: Colors.white)),
                              ],
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: wallet["currency"],
                                    style: const TextStyle(
                                        fontFamily: 'Helonik',
                                        fontSize: 36,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  ),
                                  TextSpan(
                                    text: wallet["balance"]!.split('.')[0],
                                    style: const TextStyle(
                                        fontFamily: 'Helonik',
                                        fontSize: 36,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  ),
                                  TextSpan(
                                    text: '.${wallet["balance"]!.split('.')[1]}',
                                    style: const TextStyle(
                                        fontFamily: 'Helonik',
                                        fontSize: 36,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white70),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            onPageChanged: (i) => setState(() => _currentPage = i)
          ),
        ),
        const SizedBox(height: 16),

        // Indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.wallets.length, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == index
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