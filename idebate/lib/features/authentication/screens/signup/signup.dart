import 'package:flutter/material.dart';
import 'package:idebate/features/authentication/screens/signup/widgets/signup_form.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Tittle
            Text(TTexts.signupTitle, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: TSizes.spaceBtwSections),
            /// Form
            const TSignupForm(),
            // /// Forget Password
            // const SizedBox(height: TSizes.spaceBtwSections),
            // TextButton(onPressed: () => Get.to(() => const LoginScreen()), child: Text("Already have an account", style: const TextStyle(color: TColors.primary))),
            const SizedBox(height: TSizes.spaceBtwSections),

          ],
        ),
        ),
      ),
    );
  }
}


