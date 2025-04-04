import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idebate/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:idebate/features/authentication/screens/onboarding/widgets/onboarding_Next_Button.dart';
import 'package:idebate/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:idebate/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:idebate/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:idebate/utils/constants/images_strings.dart';
import 'package:idebate/utils/helpers/helper_functions.dart';
import '../../../../utils/constants/text_strings.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: Stack(
        children: [
          /// Horizontal scrollable Pages
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: [
              OnBoardingPage(
                  image: dark ? TImages.onBoardingImage1 : TImages.onBoardingImage11,
                  title: TTexts.onBoardingTitle1,
                  subTitle: TTexts.onBoardingSubTitle1,
                  width: THelperFunctions.screenWidth() * 0.7,
                  height: THelperFunctions.screenHeight() * 0.5),
              OnBoardingPage(
                  image: dark ? TImages.onBoardingImage2 : TImages.onBoardingImage22,
                  title: TTexts.onBoardingTitle2,
                  subTitle: TTexts.onBoardingSubTitle2,
                  width: THelperFunctions.screenWidth() * 0.7,
                  height: THelperFunctions.screenHeight() * 0.5
              ),
              OnBoardingPage(
                  image: dark ? TImages.onBoardingImage3 : TImages.onBoardingImage33,
                  title: TTexts.onBoardingTitle3,
                  subTitle: TTexts.onBoardingSubTitle3,
                  width: THelperFunctions.screenWidth() * 0.8,
                  height: THelperFunctions.screenHeight() * 0.6
              ),
            ],
          ),

          /// Skip Button
          const OnboardingSkip(),

          /// Dot Navigation SmoothPageIndicator
        const  OnboardingDotNavigation(),

          /// Circular Button
         const OnboardingNextButton()
        ],
      ),
    );
  }
}




