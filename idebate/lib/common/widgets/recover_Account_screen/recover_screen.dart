import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idebate/features/authentication/screens/login/login.dart';
import 'package:idebate/utils/constants/sizes.dart';
import 'package:idebate/utils/helpers/helper_functions.dart';
import '../../../features/activities/controllers/gsheet_controller.dart';
import '../../../utils/constants/images_strings.dart';
import '../../../utils/constants/text_strings.dart';

class RecoverScreen extends StatelessWidget {
  const RecoverScreen({super.key, required this.name, required this.id, required this.email});

  final String name, id,email;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   actions: [
      //     IconButton(onPressed: () => Get.offAll(() => const LoginScreen()), icon: const Icon(CupertinoIcons.clear))
      //   ],
      // ),
      body: SingleChildScrollView(
        child:
        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              const SizedBox(height: TSizes.spaceBtwSections*4),
              /// Image
              Image(
                image: AssetImage(dark ? TImages.verifyEmail1 : TImages.verifyEmail11),
                width: THelperFunctions.screenWidth() * 0.6,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Tittle & SubTitle
              Text(TTexts.recoverAccount, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text("name: $name", style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.left),
              Text("Email: $email", style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.left),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(TTexts.recoverAccountSub, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Buttons
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => recoverAccount(context,id), child: Text(TTexts.recover))),
            ],
          ),

        ),
      ),
    );
  }
}


