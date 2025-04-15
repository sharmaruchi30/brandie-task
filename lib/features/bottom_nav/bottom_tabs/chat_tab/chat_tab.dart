import 'package:flutter/material.dart';
import 'package:Brandie/core/basic_features.dart';

import '../../../../core/widgets/custom_app_bar.dart';

class ChatTab extends StatelessWidget {
  const ChatTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Center(
        child: Text(
          "Chat Tab",
          style: fontStyleBold16,
        ),
      ),
    );
  }
}
