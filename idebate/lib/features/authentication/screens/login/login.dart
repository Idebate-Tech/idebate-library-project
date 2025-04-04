import 'package:flutter/material.dart';
import 'package:idebate/common/styles/spacing_styles.dart';
import 'package:idebate/features/authentication/screens/login/widgets/login_form.dart';
import 'package:idebate/features/authentication/screens/login/widgets/login_header.dart';
import 'package:idebate/utils/helpers/helper_functions.dart';
import '../../../../utils/constants/sizes.dart';


class LoginScreen extends StatelessWidget {
      const LoginScreen({super.key});
    
      @override
      Widget build(BuildContext context) {
        final dark = THelperFunctions.isDarkMode(context);

        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: TSpacingStyle.paddingWithAppBarHeight,
              child: Column(
                children: [


                  const SizedBox(height: TSizes.spaceBtwInputFields * 4),

                  /// logo, title and subtitle
                  TLoginHeader(dark: dark),

                  /// Form
                 const  TLoginForm(),

                 //  /// Divider
                 //  TFormDivider(dividerText: TTexts.orSignInWith.capitalize!),
                 //  const SizedBox(height: TSizes.spaceBtwSections),
                 //
                 //  /// Footer
                 // const TSocialButtons()
                ],
              ),
            ),
          )  ,
        );
      }
    }







    