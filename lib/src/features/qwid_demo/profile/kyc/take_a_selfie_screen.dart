import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:qwid/src/features/qwid_demo/onboarding/loading_bottom_sheet.dart';
import 'package:qwid/src/router/route_names.dart';

@RoutePage(name: takeASelfie)
class TakeASelfieScreen extends StatefulWidget {
  const TakeASelfieScreen({super.key});

  @override
  State<TakeASelfieScreen> createState() => _TakeASelfieScreenState();
}

class _TakeASelfieScreenState extends State<TakeASelfieScreen> {
  CameraController? _controller;
  bool _isReady = false;
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    // Ask for camera permission
    var status = await Permission.camera.request();

    // If permanently denied, guide user to settings
    if (status.isPermanentlyDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Please enable camera access in settings")),
      );
      await openAppSettings();
      return;
    }

    // If denied (but not permanent), ask again until granted
    while (!status.isGranted) {
      status = await Permission.camera.request();
    }

    // Initialize camera
    final cameras = await availableCameras();
    final front = cameras.firstWhere(
      (c) => c.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    _controller = CameraController(
      front,
      ResolutionPreset.high,
      enableAudio: false,
    );

    await _controller!.initialize();

    if (!mounted) return;
    setState(() => _isReady = true);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) return;
    final picture = await _controller!.takePicture();
    setState(() => _imagePath = picture.path);
    // TODO: upload or save picture.path
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Captured: ${picture.path}")),
    );
  }

  Widget _buildCameraPreview(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: FittedBox(
        fit: BoxFit.fitHeight, // 👈 zoom/crop instead of fit
        child: SizedBox(
          width: size.width,
          child: CameraPreview(_controller!),
        ),
      ),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(
      //   backgroundColor: Colors.black,
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      // ),
      body: !_isReady
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : Column(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      _imagePath?.isNotEmpty ?? false ? _buildPicturePreview(context) : _buildCameraPreview(context),
                      SizedBox(
                        width: 300,
                        height: 300,
                        child: SvgPicture.asset(icQwidFrame, color: Colors.white, width: 300, height: 300,),
                      ),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AppBar(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                leading: IconButton(
                                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                "Take a Selfie",
                                style: TextStyle(
                                  fontFamily: 'Creato Display',
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                "Position your face in the frame to take a picture",
                                style: TextStyle(
                                  fontFamily: 'Creato Display',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFB3B3B3),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: SafeArea(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: _imagePath?.isNotEmpty ?? false ? _buildActionButton() : _buildBottomButton()

                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildPicturePreview(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Image.file(
          File(_imagePath!),
          alignment: Alignment.center,
          fit: BoxFit.cover,));
  }

  Widget _buildBottomButton() {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      // Capture button
      GestureDetector(
        onTap: _takePicture,
        child: SvgPicture.asset(icQwidCaptureButton, width: 90, height: 90),
      ),
      const SizedBox(height: 12),

      // Powered by Sumsub
      Image.asset(icQwidPoweredBySumsub, width: 1410, height: 20),
      const SizedBox(height: 24),
    ]);
  }

  Widget _buildActionButton() {
    return SafeArea(
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        const SizedBox(width: 16),
        // Capture button
        Expanded(child: _buildButton('Retake Photos', const Color(0xFF92939E), () {
          setState(() => _imagePath = null);
        })),
        const SizedBox(width: 16),
        Expanded(child: _buildButton('Use Photo', const Color(0xFF0092FF), () {
          _usePhoto(context);
        })),
        const SizedBox(width: 16),
      ]),
    );
  }

  Widget _buildButton(String text, Color color, Function()? onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          elevation: 0,
        ),
        onPressed: () {
          onPressed?.call();
        },
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Creato Display',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
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
      context.router.popUntilRouteWithName(kycRoute);
    }
  }
}
