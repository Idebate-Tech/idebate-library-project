import 'package:flutter/material.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device-utility.dart';

class HeaderText extends StatelessWidget {
  const HeaderText({
    super.key, required this.title, required this.subTitle,
  });

  final String title, subTitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: TDeviceUtils.getScreenWidth(context),
      padding: const EdgeInsets.all(TSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.grey)),
          const SizedBox(height: TSizes.spaceBtwItems/2),
          Text(subTitle, style: Theme.of(context).textTheme.bodyLarge!.apply(color: TColors.grey)),
        ],
      ),

    );
  }
}