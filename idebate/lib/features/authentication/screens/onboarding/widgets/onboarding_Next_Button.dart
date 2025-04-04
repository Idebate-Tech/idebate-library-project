import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:idebate/features/authentication/controllers/onboarding/onboarding_controller.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device-utility.dart';

class OnboardingNextButton extends StatelessWidget {
  const OnboardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(right: TSizes.defaultSpace, bottom: TDeviceUtils.getBottomNavigationBarHeight(), child: ElevatedButton(
      onPressed: () => OnboardingController.instance.nextPage(),
      style: ElevatedButton.styleFrom(shape: const CircleBorder()),
      child: const Icon(Iconsax.arrow_right_3),
    ));
  }
}