import 'package:flutter/material.dart';
import 'package:Brandie/core/basic_features.dart';
import 'package:Brandie/core/widgets/custom_image.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'controllers/bottom_nav_controller.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: BottomNavController(),
        tag: AppString.bottomNavControllerTag,
        builder: (controller) => Obx(
              () => Scaffold(
                extendBody: true,
                body: controller.screens[controller.selectedScreenIndex.value],
                bottomNavigationBar: controller.showBottomNav.value
                    ? SizedBox(
                        width: Get.width,
                        child: Container(
                          padding: EdgeInsets.only(bottom: Dimensions.h10),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withValues(alpha: 0.4),
                                Colors.black.withValues(alpha: 0.2),
                                Colors.black.withValues(alpha: 0.0),
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          child: SafeArea(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                controller.icons.length,
                                (index) => buildBottomBarItem(
                                  controller.icons[index],
                                  controller.selectedScreenIndex.value == index,
                                  () => controller.selectedScreenIndex.value =
                                      index,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : null,
              ),
            ));
  }

  Widget buildBottomBarItem(String icon, bool selected, VoidCallback onTap) {
    return SizedBox(
      width: Get.width / 5,
      height: Dimensions.h40,
      child: Center(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(Dimensions.r50),
          child: AnimatedContainer(
            duration: 200.ms,
            decoration: BoxDecoration(
              color: selected ? AppColors.primaryColor : Colors.transparent,
              borderRadius: BorderRadius.circular(Dimensions.r50),
            ),
            child: Padding(
              padding: EdgeInsets.all(Dimensions.w10),
              child: CustomSvgAssetImage(
                image: icon,
                size: Dimensions.w28,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
