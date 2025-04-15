import 'package:Brandie/core/basic_features.dart';
import 'package:Brandie/core/model/ui_model/post_ui_model.dart';
import 'package:Brandie/core/widgets/caption_widget.dart';
import 'package:Brandie/core/widgets/custom_image.dart';
import 'package:Brandie/core/widgets/post_widget.dart';
import 'package:Brandie/features/bottom_nav/bottom_tabs/home_tab/home_tabs/smart_post/controllers/smart_post_controller.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/widgets/music_recommendation_widget.dart';

class SmartPost extends StatelessWidget {
  const SmartPost({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SmartPostController(),
      builder: (controller) => PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: PostUiModel.dummyPostData.length,
        itemBuilder: (context, index) => PostWidget(
          post: PostUiModel.dummyPostData[index],
        ),
      ),
    );
  }
}
