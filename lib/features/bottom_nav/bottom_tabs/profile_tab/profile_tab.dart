import 'package:flutter/material.dart';
import 'package:Brandie/core/basic_features.dart';

import '../../../../core/widgets/custom_app_bar.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Center(
        child: Text("Profile Tab", style: fontStyleBold16,),
      ),
    );
  }
}
