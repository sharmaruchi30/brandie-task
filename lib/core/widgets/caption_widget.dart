import 'package:Brandie/core/basic_features.dart';
import 'package:Brandie/core/widgets/custom_image.dart';
import 'package:Brandie/features/bottom_nav/bottom_tabs/home_tab/home_tabs/smart_post/smart_post_screens/edit_caption_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CaptionWidget extends StatefulWidget {
  final String text;

  const CaptionWidget({
    super.key,
    required this.text,
  });

  @override
  State<CaptionWidget> createState() => _CaptionWidgetState();
}

class _CaptionWidgetState extends State<CaptionWidget> {
  bool isExpanded = false;
  static const int trimLines = 2;

  @override
  Widget build(BuildContext context) {
    final textStyle = fontStyleMedium12.apply(color: AppColors.whiteColor);
    final textSpan = TextSpan(text: widget.text, style: textStyle);
    final tp = TextPainter(
      text: textSpan,
      maxLines: trimLines,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: Get.width - (Dimensions.w10 * 2 + Dimensions.w15 * 2));

    final isOverflowing = tp.didExceedMaxLines;

    return AnimatedContainer(
      duration: 200.ms,
      width: Get.width,
      margin: EdgeInsets.symmetric(horizontal: Dimensions.w10),
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.w15,
        vertical: Dimensions.w10,
      ),
      decoration: BoxDecoration(
        color: AppColors.blackColor.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(Dimensions.r8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.text,
            maxLines: isExpanded ? null : trimLines,
            overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
            style: textStyle,
          ),
          if (isOverflowing)
            InkWell(
              onTap: () {
                setState(() => isExpanded = !isExpanded);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  isExpanded ? AppString.readLess.tr : AppString.readMore.tr,
                  style: fontStyleMedium10.apply(color: AppColors.primaryColor),
                ),
              ),
            ),
          if (isExpanded)
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(top: Dimensions.h8),
                child: InkWell(
                  onTap: () => Get.to(() => EditCaptionScreen(
                        text: widget.text,
                      )),
                  borderRadius: BorderRadius.circular(Dimensions.r12),
                  child: Row(
                    children: [
                      CustomSvgAssetImage(
                        image: AppImages.icEdit,
                        size: Dimensions.w22,
                      ),
                      SizedBox(
                        width: Dimensions.w5,
                      ),
                      Text(
                        AppString.editCaption,
                        style: fontStyleMedium14.apply(
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
