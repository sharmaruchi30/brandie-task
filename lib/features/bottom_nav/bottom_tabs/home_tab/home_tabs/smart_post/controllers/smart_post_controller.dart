import 'package:Brandie/core/basic_features.dart';
import 'package:Brandie/core/utils/logger_util.dart';

class SmartPostController extends GetxController {
  RxInt selectedPage = 0.obs;
  RxDouble progress = 0.0.obs;
  RxString currentLoadingStep = AppString.generatingYourSalesLink.obs;
  bool isDialogOpened = false;
  List<String> loadingSteps = [
    AppString.generatingYourSalesLink,
    AppString.copyingTheCaptionToClipboard,
    AppString.savingTheContentToYourProfile,
    AppString.preparingTheContentForSocialMedia,
  ];

  Future<void> animateProgress() async {
    List<double> steps = [0.2, 0.5, 0.75, 1.0];

    for (var step in steps) {
      if (isDialogOpened) {
        await Future.delayed(const Duration(seconds: 2));
        logger.i("Changed");
        currentLoadingStep.value = loadingSteps[steps.indexOf(step)];
        progress.value = step;
        if (step == 1.0) {
          Get.back();
          AppUtils.openLink(link: "https://www.instagram.com/");
          break;
        }
      }
    }
  }

  List<String> socialIcons = [
    AppImages.imgIg,
    AppImages.imgIgStory,
    AppImages.imgFb,
    AppImages.imgFbStory,
    AppImages.imgMessenger,
    AppImages.imgTikTok,
    AppImages.imgWhatsapp,
    AppImages.imgWhatsappB,
    AppImages.imgTelegram,
    AppImages.imgMail,
    AppImages.imgGreenGram
  ];
}
