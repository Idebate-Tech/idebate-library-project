import 'package:flutter/material.dart';
import 'package:idebate/common/styles/spacing_styles.dart';
import 'package:idebate/features/activities/models/realm_local_storage.dart';
import 'package:idebate/features/activities/screens/widgets/activities_appbar.dart';
import 'package:idebate/features/lib-managers/widgets/returnScreen_form.dart';
import 'package:idebate/utils/constants/text_strings.dart';
import 'package:intl/intl.dart';
import 'package:realm/realm.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../common/widgets/custom_shapes/containers/header_text_container.dart';
import '../../../common/widgets/custom_shapes/containers/primary_header_container.dart';

var config = Configuration.local([Profile.schema, Book.schema]);
var realm = Realm(config);
RealmResults<Profile> person = realm.all<Profile>();
RealmResults<Book> book = realm.all<Book>();
final String fullName = '${person.first.firstName} ${person.first.lastName}';
final String email = person.first.email ;
final String phoneNumber = person.first.phoneNumber;
final String id = person.first.nationalId;
class ReturnedScreen extends StatefulWidget {
  const ReturnedScreen({super.key});
  @override
  _ReturnedScreenState createState() => _ReturnedScreenState();
}

class _ReturnedScreenState extends State<ReturnedScreen>
{
  String isbn = "";
  String bookTitle = "";
  String bookSubject = "";

  String date = DateFormat('dd-MM-yyyy').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Header
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  /// --- App Bar (logo)---
                  const TActivitiesAppBar(),

                  const SizedBox(height: TSizes.spaceBtwSections/2),

                  /// --- Text ---
                  HeaderText(title: '"Welcome Librarian! 🧐"', subTitle: "Returning books")

                ],
              ),
            ),

            Padding(
              padding: TSpacingStyle.paddingWithAppBarHeight,
              child: Column(
                children: [
                  ///   Borrow Form
                  ReturnScreenForm(scannedCode:isbn, title: bookTitle, subject: bookSubject),

                  const SizedBox(height: TSizes.spaceBtwSections),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}




