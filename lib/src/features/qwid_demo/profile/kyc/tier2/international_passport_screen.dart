import 'package:auto_route/auto_route.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qwid/src/components/scaffold/app_scaffold.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:qwid/src/features/qwid_demo/signup/personal_account/loading_bottom_sheet.dart';
import 'package:qwid/src/router/route_names.dart';

@RoutePage(name: internationalPassportRoute)
class InternationalPassportScreen extends StatefulWidget {
  const InternationalPassportScreen({super.key});

  @override
  State<InternationalPassportScreen> createState() => _InternationalPassportScreenState();
}

class _InternationalPassportScreenState extends State<InternationalPassportScreen> {
  @override
  Widget build(BuildContext context) {
    const sub = Color(0xFF92939E);

    return AppScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18, color: Colors.black),
          onPressed: () => Navigator.maybePop(context),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SvgPicture.asset(icQwidCamera, width: 24, height: 24, color: Color(0xFF0092FF)),
          ),
        ],
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                const SizedBox(height: 16),
                const Text(
                  "International Passport",
                  style: TextStyle(
                    fontFamily: 'Creato Display',
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Upload a clear image of your government-issued ID to verify your identity",
                  style: TextStyle(
                    fontFamily: 'Creato Display',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: sub,
                  ),
                ),
                const SizedBox(height: 24),

                // List of steps
                _buildBodyWidget(context)
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _file != null && _fileSize <= 2000000 ? Color(0xFF0092FF): Color(0xFFF4F4F4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    elevation: 0,
                  ),
                  onPressed: _file != null && _fileSize <= 2000000 ? () {
                    _usePhoto(context);
                  } : null,
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      fontFamily: 'Creato Display',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _file != null && _fileSize <= 2000000 ? Colors.white: Color(0xFFA3A3A3),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: Center(
                child: Text(
                  "Choose a different document",
                  style: TextStyle(
                    fontFamily: 'Creato Display',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF0092FF),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBodyWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Stack(
            children: [
              DottedBorder(
                options: RoundedRectDottedBorderOptions(
                  dashPattern: [10, 5],
                  strokeWidth: 1,
                  color: (_file != null && _fileSize > 2000000) ? Colors.red: Color(0xffE0E4E9),
                  radius:  const Radius.circular(16),
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 343,
                  child: _file == null ? _buildBrowserFilesWidget(context) : _buildChooseFileWidget(context),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Visibility(
                    visible: _file != null,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _file = null;
                          _fileSize = 0;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SvgPicture.asset(
                          icQwidTrash,
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          if (_file != null && _fileSize > 2000000)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Row(
                children: [
                  SvgPicture.asset(
                      icQwidError,
                      width: 16,
                      height: 16,
                      color: Colors.red),
                  const SizedBox(width: 4),
                  Text(
                    'File should be less than 8 MB',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.red,
                      fontFamily: "Creato Display",
                    ),
                  ),
                ],
              ),
            )
          else if (_file != null && _fileSize <= 2000000)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Row(
                children: [
                  SvgPicture.asset(
                      icQwidSuccess,
                      width: 16,
                      height: 16),
                  const SizedBox(width: 4),
                  Text(
                    'File upload successful',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xff92939E),
                      fontFamily: "Creato Display",
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBrowserFilesWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _openImagePicker(context);
      },
      child: ColoredBox(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(icQwidFileUpload, width: 24, height: 24, color: Color(0xff92939E)),
            const SizedBox(height: 8),
            const Text(
              "Browse files to upload",
              style: TextStyle(
                fontFamily: 'Creato Display',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF0092FF),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChooseFileWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _openImagePicker(context);
      },
      child: ColoredBox(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(icQwidGallery, width: 24, height: 24, color: Color(0xff92939E)),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                _file?.name ?? "Choose a file",
                style: TextStyle(
                  fontFamily: 'Creato Display',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF92939E),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Choose another file...",
              style: TextStyle(
                fontFamily: 'Creato Display',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF0092FF),
              ),
            ),
          ],
        ),
      ),
    );
  }

  XFile? _file;
  int _fileSize = 0;

  void _openImagePicker(BuildContext context) async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    final size = await image?.length() ?? 0;
    setState(() {
      _file = image;
      _fileSize = size;
    });
  }

  void _usePhoto(BuildContext context) async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const LoadingBottomSheet(title: 'Verifying Your ID'),
    );

    if (selected != null) {
      // _countryController.text = selected;
      context.router.popUntilRouteWithName(tier2VerificationRoute);
      // Get.until((route) => Get.currentRoute == AppRoutes.tier2Verification);
    }
  }
}