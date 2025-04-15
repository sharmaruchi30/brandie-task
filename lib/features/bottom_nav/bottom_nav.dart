import 'package:flutter/material.dart';
import 'package:project_name_here/core/basic_features.dart';
import 'package:project_name_here/core/widgets/custom_image.dart';

import 'controllers/bottom_nav_controller.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: BottomNavController(),
        builder: (controller) => Scaffold(
              bottomNavigationBar: SizedBox(
                width: Get.width,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
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
                        (index) => buildBottomBarItem(controller.icons[index]),
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }

  Widget buildBottomBarItem(String icon) {
    return SizedBox(
      width: Get.width / 5,
      height: Dimensions.h40,
      child: Center(
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(Dimensions.r50),
          child: Padding(
            padding: EdgeInsets.all(Dimensions.w10),
            child: CustomSvgAssetImage(
              image: icon,
              size: Dimensions.w28,
            ),
          ),
        ),
      ),
    );
  }
}
