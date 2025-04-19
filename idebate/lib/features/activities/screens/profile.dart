import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hive/hive.dart';
import 'package:idebate/common/widgets/appBar/appbar.dart';
import 'package:idebate/common/widgets/custom_shapes/containers/circular_image_container.dart';
import 'package:idebate/features/activities/screens/widgets/profile_menu.dart';
import 'package:idebate/features/activities/screens/widgets/section_heading.dart';
import 'package:idebate/features/authentication/screens/login/login.dart';
import 'package:idebate/utils/constants/colors.dart';
import 'package:idebate/utils/constants/images_strings.dart';
import 'package:idebate/utils/constants/text_strings.dart';
// import 'package:realm/realm.dart';

import '../../../utils/constants/sizes.dart';
import '../models/hive_cache_model_file.dart';
// import '../models/realm_local_storage.dart';

// var config = Configuration.local([Profile.schema,Checker.schema]);
// var realm = Realm(config);
// RealmResults<Profile> person = realm.all<Profile>();
// final String fullName = '${person.first.firstName} ${person.first.lastName}';
// final String email = person.first.email ;
// final String phoneNumber = person.first.phoneNumber;
// final String id = person.first.nationalId;

final booksBox = Hive.box<Book>('booksBox');
final userBox = Hive.box<User>('userBox');
final borrowedBox = Hive.box<Borrowed>('borrowedBox');
final pendingReturnBox = Hive.box<PendingReturn>('pendingReturnBox');

final person = userBox.values;
final books = borrowedBox.values;

final String fullName = '${person.first.firstName} ${person.first.lastName}';
final String email = person.first.email ;
final String phoneNumber = person.first.phoneNumber;
final String id = person.first.id;

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(showBackArrow: false, title: Text(TTexts.profile)),

      /// -- Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const  EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Profile Picture
              const SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    TCircularImage(image: TImages.profile, width: 80, height: 80),
                    // TextButton(onPressed: (){}, child: const Text('Change Profile Picture')),
                  ],
                ),
              ),

              ///Details
              const SizedBox(height: TSizes.spaceBtwItems/ 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Heading Profile Info
              const TSectionHeading(title: "Profle Information", showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              TProfileMenu(title: 'Name', value: fullName, onPressed: () {}),
              TProfileMenu(title: 'Email', value: email, onPressed: () {}),

              const SizedBox(height: TSizes.spaceBtwItems/ 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Heading Personal Info
              const TSectionHeading(title: "Personal Information", showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              TProfileMenu(title: 'National ID', value: "****************", onPressed: () {}),
              TProfileMenu(title: 'Phone Number', value: phoneNumber, onPressed: () {}),
              // TProfileMenu(title: 'Gender', value: 'Male', onPressed: () {}),

              const SizedBox(height: TSizes.spaceBtwItems/ 2),
              const Divider(),

              const SizedBox(height: TSizes.spaceBtwItems),
              // /// Close Account
              // Center(
              //   child: TextButton(
              //     onPressed: () {},
              //     child: const Text('Close Account', style: TextStyle(color: Colors.red)),
              //   ),
              // ),

              const SizedBox(height: TSizes.spaceBtwSections),

              ///   Logout Button
              SizedBox(width: double.infinity, child: OutlinedButton(onPressed: () {popUpLogoutScreen(context).show();}, child: const Text('Logout'))),
              const  SizedBox(height: TSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }

  AwesomeDialog popUpLogoutScreen(BuildContext context) {
    return AwesomeDialog(
      context: context,
      width: 500,
      headerAnimationLoop: false,
      dialogType: DialogType.noHeader,
      title: "logout",
      desc: "Are you sure you want to logout? 😕",
      btnOkColor: TColors.primary,
      btnOkText: 'Logout',
      btnOkOnPress: () async => {
      // delete checker value
      // realm.write(() {
      // realm.deleteAll<Checker>();
      // })
        await userBox.clear(),
        await borrowedBox.clear(),
        await booksBox.clear(),

        print('is person empty == ${person.isEmpty}'),

        Get.offAll(() => const LoginScreen())
    },
      btnCancelColor: TColors.dark,
      btnCancelText: 'Cancel',
      btnCancelOnPress: () => {}
    );
  }
}


