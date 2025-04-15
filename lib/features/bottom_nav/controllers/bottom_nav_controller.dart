import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_images.dart';
import '../bottom_tabs/chat_tab/chat_tab.dart';
import '../bottom_tabs/home_tab/home_tab.dart';
import '../bottom_tabs/posts_tab/posts_tab.dart';
import '../bottom_tabs/profile_tab/profile_tab.dart';
import '../bottom_tabs/search_tab/search_tab.dart';

class BottomNavController extends GetxController {
  RxInt selectedScreenIndex = 2.obs;
  RxBool showBottomNav = false.obs;

  final List<String> icons = const [
    AppImages.icPost,
    AppImages.icSearch,
    AppImages.icHome,
    AppImages.icChat,
    AppImages.icProfile,
  ];

  final List<Widget> screens = [
    const PostsTab(),
    const SearchTab(),
    const HomeTab(),
    const ChatTab(),
    const ProfileTab()
  ];

  @override
  void onInit() {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark));
    super.onInit();
  }
}
