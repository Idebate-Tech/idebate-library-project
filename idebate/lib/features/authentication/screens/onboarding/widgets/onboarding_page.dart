import 'package:flutter/material.dart';
import '../../../../../utils/constants/sizes.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key, required this.image, required this.title, required this.subTitle, required this.width, required this.height,
  });

  final String image, title, subTitle;
  final double  width, height;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        children: [
          const SizedBox(height: TSizes.spaceBtwItems * 6),
          Image(
              width: width,
              height: height,
              image: AssetImage(image)
          ),
          Text(title, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
          const SizedBox(height: TSizes.spaceBtwItems),
          Text(subTitle, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}