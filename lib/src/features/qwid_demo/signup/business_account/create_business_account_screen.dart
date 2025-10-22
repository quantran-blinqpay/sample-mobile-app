import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:qwid/src/components/scaffold/app_scaffold.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:qwid/src/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qwid/src/router/router.dart';

@RoutePage(name: createBusinessAccountRoute)
class CreateBusinessAccountScreen extends StatefulWidget {
  const CreateBusinessAccountScreen({super.key});

  @override
  State<CreateBusinessAccountScreen> createState() => _CreateBusinessAccountScreenState();
}

class _CreateBusinessAccountScreenState extends State<CreateBusinessAccountScreen> {
  bool _countryDone = false;
  bool _companyDone = false;
  bool _pinDone = false;

  bool get isFormValid {
    return _countryDone
        && _companyDone
        && _pinDone;
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              "Create a Business account",
              style: const TextStyle(
                fontFamily: "Creato Display",
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: Color(0xFF0A0A0C), // rgb(10,10,12)
              ),
            ),
            const SizedBox(height: 4),

            // Subtitle
            Text(
              "We just need a few details to get you started, and you’re good to go.",
              style: const TextStyle(
                fontFamily: "Creato Display",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF92939E), // rgb(146,147,158)
              ),
            ),
            const SizedBox(height: 24),

            // Steps
            _stepItem(
              isDone: _countryDone,
              icon: icQwidGlobal,
              title: "Country of Residence",
              subtitle:
              "Your country helps us apply the right terms and conditions for you.",
              onTap: () {
                setState(() {
                  _countryDone = true;
                });
                _openCountrySelector(context);
              },
            ),
            _stepItem(
              isDone: _companyDone,
              icon: icQwidBuilding,
              title: "Company Information",
              subtitle:
              "Sign up with your business name, email address, and registration details to create an account, unlock all features, and receive important updates.",
              onTap: () {
                setState(() {
                  _companyDone = true;
                });
                context.router.push(const BusinessBasicInformationScreenRoute());
                // Get.toNamed(AppRoutes.companyInformation);
              },
            ),
            _stepItem(
              isDone: _pinDone,
              icon: icQwidSecurity,
              title: "Security and PIN",
              subtitle:
              "Secure your account with a password, transaction PIN, and biometrics.",
              onTap: () {
                setState(() {
                  _pinDone = true;
                });
                context.router.push(const SecurityAndPinScreenRoute());
              },
            ),
            Spacer(),
            // Continue button
            SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: isFormValid ? (){
                    context.router.push(const CreateBusinessAccountSuccessScreenRoute());
                  } : null, // Disabled until form valid
                  style: ElevatedButton.styleFrom(
                    elevation: 0, // remove shadow
                    shadowColor: Colors.transparent, // optional, ensures no shadow color
                    backgroundColor: isFormValid
                        ? const Color(0xFF0092FF)
                        : const Color(0xFFF4F4F4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Text(
                    "Done",
                    style: TextStyle(
                      fontFamily: "Creato Display",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: isFormValid ? Colors.white : Color(0xFFA3A3A3),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _stepItem({
    required String icon,
    required String title,
    required String subtitle,
    required bool isDone,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(isDone ? icQwidCheck : icon, width: 24, height: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontFamily: "Creato Display",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF0A0A0C),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            fontFamily: "Creato Display",
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF92939E),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  SvgPicture.asset(icQwidArrowRight, width: 24, height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openCountrySelector(BuildContext context) async {
    // final selected = await context.router.push(const SelectCountryScreenRoute());
    //
    // if (selected != null) {
    //   print("Selected country: $selected");
    // }
  }
}
