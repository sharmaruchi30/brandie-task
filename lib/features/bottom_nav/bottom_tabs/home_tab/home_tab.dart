import 'package:Brandie/core/widgets/custom_app_bar.dart';
import 'package:Brandie/features/bottom_nav/bottom_tabs/home_tab/home_tabs/communities/communities.dart';
import 'package:Brandie/features/bottom_nav/bottom_tabs/home_tab/home_tabs/library/library.dart';
import 'package:Brandie/features/bottom_nav/bottom_tabs/home_tab/home_tabs/share_and_win/share_and_win.dart';
import 'package:Brandie/features/bottom_nav/bottom_tabs/home_tab/home_tabs/smart_post/smart_post.dart';
import 'package:flutter/material.dart';
import 'package:Brandie/core/basic_features.dart';
import 'package:video_player/video_player.dart';
import 'controllers/home_tab_controller.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeTabController(),
      autoRemove: false,
      builder: (controller) => Scaffold(
        appBar: const CustomAppBar(),
        body: Column(
          children: [
            Container(
              color: Colors.white,
              width: Get.width,
              height: kToolbarHeight,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    controller.tabList.length,
                    (index) => InkWell(
                      onTap: () {
                        controller.tabController.index = index;
                        controller.tabIndex.value = index;
                      },
                      child: Container(
                        width: Get.width / 4,
                        alignment: Alignment.center,
                        child: Obx(
                          () => Text(
                            controller.tabList[index],
                            style: fontStyleMedium12.apply(
                                color: controller.tabIndex.value == index
                                    ? AppColors.primaryColor
                                    : AppColors.hintColor),
                          ),
                        ),
                      ),
                    ),
                  )),
            ),
            Obx(() => controller.showVideo.value
                ? controller.isVideoLoaded.value
                    ? AspectRatio(
                        aspectRatio:
                            controller.videoController.value.aspectRatio,
                        child: VideoPlayer(controller.videoController),
                      )
                    : const SizedBox()
                : Expanded(
                    child: TabBarView(
                        controller: controller.tabController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          const SmartPost(),
                          const Library(),
                          const Communities(),
                          const ShareAndWin()
                        ]),
                  ))
          ],
        ),
      ),
    );
  }
}
