import 'package:flutter/material.dart';
import 'package:idebate/features/authentication/controllers/onboarding/onboarding_controller.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/device/device-utility.dart';

class OnboardingSkip extends StatelessWidget {
  const OnboardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(top: TDeviceUtils.getAppBarHeight()+30, right: TSizes.defaultSpace, child: TextButton(onPressed: () => OnboardingController.instance.skipPage(), child: Text(TTexts.skip,style: const TextStyle(color: TColors.primary))));
  }
}