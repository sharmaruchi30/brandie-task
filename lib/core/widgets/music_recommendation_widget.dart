import 'package:Brandie/core/basic_features.dart';
import 'package:Brandie/core/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MusicRecommendationWidget extends StatelessWidget {
  final String title;
  final String by;
  final VoidCallback onMusic;

  const MusicRecommendationWidget({
    super.key,
    required this.title,
    required this.by,
    required this.onMusic,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      margin: EdgeInsets.symmetric(horizontal: Dimensions.w10),
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.w15, vertical: Dimensions.w10),
      decoration: BoxDecoration(
          color: AppColors.blackColor.withValues(alpha: 0.25),
          borderRadius: BorderRadius.circular(Dimensions.r8)),
      child: Row(
        children: [
          Flexible(
            child: Row(
              children: [
                CustomSvgAssetImage(
                  image: AppImages.icMusic,
                  size: Dimensions.w20,
                  onTap: onMusic,
                ),
                SizedBox(
                  width: Dimensions.w10,
                ),
                Text(
                  "${AppString.recommended} : ",
                  style: fontStyleRegular12.apply(color: Colors.white),
                ),
                Text(
                  title,
                  style: fontStyleBold12.apply(color: Colors.white),
                ),
                Text(
                  " ${AppString.by} $by ",
                  style: fontStyleRegular12.apply(color: Colors.white),
                ),
              ],
            ),
          ),
          Lottie.asset(AppImages.animAudioWave,
              repeat: true, height: Dimensions.h20)
        ],
      ),
    );
  }
}
