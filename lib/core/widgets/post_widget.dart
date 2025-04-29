import 'package:Brandie/core/model/ui_model/post_ui_model.dart';
import 'package:Brandie/core/widgets/custom_button.dart';
import 'package:Brandie/features/bottom_nav/bottom_tabs/home_tab/home_tabs/smart_post/controllers/smart_post_controller.dart';
import 'package:Brandie/features/bottom_nav/controllers/bottom_nav_controller.dart';
import 'package:flutter/material.dart';
import '../basic_features.dart';
import 'caption_widget.dart';
import 'custom_image.dart';
import 'music_recommendation_widget.dart';

class PostWidget extends StatelessWidget {
  final int index;
  final int total;
  final PostUiModel post;

  const PostWidget(
      {super.key,
      required this.post,
      required this.index,
      required this.total});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SmartPostController(),
      builder: (controller) => SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          height: Get.height - (kToolbarHeight * 2),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(post.postImage), fit: BoxFit.fill),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                    vertical: Dimensions.commonPaddingForScreen)
                .copyWith(bottom: kToolbarHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Column(
                  children: [
                    // Music recommendation
                    MusicRecommendationWidget(
                      title: post.recommendedMusicTitle,
                      by: post.recommendedMusicBy,
                      onMusic: () async {

                      },
                    ),
                    SizedBox(
                      height: Dimensions.h10,
                    ),
                    CaptionWidget(
                      text: post.captionText,
                    ),
                    // Caption

                    // Social Share Buttons
                    SafeArea(
                      child: SizedBox(
                        height: Dimensions.h60,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: Dimensions.commonPaddingForScreen),
                          child: Row(
                            children: [
                              Text(
                                AppString.quickShareTo,
                                style: fontStyleBold13.apply(
                                  color: AppColors.whiteColor,
                                ),
                              ),
                              Flexible(
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.socialIcons.length,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Dimensions.w10),
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                    onTap: () {
                                      controller.progress.value = 0.0;
                                      controller.currentLoadingStep.value =
                                          AppString.generatingYourSalesLink;
                                      controller.isDialogOpened = true;
                                      controller.animateProgress();
                                      AppUtils.showCustomDialog(
                                          onDialogCloseFunction: () {
                                            controller.isDialogOpened = false;
                                          },
                                          myWidget: Padding(
                                            padding: EdgeInsets.all(Dimensions
                                                .commonPaddingForScreen),
                                            child: Obx(
                                              () => Column(
                                                children: [
                                                  CustomAssetImage(
                                                    image: AppImages.imgLoading,
                                                    size: Dimensions.w60,
                                                  ),
                                                  SizedBox(
                                                    height: Dimensions.h10,
                                                  ),
                                                  AnimatedSwitcher(
                                                    duration: const Duration(
                                                        milliseconds: 300),
                                                    transitionBuilder:
                                                        (child, animation) {
                                                      return FadeTransition(
                                                          opacity: animation,
                                                          child: child);
                                                    },
                                                    child: Text(
                                                      controller
                                                          .currentLoadingStep
                                                          .value,
                                                      key: ValueKey(controller
                                                          .currentLoadingStep
                                                          .value),
                                                      style:
                                                          fontStyleBold16.apply(
                                                              color: AppColors
                                                                  .hintColor),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: Dimensions.h10,
                                                  ),
                                                  TweenAnimationBuilder<double>(
                                                    tween: Tween<double>(
                                                      begin: 0,
                                                      end: controller
                                                          .progress.value,
                                                    ),
                                                    duration: const Duration(
                                                        milliseconds: 500),
                                                    builder: (context, value,
                                                        child) {
                                                      return LinearProgressIndicator(
                                                        value: value,
                                                        color: AppColors
                                                            .primaryColor,
                                                        minHeight:
                                                            Dimensions.h12,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    Dimensions
                                                                        .r12),
                                                      );
                                                    },
                                                  )
                                                ],
                                              ),
                                            ),
                                          ));
                                    },
                                    child: Row(
                                      children: [
                                        CustomAssetImage(
                                          image: controller.socialIcons[index],
                                          size: Dimensions.w30,
                                        ),
                                        SizedBox(
                                          width: Dimensions.w10,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
