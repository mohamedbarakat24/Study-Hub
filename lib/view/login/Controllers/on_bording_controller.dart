import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_hub/view/Screens/homescreen.dart';

class OnBordingController extends GetxController {
  static OnBordingController get instance => Get.find();

  final Pagecontroller = PageController();
  Rx<int> current_index = 0.obs;

  void UpdatePageIndicator(index) => current_index.value = index;

  void DotNavigationClick(index) {
    current_index.value = index;
    Pagecontroller.jumpTo(index);
  }

  void NextPage() {
    if (current_index.value == 2) {
      Get.offAll(HomeScreen());
    } else {
      int page = current_index.value + 1;
      Pagecontroller.jumpToPage(page);
    }
  }

  void SkipPage() {
    current_index.value = 2;
    Pagecontroller.jumpTo(0);
  }
}
