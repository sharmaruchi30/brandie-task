import 'package:Brandie/core/basic_features.dart';
import 'package:Brandie/core/widgets/custom_image.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showLeadingIcon;
  final String? leadingIconName;
  final Widget? leadingIcon;
  final bool showTrailingIcon;
  final String? trailingIconName;
  final Widget? trailingIcon;

  const CustomAppBar(
      {super.key,
      this.showLeadingIcon = true,
      this.leadingIconName,
      this.leadingIcon,
      this.showTrailingIcon = true,
      this.trailingIconName,
      this.trailingIcon});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: Dimensions.commonPaddingForScreen),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomAssetImage(
              image: AppImages.imgAiAssistant,
              size: Dimensions.w60,
            ),
            CustomAssetImage(
              image: AppImages.imgOriflameSweden,
              size: Dimensions.w120,
            ),
            CustomAssetImage(
              image: AppImages.imgCamera,
              size: Dimensions.w60,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
