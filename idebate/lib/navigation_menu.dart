import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:idebate/features/activities/screens/book_list.dart';
import 'package:idebate/features/activities/screens/profile.dart';
import 'package:idebate/utils/constants/colors.dart';
import 'package:idebate/utils/constants/text_strings.dart';
import 'package:idebate/utils/helpers/helper_functions.dart';
import 'features/activities/screens/borrow.dart';
import 'features/activities/screens/return.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          backgroundColor: TColors.primary,
          indicatorColor: dark ? TColors.white.withOpacity(0.1) : TColors.black.withOpacity(0.1),
          
          
          destinations: [
            NavigationDestination(icon: const  Icon(Iconsax.directbox_send), label: TTexts.borrow),
            NavigationDestination(icon: const  Icon(Iconsax.directbox_receive), label: TTexts.bringBack),
            const NavigationDestination(icon:  Icon(Iconsax.book), label: "Books"),
            NavigationDestination(icon: const Icon(Iconsax.user), label:TTexts.profile ),
          ],
        ),
      ),

      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens  = [const BorrowScreen(), const ReturnScreen(), const LibraryScreen(),const ProfileScreen()];
}

//const BorrowScreen(),