import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idebate/utils/constants/sizes.dart';
import 'package:idebate/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/images_strings.dart';
import '../../../../utils/constants/text_strings.dart';
import '../login/login.dart';

class PasswordRestScreen extends StatelessWidget {
  const PasswordRestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () => Get.offAll(() => const LoginScreen()), icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child:
        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Image
              Image(
                image: AssetImage(dark ? TImages.verifyEmail2 : TImages.verifyEmail22),
                width: THelperFunctions.screenWidth() * 0.6,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Tittle & SubTitle
              Text(TTexts.passwordResetSuccess, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(TTexts.passwordResetSuccessSub, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Buttons
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Get.offAll(() => const LoginScreen()), child: Text(TTexts.done))),
              const SizedBox(height: TSizes.spaceBtwItems),
              // SizedBox(width: double.infinity, child: TextButton(onPressed: () => Get.to(() => const SuccessScreen()), child: Text(TTexts.resendEmail, style: const TextStyle(color: TColors.primary),))),
            ],
          ),

        ),
      ),
    );
  }
}
