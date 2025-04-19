import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idebate/features/authentication/screens/signup/signup.dart';

class OnboardingController extends GetxController {
  static OnboardingController get instance => Get.find();
  /// variable
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

 /// Update Current Index when Page Scroll
 void updatePageIndicator(index) => currentPageIndex.value = index;

  /// Jump to the specific dot selected page
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  /// Update Current Index & jump to next page
  void nextPage() {
    if(currentPageIndex.value == 2)
      {
        Get.offAll(const SignupScreen());
      }
    else
      {
        int page = currentPageIndex.value +1;
        pageController.jumpToPage(page);
      }
  }

  /// Updated Current Index & Jump to the last page
  void skipPage() {
    // currentPageIndex.value = 2;
    // pageController.jumpTo(2);
    Get.offAll(const SignupScreen());
  }
}
