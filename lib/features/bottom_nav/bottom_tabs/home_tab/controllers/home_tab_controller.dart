import 'package:Brandie/core/basic_features.dart';
import 'package:Brandie/features/bottom_nav/controllers/bottom_nav_controller.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HomeTabController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late VideoPlayerController videoController;
  late TabController tabController;
  RxInt tabIndex = 0.obs;
  RxBool showVideo = true.obs;
  RxBool isVideoLoaded = false.obs;
  List<String> tabList = [
    AppString.smartPost,
    AppString.library,
    AppString.communities,
    AppString.shareAndWin,
  ];

  @override
  void onInit() {
    videoController = VideoPlayerController.asset(AppImages.loadingVideo,
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true))
      ..setLooping(true)
      ..setVolume(0.0)
      ..initialize().then((_) {
        Future.delayed(
            const Duration(milliseconds: 100), () => isVideoLoaded.value = true);
        Future.delayed(const Duration(seconds: 15), () {
          showVideo.value = false;
          isVideoLoaded.value = false;
          Get.find<BottomNavController>(tag: AppString.bottomNavControllerTag)
              .showBottomNav
              .value = true;
        });
      })
      ..play();
    ;
    tabController = TabController(
      length: tabList.length,
      vsync: this,
      initialIndex: tabIndex.value,
    );
    super.onInit();
  }
}
