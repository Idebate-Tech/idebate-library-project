import 'package:flutter/material.dart';
import 'package:idebate/utils/constants/images_strings.dart';
import '../../../../common/widgets/appBar/appbar.dart';


class TActivitiesAppBar extends StatelessWidget {
  const TActivitiesAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const TAppBar(
      title:
        Column(
          children: [
            Image(image: AssetImage(TImages.lightAppLogo), width: 58,)
          ],
        ),
    );
  }
}