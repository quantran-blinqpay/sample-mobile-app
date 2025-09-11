import 'package:auto_route/annotations.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:qwid/src/features/qwid_demo/home/tabs/accounts_tab.dart';
import 'package:qwid/src/features/qwid_demo/home/tabs/beneficiaries_tab.dart';
import 'package:qwid/src/features/qwid_demo/home/tabs/home_tab.dart';
import 'package:qwid/src/features/qwid_demo/home/tabs/profile_tab.dart';
import 'package:qwid/src/features/qwid_demo/home/tabs/trade_tab.dart';
import 'package:qwid/src/router/route_names.dart';
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
  late final PageController _controller;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: PageView(
            controller: _controller,
            children: [
              HomeTab(),
              BeneficiariesTab(),
              TradeTab(),
              AccountsTab(),
              ProfileTab(),
            ],
            onPageChanged: (i) => setState(() => _currentPage = i)),
      ),

      // Bottom Navigation
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                    color: _currentPage == 0
                        ? const Color(0xff0092FF)
                        : const Color(0xffF3F5F7),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                    color: _currentPage == 1
                        ? const Color(0xff0092FF)
                        : const Color(0xffF3F5F7),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                    color: _currentPage == 2
                        ? const Color(0xff0092FF)
                        : const Color(0xffF3F5F7),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                    color: _currentPage == 3
                        ? const Color(0xff0092FF)
                        : const Color(0xffF3F5F7),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                    color: _currentPage == 4
                        ? const Color(0xff0092FF)
                        : const Color(0xffF3F5F7),
                  ),
                ),
              ),
            ],
          ),
          BottomNavigationBar(
            onTap: (i) => _controller.animateToPage(i,
                duration: const Duration(milliseconds: 250), curve: Curves.easeIn),
            currentIndex: _currentPage,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: const Color(0xff0092FF),
            unselectedItemColor: Colors.grey,
            selectedFontSize: 12.0,
            unselectedFontSize: 12.0,
            items: [
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(icQwidHome,
                      width: 24,
                      height: 24,
                      color: _currentPage == 0
                          ? const Color(0xff0092FF)
                          : Color(0xff92939E)),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: SvgPicture.asset(icQwidBeneficiares,
                        width: 20,
                        height: 20,
                        color: _currentPage == 1
                            ? const Color(0xff0092FF)
                            : Color(0xff92939E)),
                  ),
                  label: "Beneficiaries"),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(icQwidCoin,
                      width: 24,
                      height: 24,
                      color: _currentPage == 2
                          ? const Color(0xff0092FF)
                          : Color(0xff92939E)),
                  label: "Trade"),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(icQwidBank,
                      width: 24,
                      height: 24,
                      color: _currentPage == 3
                          ? const Color(0xff0092FF)
                          : Color(0xff92939E)),
                  label: "Accounts"),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(icQwidProfile,
                      width: 24,
                      height: 24,
                      color: _currentPage == 4
                          ? const Color(0xff0092FF)
                          : Color(0xff92939E)),
                  label: "Profile"),
            ],
          ),
        ],
      ),
    );
  }
}
