import 'package:flutter/material.dart';
import '../../../../../utils/constants/images_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class TLoginHeader extends StatelessWidget {
  const TLoginHeader({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(
          height: 100,
          image: AssetImage(dark? TImages.darkAppLogo : TImages.lightAppLogo),
        ),

        Text(TTexts.loginTitle, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: TSizes.sm),
        Text(TTexts.loginSubTitle, style: Theme.of(context).textTheme.headlineMedium),
      ],
    );
  }
}