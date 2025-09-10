import 'package:auto_route/auto_route.dart';
import 'package:qwid/src/components/scaffold/app_scaffold.dart';
import 'package:qwid/src/configs/app_themes/app_colors.dart';
import 'package:qwid/src/configs/app_themes/app_styles.dart';
import 'package:qwid/src/router/route_names.dart';
import 'package:flutter/material.dart';

@RoutePage(name: sellerScreenName)
class SellerScreen extends StatelessWidget {
  SellerScreen({super.key});

  final List<Map<String, dynamic>> items = [
    {
      'image':
      'https://image-cdn.hypb.st/https%3A%2F%2Fhypebeast.com%2Fimage%2F2021%2F03%2Flouis-vuitton-mens-spring-summer-capsule-collection-first-launch-2021-release-006.jpg?q=75&w=800&cbr=1&fit=max', // Replace with actual image URL
      'title': "Men's Lightweight Synchilla® Snap-T® Pullover",
      'price': 95,
      'buyer': 'Beth R',
    },
    {
      'image':
      'https://image-cdn.hypb.st/https%3A%2F%2Fhypebeast.com%2Fimage%2F2021%2F03%2Flouis-vuitton-mens-spring-summer-capsule-collection-first-launch-2021-release-002.jpg?q=75&w=800&cbr=1&fit=max', // Replace with actual image URL
      'title': "Men's Lightweight Synchilla® Snap-T® Pullover",
      'price': 150,
      'buyer': 'Sara J',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return AppScaffold(
      appBar: AppBar(
        toolbarHeight: 48,
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            'SALES',
            style: AppStyles.of(context).copyWith(
              color: Colors.black,
              fontSize: 18,
              height: 13 / 14,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: SizedBox(
              width: 30,
              height: 30,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      item['image'],
                      width: 110,
                      height: 110,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Patagonia",
                            style: AppStyles.of(context).copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            item['title'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyles.of(context).copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                  "NZD \$${item['price']} ",
                                  style: AppStyles.of(context).copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: appColors.outerSpace,
                                  ),
                                ),
                                TextSpan(
                                  text: '(total incl shipping)',
                                  style: AppStyles.of(context).copyWith(
                                    fontSize: 11,
                                    fontWeight: FontWeight.normal,
                                    color: appColors.outerSpace,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                  "Buyer: ",
                                  style: AppStyles.of(context).copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: appColors.outerSpace,
                                  ),
                                ),
                                TextSpan(
                                  text: ' ${item['buyer']} ',
                                  style: AppStyles.of(context).copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: appColors.outerSpace,
                                  ),
                                ),
                                TextSpan(
                                  text: '(New Zealand)',
                                  style: AppStyles.of(context).copyWith(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                    color: appColors.outerSpace,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "SALE COMPLETE",
                            style: AppStyles.of(context).copyWith(
                              fontSize: 14,
                              color: Colors.green,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                        color: Colors.black, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text(
                    "List Similar Item",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            );
          },
        ),
      ),
    );
  }
}
