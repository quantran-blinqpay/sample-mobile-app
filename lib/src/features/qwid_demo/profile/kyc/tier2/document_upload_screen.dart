import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qwid/src/components/scaffold/app_scaffold.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:qwid/src/features/qwid_demo/profile/kyc/tier2/media_picker_bottom_sheet.dart';
import 'package:qwid/src/router/route_names.dart';

@RoutePage(name: documentUploadRoute)
class DocumentUploadScreen extends StatelessWidget {
  const DocumentUploadScreen({super.key});

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
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                const SizedBox(height: 16),
                const Text(
                  "Document Upload Guidelines",
                  style: TextStyle(
                    fontFamily: 'Creato Display',
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "To complete your verification, upload a clear image of your proof of address. Please ensure all details are visible and match your registration information.",
                  style: TextStyle(
                    fontFamily: 'Creato Display',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: sub,
                  ),
                ),
                const SizedBox(height: 24),

                // List of steps
                Image.asset(icQwidDocument, width: 155, height: 198),
                SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                  child: Row(
                    children: [
                      SvgPicture.asset(icQwidCheckmark, width: 16, height: 16),
                      const SizedBox(width: 12),
                      const Text(
                        "Requirements",
                        style: TextStyle(
                          fontFamily: 'Creato Display',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff0A0A0C),
                        ),
                      ),
                    ],
                  ),
                ),
                _stepTile(
                  icon: icQwidDot,
                  title: "Upload a complete image of your ID document",
                ),
                _stepTile(
                  icon: icQwidDot,
                  title: "Ensure the document is the original and has not expired",
                ),
                _stepTile(
                  icon: icQwidDot,
                  title: "Ensure all details are readable in the image you upload",
                ),
                _stepTile(
                  icon: icQwidDot,
                  title: "Place documents against a solid-coloured background",
                ),
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
                    backgroundColor: Color(0xFF0092FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    _openMediaPicker(context);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(icQwidFileUpload, width: 24, height: 24),
                      SizedBox(width: 8),
                      Text(
                        "Upload Document",
                        style: TextStyle(
                          fontFamily: 'Creato Display',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    backgroundColor: Colors.white,
                    side: const BorderSide(        // 👈 border here
                      color: Color(0xffE1E5EA),
                      width: 1,
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    context.router.pop("take a photo");
                    // Get.toNamed(AppRoutes.takeADocumentPicture);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                          icQwidCamera,
                          width: 24,
                          height: 24,
                          color: Color(0xFF0092FF)),
                      SizedBox(width: 8),
                      Text(
                        "Take a Photo",
                        style: TextStyle(
                          fontFamily: 'Creato Display',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF0092FF),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _stepTile({
    required String icon,
    required String title,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: SvgPicture.asset(icon, width: 16, height: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Creato Display',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff92939E),
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openMediaPicker(BuildContext context) async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => MediaPickerBottomSheet(),
    );

    if (selected != null) {
      if (selected == "gallery") {
        context.router.pop( "upload document");
      } else if (selected == "file") {
        context.router.pop("upload document");
      }
    }
  }
}