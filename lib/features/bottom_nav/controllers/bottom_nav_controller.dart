import 'package:get/get.dart';

import '../../../core/constants/app_images.dart';

class BottomNavController extends GetxController{
  final List<String> icons = const [
    AppImages.icPost,
    AppImages.icSearch,
    AppImages.icHome,
    AppImages.icChat,
    AppImages.icProfile,
  ];
}