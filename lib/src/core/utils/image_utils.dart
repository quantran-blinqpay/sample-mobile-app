import 'package:qwid/src/components/dialog/custom_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart' as permission;

class ImageUtils {
  static void handleImagePermission(BuildContext context, PlatformException e) {
    switch (e.code) {
      case 'camera_access_denied':
      case 'photo_access_denied':
        CustomDialog.showConfirmDialog(
          context,
          title: 'Unable to Access Camera',
          subtitle:
              'This app needs access to your camera to continue. Please grant permission in your device settings.',
          positiveText: 'Open settings',
          onPositive: () async {
            await permission.openAppSettings();
          },
        );
        break;

      default:
    }
  }
}
