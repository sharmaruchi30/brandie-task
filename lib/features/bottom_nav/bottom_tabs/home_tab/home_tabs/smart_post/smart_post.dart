import 'package:Brandie/core/basic_features.dart';
import 'package:Brandie/core/model/ui_model/post_ui_model.dart';
import 'package:Brandie/core/widgets/caption_widget.dart';
import 'package:Brandie/core/widgets/custom_image.dart';
import 'package:Brandie/core/widgets/post_widget.dart';
import 'package:Brandie/features/bottom_nav/bottom_tabs/home_tab/home_tabs/smart_post/controllers/smart_post_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../../core/widgets/custom_button.dart';
import '../../../../../../core/widgets/music_recommendation_widget.dart';
import '../../../../controllers/bottom_nav_controller.dart';

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
            Positioned(
              top: Dimensions.h10,
              child: SizedBox(
                width: Get.width,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.commonPaddingForScreen),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(Dimensions.r50),
                            child: CustomAssetImage(
                              onTap: () {
                                AppUtils.showCustomDialog(
                                    backgroundColor: Colors.transparent,
                                    myWidget: Column(
                                      children: [
                                        MyRoundCornerAssetImage(
                                          image: AppImages.imgProfile,
                                          height: Get.width / 2,
                                          width: Get.width / 2,
                                          radius: Dimensions.r12,
                                        ),
                                        SizedBox(
                                          height: Dimensions.h10,
                                        ),
                                        MyButton(
                                          miniWidth: Get.width / 2,
                                          cornerRadius: Dimensions.r12,
                                          height: Dimensions.h30,
                                          onPressed: () {
                                            Get.back();
                                            Get.find<BottomNavController>(
                                                tag: AppString
                                                    .bottomNavControllerTag)
                                                .selectedScreenIndex
                                                .value = 4;
                                          },
                                          title: AppString.goToYourProfile,
                                        )
                                      ],
                                    ));
                              },
                              image: AppImages.imgProfile,
                              size: Dimensions.w50,
                            ),
                          ),
                          SizedBox(
                            width: Dimensions.w5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Dimensions.w10,
                                    vertical: Dimensions.h2),
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(Dimensions.r16),
                                  gradient: const LinearGradient(colors: [
                                    Color(0xffF7AEA7),
                                    Color(0xffE58698),
                                    Color(0xffBF96D6),
                                  ]),
                                ),
                                child: Row(
                                  children: [
                                    CustomSvgAssetImage(
                                      image: AppImages.icAiStar,
                                      size: Dimensions.w15,
                                    ),
                                    SizedBox(
                                      width: Dimensions.w5,
                                    ),
                                    Text(
                                      AppString.readyToShare,
                                      style: fontStyleMedium10.apply(
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.h5,
                              ),
                              Text(
                                AppString.highConvertingInOriflameCommunity,
                                style: fontStyleMedium10.apply(
                                    color: Colors.white),
                              )
                            ],
                          )
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.w8, vertical: Dimensions.h2),
                        decoration: BoxDecoration(
                            color: AppColors.blackColor.withValues(alpha: 0.2),
                            borderRadius:
                            BorderRadius.circular(Dimensions.r12)),
                        child: Obx(
                          ()=> Text(
                            "${controller.selectedPage.value + 1} of ${PostUiModel.dummyPostData.length}",
                            style: fontStyleBold10.apply(
                                color: AppColors.whiteColor),
                          ),
                        ),
                      )
                    ],
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
