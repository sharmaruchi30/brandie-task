import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import '../basic_features.dart';
import '../helpers/animation_helper.dart';
import '../widgets/custom_button.dart';
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

  static void goFullScreen() =>
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  static Future<void> exitFullScreen() =>
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
        SystemUiOverlay.top,
        SystemUiOverlay.bottom,
      ]);

  static Future<void> showCustomDialog({
    String? title,
    String? descriptions,
    String? contentText,
    double? contentTextFontSize,
    bool barrierDismiss = true,
    bool mergeDefaultWithContent = false,
    String? firstButtonText,
    Widget? myWidget,
    String? icon,
    Color? backgroundColor,
    Function? onDialogCloseFunction,
    VoidCallback? firstButtonFunction,
    VoidCallback? secondButtonFunction,
    String? secondButtonText,
  }) async =>
      await showGeneralDialog(
        context: Get.context!,
        barrierDismissible: barrierDismiss,
        barrierLabel: "Meow",
        barrierColor: Theme.of(Get.context!)
            .scaffoldBackgroundColor
            .withValues(alpha: 0.9),
        transitionDuration: const Duration(milliseconds: 350),
        transitionBuilder: (_, animation, __, child) {
          return ScaleTransition(
              scale:
                  Tween<double>(begin: 0.9, end: 1.0).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              )),
              child: FadeTransition(
                opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOut,
                  ),
                ),
                child: child,
              ));
        },
        pageBuilder: (context, _, __) => Center(
          child: Container(
            width: Get.width * 0.90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.r15),
              color: backgroundColor ?? Get.theme.scaffoldBackgroundColor,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(Dimensions.commonPaddingForScreen)
                      .copyWith(top: 0),
                  child: myWidget != null && !mergeDefaultWithContent
                      ? myWidget
                      : Column(
                          children: [
                            // Top Icon
                            if (icon != null)
                              CustomSvgAssetImage(
                                image: icon,
                                width: Dimensions.w130,
                                height: Dimensions.w130,
                              ),

                            // Description Text
                            if (descriptions != null)
                              Text(
                                descriptions,
                                textAlign: TextAlign.center,
                                style: fontStyleRegular15.copyWith(
                                    color: Get.theme.colorScheme.hintTextColor),
                              ),
                            SizedBox(
                              height: Dimensions.h2,
                            ),

                            // Content Text
                            if (contentText != null)
                              Text(
                                contentText,
                                textAlign: TextAlign.center,
                                style: fontStyleMedium12.copyWith(
                                    color: Get.theme.colorScheme.textColor,
                                    fontSize: contentTextFontSize),
                              ),

                            if (myWidget != null) myWidget,
                            if (firstButtonText != null ||
                                secondButtonText != null)
                              SizedBox(
                                height: Dimensions.h20,
                              ),
                            if (firstButtonText != null ||
                                secondButtonText != null)
                              Row(
                                children: [
                                  // First Button
                                  if (firstButtonText != null)
                                    Flexible(
                                      child: MyButton(
                                          onPressed: () {
                                            Get.back();
                                            firstButtonFunction?.call();
                                          },
                                          cornerRadius: Dimensions.r50,
                                          textStyle:
                                              fontStyleSemiBold14.copyWith(
                                                  color: Colors.white,
                                                  fontSize: Dimensions.sp13),
                                          title: firstButtonText),
                                    ),
                                  SizedBox(
                                    width: Dimensions.w10,
                                  ),
                                ],
                              )
                          ],
                        ),
                ),
              ],
            ),
          ),
        ),
      ).then((_) => onDialogCloseFunction?.call());

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
                  Icon(
                    Icons.check_circle_outline_sharp,
                    size: Dimensions.w30,
                  ),

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
      await launchUrl(encodedURl, mode: LaunchMode.externalApplication);
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
