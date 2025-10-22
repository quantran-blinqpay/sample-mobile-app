import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/cupertino.dart';
import 'package:qwid/src/components/scaffold/app_scaffold.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:qwid/src/features/qwid_demo/home/widgets/select_wallet_bottom_sheet.dart';
import 'package:qwid/src/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage(name: convertFundsRoute)
class ConvertFundsScreen extends StatefulWidget {
  const ConvertFundsScreen({super.key});

  @override
  State<ConvertFundsScreen> createState() => _ConvertFundsScreenState();
}

enum TextFieldStatus { notValidated, valid, invalid }

class _ConvertFundsScreenState extends State<ConvertFundsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _sendFromController = TextEditingController();
  final _receivingWalletController = TextEditingController();
  final _amountController = TextEditingController();

  bool _isSendFromEmpty = true;
  bool _isReceivingWalletEmpty = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _sendFromController.addListener(() {
      setState(() {
        _isSendFromEmpty = _sendFromController.text.isEmpty;
      });
    });

    _receivingWalletController.addListener(() {
      setState(() {
        _isReceivingWalletEmpty = _receivingWalletController.text.isEmpty;
      });
    });
    _amountController.addListener(() {
      setState(() {});
    });
  }

  bool get isFormValid {
    return !_isSendFromEmpty
        && ! _isReceivingWalletEmpty
        && _amountController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                "Convert Funds",
                style: const TextStyle(
                  fontFamily: "Creato Display",
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF0A0A0C),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Please fill in your information correctly.",
                style: const TextStyle(
                  fontFamily: "Creato Display",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF92939E),
                ),
              ),
              const SizedBox(height: 24),

              // Country Dropdown
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sendFromController.text.isEmpty
                      ? SizedBox.shrink()
                      : Text(
                        "Wallet to Send from",
                        style: const TextStyle(
                          fontFamily: "Creato Display",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF92939E),
                        ),
                      ),
                  TextFormField(
                    controller: _sendFromController,
                    readOnly: true,
                    cursorColor: Color(0xff0092FF),
                    onTap: () {
                      _openSendFromSelector(context);
                    },
                    decoration: InputDecoration(
                      hintText: "Wallet to Send from",
                      // 👈 shown inside until typing
                      border: OutlineInputBorder(),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgPicture.asset(
                          icQwidArrowDown,
                          width: 24,
                          height: 24,
                          color: Color(0xFF92939E),
                        ),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffF3F5F7),
                          width: 0.5,
                        ), // custom color & thickness
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff0092FF),
                          width: 1,
                        ),
                      ),
                      prefixIcon:
                          _sendFromController.text.isEmpty
                              ? null
                              : Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CountryFlag.fromCurrencyCode(
                                    _sendFromController.text.isEmpty
                                        ? "NGN"
                                        : _sendFromController.text,
                                    width: 24,
                                    height: 15,
                                    shape: Rectangle(),
                                  ),
                                  SizedBox(height: 8),
                                ],
                              ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _receivingWalletController.text.isEmpty
                      ? SizedBox.shrink()
                      : Text(
                        "Receiving Wallet",
                        style: const TextStyle(
                          fontFamily: "Creato Display",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF92939E),
                        ),
                      ),
                  TextFormField(
                    controller: _receivingWalletController,
                    readOnly: true,
                    cursorColor: Color(0xff0092FF),
                    onTap: () {
                      _openReceivingWalletSelector(context);
                    },
                    decoration: InputDecoration(
                      hintText: "Receiving Wallet",
                      // 👈 shown inside until typing
                      border: OutlineInputBorder(),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgPicture.asset(
                          icQwidArrowDown,
                          width: 24,
                          height: 24,
                          color: Color(0xFF92939E),
                        ),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffF3F5F7),
                          width: 0.5,
                        ), // custom color & thickness
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff0092FF),
                          width: 1,
                        ),
                      ),
                      prefixIcon:
                          _receivingWalletController.text.isEmpty
                              ? null
                              : Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CountryFlag.fromCurrencyCode(
                                    _receivingWalletController.text.isEmpty
                                        ? "NGN"
                                        : _receivingWalletController.text,
                                    width: 24,
                                    height: 15,
                                    shape: Rectangle(),
                                  ),
                                  SizedBox(height: 8),
                                ],
                              ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: _amountController.text.isEmpty ? 0 : 8),
              // Email
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _amountController.text.isEmpty
                      ? SizedBox.shrink()
                      : Text(
                    "Enter Amount",
                    style: const TextStyle(
                      fontFamily: "Creato Display",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF92939E),
                    ),
                  ),
                  TextFormField(
                    controller: _amountController,
                    cursorColor: const Color(0xff0092FF),
                    decoration: InputDecoration(
                      hintText: "Enter Amount",
                      border: OutlineInputBorder(),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffF3F5F7),
                          width: 0.5,
                        ),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff0092FF),
                          width: 1,
                        ),
                      ),
                      prefixIcon: _amountController.text.isEmpty ? null : Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 8, 4),
                        child: Text(
                          _amountController.text.isEmpty
                              ? ''
                              : "NGN",
                          style: const TextStyle(
                            fontFamily: 'Creato Display',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff92939E),
                          ),
                        ),
                      ),
                      errorStyle: const TextStyle(height: 0), // hide default error
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        _isLoading = true;
                      });
                      Future.delayed(Duration(seconds: 2), () {
                        setState(() {
                          _isLoading = false;
                        });
                      });
                    },
                  ),
                ],
              ),
              !isFormValid
                  ? SizedBox.shrink()
                  : _isLoading && isFormValid
                      ? SizedBox(
                        width: double.infinity,
                        child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: const CupertinoActivityIndicator(color: Color(0xffAEB3BE)),
                            )))
                      :_buildAmountField(),
              // Password
              const Spacer(),

              // Continue button
              SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed:
                            isFormValid
                                ? () {
                                  // Get.toNamed(
                                  //   AppRoutes.accountVerificationRoute,
                                  // )?.then((value) {
                                  //   if (value != null) {
                                  //     Get.toNamed(
                                  //       AppRoutes.personalInformationRoute,
                                  //     );
                                  //   }
                                  // });
                                }
                                : null, // Disabled until form valid
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          // remove shadow
                          shadowColor: Colors.transparent,
                          // optional, ensures no shadow color
                          backgroundColor:
                              isFormValid
                                  ? const Color(0xFF0092FF)
                                  : const Color(0xFFF4F4F4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: Text(
                          "Convert Funds",
                          style: TextStyle(
                            fontFamily: "Creato Display",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: isFormValid ? Colors.white : Color(0xFFA3A3A3),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(icQwidInformation, width: 14, height: 14),
                        SizedBox(width: 4),
                        Text("Exchange rate: ",
                          style: TextStyle(
                              fontFamily: 'Creato Display',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff92939E)),
                        ),
                        Text("\$1 = ₦0.000624",
                          style: TextStyle(
                              fontFamily: 'Creato Display',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff92939E)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAmountField() {
    return Column(
      children: [
        SizedBox(height: 32),
        Row(
          children: [
            Expanded(
              child: Text(
                "You Get",
                style: const TextStyle(
                  fontFamily: "Creato Display",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF92939E),
                ),
              ),
            ),
            Text(
              "\$3.10",
              style: const TextStyle(
                fontFamily: "Creato Display",
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF0A0A0C),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Text(
                "Fee",
                style: const TextStyle(
                  fontFamily: "Creato Display",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF92939E),
                ),
              ),
            ),
            Text(
              "0.00",
              style: const TextStyle(
                fontFamily: "Creato Display",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF0A0A0C),
              ),
            ),
          ],
        ),
      ]
    );
  }

  void _openSendFromSelector(BuildContext context) async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const SelectWalletBottomSheet(),
    );

    if (selected != null) {
      _sendFromController.text = selected;
    }
  }

  void _openReceivingWalletSelector(BuildContext context) async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const SelectWalletBottomSheet(),
    );

    if (selected != null) {
      _receivingWalletController.text = selected;
    }
  }

}
