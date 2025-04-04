import 'package:flutter/material.dart';
import '../../../../common/styles/spacing_styles.dart';


class TLibraryMenu extends StatelessWidget {
  const TLibraryMenu({
    super.key, required this.title, required this.value, required this.onPressed,
  });

  final String title, value;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: TSpacingStyle.paddingWithAppBarHeight / 7,
        child: Row(
          children: [
            Expanded(flex: 3,child: Text("   $title", style: Theme.of(context).textTheme.headlineSmall, overflow: TextOverflow.ellipsis)),
            Expanded(flex: 5,child: Text(value, style: Theme.of(context).textTheme.bodyLarge, overflow: TextOverflow.ellipsis)),
          ],
        ),
      ),
    );
  }
}