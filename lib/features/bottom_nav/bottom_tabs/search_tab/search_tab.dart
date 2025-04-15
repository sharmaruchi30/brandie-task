import 'package:Brandie/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:Brandie/core/basic_features.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Center(
        child: Text(
          "Search Tab",
          style: fontStyleBold16,
        ),
      ),
    );
  }
}
