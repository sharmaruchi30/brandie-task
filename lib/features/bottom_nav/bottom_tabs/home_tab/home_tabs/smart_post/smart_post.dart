import 'package:Brandie/core/basic_features.dart';
import 'package:Brandie/core/model/ui_model/post_ui_model.dart';
import 'package:Brandie/core/widgets/caption_widget.dart';
import 'package:Brandie/core/widgets/custom_image.dart';
import 'package:Brandie/core/widgets/post_widget.dart';
import 'package:Brandie/features/bottom_nav/bottom_tabs/home_tab/home_tabs/smart_post/controllers/smart_post_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../core/widgets/music_recommendation_widget.dart';

class SmartPost extends StatelessWidget {
  const SmartPost({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SmartPostController(),
      builder: (controller) => SizedBox(
        height: Get.width,
        child: Stack(
          children: [
            PageView.builder(
              onPageChanged: (value) {
                controller.selectedPage.value = value;
                controller.onPageChanged(value);
              },
              scrollDirection: Axis.vertical,
              itemCount: PostUiModel.dummyPostData.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => controller.togglePlayAndPause(),
                child: PostWidget(
                  post: PostUiModel.dummyPostData[index],
                  index: index + 1,
                  total: PostUiModel.dummyPostData.length,
                ),
              ),
            ),
            Positioned(
              top: Get.height / 3,
              right: 10,
              child: Container(
                margin: EdgeInsets.all(Dimensions.r8),
                padding: EdgeInsets.symmetric(vertical: Dimensions.h5),
                decoration: BoxDecoration(
                    color: AppColors.blackColor.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(Dimensions.r20)),
                alignment: Alignment.center,
                child: Obx(
                  () => Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: List.generate(
                      PostUiModel.dummyPostData.length,
                      (index) => AnimatedContainer(
                        duration: 200.ms,
                        height: Dimensions.w12,
                        width: Dimensions.w12,
                        margin: EdgeInsets.symmetric(
                            horizontal: Dimensions.w5, vertical: Dimensions.h4),
                        decoration: BoxDecoration(
                            color: controller.selectedPage.value == index
                                ? AppColors.primaryColor
                                : Colors.white,
                            borderRadius:
                                BorderRadius.circular(Dimensions.r50)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => controller.togglePlayAndPause(),
              child: Obx(
                () => controller.showIcon.value
                    ? Center(
                        child: CustomSvgAssetImage(
                          image: controller.isPaused.value
                              ? AppImages.icPlay
                              : AppImages.icPause,
                          color: Colors.white,
                          size: 60,
                        )
                            .animate(
                                controller:
                                    controller.audioIconAnimationController)
                            .fadeIn(duration: 300.ms)
                            .fadeOut(delay: 300.ms),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
