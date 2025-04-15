import 'package:Brandie/core/basic_features.dart';
import 'package:Brandie/core/widgets/custom_button.dart';
import 'package:Brandie/core/widgets/custom_image.dart';
import 'package:Brandie/features/bottom_nav/bottom_tabs/home_tab/home_tabs/smart_post/controllers/edit_caption_controller.dart';
import 'package:flutter/material.dart';

class EditCaptionScreen extends StatelessWidget {
  final String text;

  const EditCaptionScreen({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: EditCaptionController()
        ..captionController.text = text
        ..oldText = text,
      builder: (controller) => PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) {
            AppUtils.exitFullScreen();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leadingWidth: Dimensions.w60,
            leading: Center(
              child: InkWell(
                onTap: () => Get.back(),
                borderRadius: BorderRadius.circular(Dimensions.r50),
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.r8),
                  child: CustomSvgAssetImage(
                    image: AppImages.icCross,
                    size: Dimensions.w28,
                  ),
                ),
              ),
            ),
            title: Text(
              AppString.editCaption,
              style: fontStyleMedium22,
            ),
            actions: [
              Obx(
                () => MyButton(
                  height: Dimensions.h20,
                  onPressed: controller.isTextChanged.value
                      ? () {
                          AppUtils.closeKeyboard();
                          Get.back();
                          AppUtils.showSnackBar(
                              message:
                                  "Your Caption has been saved successfully",
                              isSuccess: true);
                        }
                      : null,
                  title: AppString.save,
                  textStyle:
                      fontStyleMedium14.apply(color: AppColors.whiteColor),
                ),
              ),
              SizedBox(
                width: Dimensions.w10,
              )
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(Dimensions.commonPaddingForScreen),
            child: Column(
              children: [
                TextField(
                  maxLines: null,
                  // allows multiline
                  keyboardType: TextInputType.multiline,
                  focusNode: controller.focusNode,
                  controller: controller.captionController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding:
                        EdgeInsets.zero, // optional: removes default padding
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
