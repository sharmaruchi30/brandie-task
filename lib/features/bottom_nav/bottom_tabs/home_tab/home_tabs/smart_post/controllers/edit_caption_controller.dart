import 'package:Brandie/core/basic_features.dart';
import 'package:flutter/cupertino.dart';

class EditCaptionController extends GetxController {
  final TextEditingController captionController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  String oldText = '';
  RxBool isTextChanged = false.obs;

  @override
  void onInit() {
    AppUtils.goFullScreen();
    focusNode.requestFocus();
    captionController.addListener(
      () => captionController.text != oldText
          ? isTextChanged.value = true
          : isTextChanged.value = false,
    );
    super.onInit();
  }
}
