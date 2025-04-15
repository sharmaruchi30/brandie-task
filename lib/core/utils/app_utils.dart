import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import '../basic_features.dart';
import '../helpers/animation_helper.dart';
import '../widgets/custom_image.dart';
import 'logger_util.dart';

void orientations() => SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

class AppUtils {
  static String packageName = '';
  static DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  static double bottomPadding(BuildContext context) =>
      buttonHeight(context) + MediaQuery.of(context).padding.bottom;

  static double buttonHeight(BuildContext context) {
    // print("AppBar().preferredSize.height    ${AppBar().preferredSize.height}");
    return AppBar().preferredSize.height;
  }

  // static AppCheckerResult? appVersion;
  static AndroidDeviceInfo? androidInfo;
  static IosDeviceInfo? iosInfo;
  static String? deviceID;
  static bool isAndroid = Platform.isAndroid;
  static bool isIos = Platform.isIOS;

  static String platform = Platform.isAndroid ? "Android" : "iOS";

  static void closeKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

  static showSnackBar(
      {bool isSuccess = false,
      String? title,
      required String message,
      int durationMilliSecond = 4000}) {
    if (!Get.isSnackbarOpen) {
      Get.showSnackbar(
        GetSnackBar(
          borderColor: AppColors.primaryColor,
          borderWidth: 2,
          barBlur: 80,
          snackPosition: SnackPosition.TOP,
          maxWidth: Get.width * 0.92,
          borderRadius: Dimensions.r17,
          forwardAnimationCurve: CustomAnimationCurves.snackBarEaseOutBack,
          animationDuration: 800.milliseconds,
          backgroundColor: AppColors.snackBarBackgroundColor,
          duration: Duration(milliseconds: durationMilliSecond),
          margin: EdgeInsets.symmetric(horizontal: Dimensions.w8),
          messageText: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Action Icon, Title, Trailing Icon
              Row(
                children: [
                  // Action Icon
                  // CustomSvgAssetImage(
                  //   image: AppImages.icCheckCircle,
                  //   width: Dimensions.w30,
                  //   height: Dimensions.w30,
                  // ),

                  // Title Text
                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.w10),
                    child: Text(
                      title ??
                          (isSuccess
                              ? AppString.snackBarPositiveTitle.tr
                              : AppString.snackBarNegativeTitle.tr),
                      style: fontStyleMedium17.copyWith(
                          color: AppColors.textColor),
                    ),
                  ),
                  Spacer(),

                  // Trailing Icon
                  // CustomSvgAssetImage(
                  //   image: AppImages.icRightArrowCircle,
                  //   width: Dimensions.w30,
                  //   height: Dimensions.w30,
                  // ),
                ],
              ),

              // Message Text
              Padding(
                padding: EdgeInsets.only(left: Dimensions.w40),
                child: Text(
                  message,
                  style:
                      fontStyleLight15.copyWith(color: AppColors.textGreyColor),
                ),
              )
            ],
          ),
        ),
      );
    }
  }

  static Future<void> openLink({required String link}) async {
    final Uri encodedURl = Uri.parse(link);

    try {
      await launchUrl(encodedURl, mode: LaunchMode.inAppWebView);
    } catch (e) {
      logger.e('Error launching URL: $e');
    }
  }

  static showToast(val) => Fluttertoast.showToast(
      msg: val,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColors.blackColor,
      textColor: Colors.white,
      fontSize: 16.0);

  static DateTime? backButtonPressedTime;

  // For Pop Scope
  static showExitPopScopePopup(BuildContext context) {
    DateTime currentTime = DateTime.now();

    bool backButton = backButtonPressedTime == null ||
        currentTime.difference(backButtonPressedTime!) >
            const Duration(seconds: 3);

    if (backButton) {
      backButtonPressedTime = currentTime;
      AppUtils.showToast('Press again to exit');
    } else {
      SystemNavigator.pop();
    }
  }
}

class FontAsset {
  static const String prompt = "Urbanist";
  static const String sfPro = "SFProText";

  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}
