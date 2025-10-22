import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qwid/src/components/scaffold/app_scaffold.dart';
import 'package:qwid/src/configs/app_themes/app_images.dart';
import 'package:qwid/src/features/qwid_demo/signup/personal_account/loading_bottom_sheet.dart';
import 'package:qwid/src/router/route_names.dart';

@RoutePage(name: takeDriverLicensePictureRoute)
class TakeDriveLicensePictureScreen extends StatefulWidget {
  const TakeDriveLicensePictureScreen({super.key});

  @override
  State<TakeDriveLicensePictureScreen> createState() =>
      _TakeDriveLicensePictureScreenState();
}

class _TakeDriveLicensePictureScreenState
    extends State<TakeDriveLicensePictureScreen> {
  CameraController? _controller;
  bool _isReady = false;
  XFile? _front;
  int _fontPictureSize = 0;
  XFile? _back;
  int _backPictureSize = 0;

  bool get _isFrontValid => _front != null && _fontPictureSize <= 2000000;
  bool get _isBackValid => _back != null && _backPictureSize <= 2000000;

  int _step = 1;

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
          content: Text("Please enable camera access in settings"),
        ),
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
      (c) => c.lensDirection == CameraLensDirection.back,
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

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: Colors.black,
      body: !_isReady
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : Column(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      (_step == 1 && _front != null) || (_step == 2 && _back != null)
                          ? _buildPicturePreview(context)
                          : _buildCameraPreview(context),
                      SizedBox(
                        width: 300,
                        height: 300,
                        child: SvgPicture.asset(
                          icQwidFrame,
                          color: Colors.white,
                          width: 300,
                          height: 300,
                        ),
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
                                  icon: const Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                // actions: [
                                //   Padding(
                                //     padding: const EdgeInsets.only(right: 16.0),
                                //     child: Center(
                                //       child: SvgPicture.asset(icQwidFileUpload, width: 24, height: 24),
                                //     ),
                                //   ),
                                // ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                _step == 1 ? "Take a Photo of the Front": "Take a Photo of the Back",
                                style: TextStyle(
                                  fontFamily: 'Creato Display',
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Position document in the frame to take a picture",
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
                            child: (_step == 1 && _front != null) || (_step == 2 && _back != null)
                                ? (_step == 1 && _isFrontValid) || (_step == 2 && _isBackValid)
                                      ? _buildActionButton()
                                      : _buildTooLargeButton()
                                : _buildBottomButton(),
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

  Widget _buildCameraPreview(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: FittedBox(
        fit: BoxFit.fitHeight, // 👈 zoom/crop instead of fit
        child: SizedBox(width: size.width, child: CameraPreview(_controller!)),
      ),
    );
  }

  Widget _buildPicturePreview(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Image.file(
        File(_step == 1 ? _front!.path : _back!.path),
        alignment: Alignment.center,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildBottomButton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Capture button
        GestureDetector(
          onTap: _takePicture,
          child: SvgPicture.asset(icQwidCaptureButton, width: 90, height: 90),
        ),
        const SizedBox(height: 12),

        // Powered by Sumsub
        Image.asset(icQwidPoweredBySumsub, width: 1410, height: 20),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildActionButton() {
    return SafeArea(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 16),
          // Capture button
          Expanded(
            child: _buildButton('Retake Photos', const Color(0xFF92939E), () {
              setState(() {
                if (_step == 1) {
                  _front = null;
                  _fontPictureSize = 0;
                } else {
                  _back = null;
                  _backPictureSize = 0;
                }
              });
            }),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildButton('Use Photo', const Color(0xFF0092FF), () {
              _usePhoto(context);
            }),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }

  Widget _buildTooLargeButton() {
    return SafeArea(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 16),
          // Capture button
          Expanded(
            child: _buildButton(
              'Retake Photos',
              const Color(0xffffffff).withOpacity(0.15),
              () {
                setState(() {
                  if (_step == 1) {
                    _front = null;
                    _fontPictureSize = 0;
                  } else {
                    _back = null;
                    _backPictureSize = 0;
                  }
                });
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildButton(
              'Max file size: 8MB',
              const Color(0xffFD0211).withOpacity(0.66),
              () {
                _usePhoto(context);
              },
              icon: icQwidError,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }

  Widget _buildButton(
    String text,
    Color color,
    Function()? onPressed, {
    String? icon,
  }) {
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon == null
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    // padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      icon,
                      width: 16,
                      height: 16,
                      color: Colors.white,
                    ),
                  ),
            Flexible(
              child: Text(
                text,
                style: TextStyle(
                  fontFamily: 'Creato Display',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _usePhoto(BuildContext context) async {
    if (_step == 1) {
      setState(() {
        _step = 2;
      });
    } else {
      final selected = await showModalBottomSheet<String>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => const LoadingBottomSheet(title: 'Verifying Your ID'),
      );

      if (selected != null) {
        context.router.popUntilRouteWithName(tier2VerificationRoute);
        // Get.until((route) => Get.currentRoute == AppRoutes.tier2Verification);
      }
    }
  }

  Future<void> _takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) return;
    final picture = await _controller!.takePicture();
    final size = await picture.length() ?? 0;
    setState(() {
      if (_step == 1) {
        _front = picture;
        _fontPictureSize = size;
      } else {
        _back = picture;
        _backPictureSize = size;
      }
    });
    // TODO: upload or save picture.path
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Captured: ${picture.path}")));
  }
}
