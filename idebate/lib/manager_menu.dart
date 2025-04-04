import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:idebate/features/activities/screens/profile.dart';
import 'package:idebate/features/lib-managers/newBookScreen.dart';
import 'package:idebate/features/lib-managers/returnScreen.dart';
import 'package:idebate/utils/constants/colors.dart';
import 'package:idebate/utils/constants/text_strings.dart';
import 'package:idebate/utils/helpers/helper_functions.dart';

class ManagerMenu extends StatelessWidget {
  const ManagerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ManagerController());
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
            NavigationDestination(icon: const  Icon(Iconsax.directbox_send), label: "return"),
            NavigationDestination(icon: const  Icon(Iconsax.book), label: "new"),
            NavigationDestination(icon: const Icon(Iconsax.user), label:TTexts.profile ),
          ],
        ),
      ),

      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class ManagerController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens  = [const ReturnedScreen(), const NewBookScreen(),const ProfileScreen()];
}

//const BorrowScreen(),