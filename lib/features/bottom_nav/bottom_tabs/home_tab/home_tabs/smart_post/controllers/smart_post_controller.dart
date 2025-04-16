import 'dart:ui';
import 'package:Brandie/core/basic_features.dart';
import 'package:Brandie/core/utils/logger_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:just_audio/just_audio.dart';

class SmartPostController extends GetxController
    with WidgetsBindingObserver, GetSingleTickerProviderStateMixin {
  // PageView
  RxInt selectedPage = 0.obs;

  // Loader
  RxDouble progress = 0.0.obs;
  RxString currentLoadingStep = AppString.generatingYourSalesLink.obs;
  bool isDialogOpened = false;
  List<String> loadingSteps = [
    AppString.generatingYourSalesLink,
    AppString.copyingTheCaptionToClipboard,
    AppString.savingTheContentToYourProfile,
    AppString.preparingTheContentForSocialMedia,
  ];

  // Audio
  final player = AudioPlayer();
  RxBool isPaused = false.obs;
  late AnimationController audioIconAnimationController;

  RxBool showIcon = false.obs;
  List<String> songs = [
    AppImages.badHabitsAudio,
    AppImages.unstoppableAudio,
    AppImages.vogueAudio
  ];

  @override
  onInit() {
    WidgetsBinding.instance.addObserver(this);
    audioIconAnimationController =
        AnimationController(vsync: this, duration: 50.ms);
    setAndPlayAudio();
    super.onInit();
  }

  @override
  Future<void> onClose() async {
    await player.stop();
    player.dispose();
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      player.pause();
    } else if (state == AppLifecycleState.resumed) {
      if (!isPaused.value) {
        player.play();
      }
    }
  }

  bool _isAnimatingIcon = false;

  Future<void> togglePlayAndPause() async {
    if (_isAnimatingIcon) {
      audioIconAnimationController.reset();
    }

    _isAnimatingIcon = true;
    showIcon.value = true;

    if (isPaused.value) {
      isPaused.value = false;
      await player.play();
    } else {
      isPaused.value = true;
      await player.pause();
    }

    await audioIconAnimationController.forward();
    audioIconAnimationController.reset();

    showIcon.value = false;
    _isAnimatingIcon = false;
  }

  Future<void> setAndPlayAudio() async {
    await player.setAsset(AppImages.badHabitsAudio);
    await player.setLoopMode(LoopMode.all);
    player.play();
  }

  Future<void> onPageChanged(int index) async {
    logger.i("Song Changed");
    await player.stop();
    await player.setAsset(songs[index]);

    if (!isPaused.value) {
      player.play();
    }
  }

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
