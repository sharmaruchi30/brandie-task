import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

import '../utils/app_utils.dart';

class PermissionHelper {
  // Camera Permission
  static Future<bool> isCameraPermissionGranted() async {
    const permission = Permission.camera;

    final status = await permission.status;

    if (status.isDenied) {
      final newStatus = await permission.request();
      return newStatus.isGranted || newStatus.isLimited;
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
      return false;
    } else {
      return true;
    }
  }
}
