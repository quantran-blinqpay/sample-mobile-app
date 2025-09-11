import 'package:country_flags/country_flags.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qwid/src/features/qwid_demo/home/widgets/account_detail_bottom_sheet.dart';

class AccountCarousel extends StatefulWidget {
  const AccountCarousel({super.key, required this.onPageChanged});
  final Function(int) onPageChanged;
  @override
  State<AccountCarousel> createState() => _AccountCarouselState();
}

class _AccountCarouselState extends State<AccountCarousel> {
  late final PageController _controller;

  // Tweak these two to taste
  static const double viewportFraction = 0.75; // how wide each card is (<= 1)
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
            padEnds: false, // 👈 first/last show only one side
            itemCount: wallets.length,
            itemBuilder: (context, index) {
              final wallet = wallets[index];

              // Equal side gaps for middle pages; only inner gap for edges.
              final left = index == 0 ? gap * 2 : gap / 2;
              final right = index == wallets.length - 1 ? gap * 2 : gap / 2;

              return SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 200,
                child: Padding(
                  padding: EdgeInsets.only(left: left, right: right),
                  child: index == 1
                      ? _buildPendingCard(wallet)
                      : _buildNormalCard(wallet),
                ),
              );
            },
            onPageChanged: (i) {
              widget.onPageChanged.call(i);
              setState(() => _currentPage = i);
            }
          ),
        ),
        const SizedBox(height: 16),

        // Indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(wallets.length, (index) {
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

  Widget _buildNormalCard(Map<String, String> wallet){
    return GestureDetector(
      onTap: () => _openAccountDetail(context),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Image.network(wallet["image"]!, fit: BoxFit.cover),
            DecoratedBox(decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1),
              gradient: LinearGradient(
                colors: [
                  Color(0xff4D4D4D),
                  Colors.black,
                ],
              ),
            ),
            ),
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
                      const Text("Balance",
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
  }

  Widget _buildPendingCard(Map<String, String> wallet){
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Image.network(wallet["image"]!, fit: BoxFit.cover),
          DecoratedBox(decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1),
            gradient: LinearGradient(
              colors: [
                Color(0xff4D4D4D),
                Colors.black,
              ],
            ),
          ),
          ),
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
                    SvgPicture.asset(icQwidPending, width: 20, height: 20),
                    SizedBox(width: 8),
                    const Text("Your request is pending",
                        style: TextStyle(
                            fontFamily: 'Creato Display',
                            fontWeight: FontWeight.w500,
                            fontSize: 14, color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openAccountDetail(BuildContext context) async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const AccountDetailBottomSheet(),
    );

    if (selected != null) {
      // _countryController.text = selected;
      // context.router.push(PersonalInformationScreenRoute());
    }
  }

}

final List<Map<String, String>> wallets = [
  {
    "bank": "NGN",
    "country": "NG",
    "account": "Access Bank • 0123456789",
    "balance": "1,827,630.41",
    "image": "https://t4.ftcdn.net/jpg/03/79/96/25/360_F_379962515_j4dQNtf6gp1WyS4Jo2LTZ8KXe85ncZWC.jpg",
    "currency": "₦",
  },
  {
    "bank": "USD",
    "country": "US",
    "account": "First American Bank • 9876543210",
    "balance": "60,040.31",
    "image": "https://images.squarespace-cdn.com/content/v1/62015f66f840ef671da14ae7/1aa35437-4cd2-4e39-aabc-2df68baac830/NYC-skyline-033.JPG",
    "currency": "\$",
  },
  {
    "bank": "GBP",
    "country": "GB",
    "account": "Barclays Bank • 00123-045-1234567",
    "balance": "40,060.13",
    "image": "https://images.fineartamerica.com/images/artworkimages/mediumlarge/2/landscape-of-city-vancouver-in-canada-deejpilot.jpg",
    "currency": "GBP",
  },
];