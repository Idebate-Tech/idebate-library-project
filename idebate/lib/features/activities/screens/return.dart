import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:idebate/features/activities/screens/widgets/activities_appbar.dart';
import 'package:idebate/features/activities/screens/widgets/return_form.dart';
import 'package:intl/intl.dart';
// import 'package:realm/realm.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../common/styles/spacing_styles.dart';
import '../../../common/widgets/custom_shapes/containers/header_text_container.dart';
import '../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../authentication/screens/login/widgets/login_form.dart';
import '../controllers/gsheet_controller.dart';
import '../models/hive_cache_model_file.dart';
// import '../models/realm_local_storage.dart';


// var config = Configuration.local([Book.schema, Profile.schema]);
// var realm = Realm(config);
// RealmResults<Book> book = realm.all<Book>();
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
// final String fullName = '${person.first.firstName} ${person.first.lastName}';
// final String email = person.first.email ;
// final String phoneNumber = person.first.phoneNumber;
// final String id = person.first.id;
String date = DateFormat('dd-MM-yyyy').format(DateTime.now());

class ReturnScreen extends StatefulWidget {
  const ReturnScreen({super.key});
  @override
  _ReturnScreenState createState() => _ReturnScreenState();
}

class _ReturnScreenState extends State<ReturnScreen>
{
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
                    HeaderText(title: TTexts.returnAppbarTitle, subTitle: TTexts.returnAppbarSubTitle)
                  ],
                ),
              ),



              Padding(
                padding: TSpacingStyle.paddingWithAppBarHeight,
                child: Column(
                  children: [
                    ///   Return Form
                    const ReturnForm(),

                    const SizedBox(height: TSizes.spaceBtwItems),

                    ///   Submit button
                    SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {books.isEmpty ? noBookScreen(context).show() : addReturnPendingRow(books.first.isbn,books.first.subject,books.first.title,fullName,email,id,phoneNumber,date,context);}, child: Text(TTexts.submit))),
                    const SizedBox(height: TSizes.spaceBtwSections),
                  ],
                ),
              ),
            ],
          ),
      ),
    );
  }

  AwesomeDialog noBookScreen(BuildContext context) {
    return AwesomeDialog(
      context: context,
      width: 500,
      headerAnimationLoop: false,
      dialogType: DialogType.noHeader,
      title: "No book!",
      desc: " Looks like you have no book to return 🙄",
      btnCancelColor: Colors.redAccent,
      btnCancelText: TTexts.close,
      btnCancelOnPress: () => {},
    );
  }
}
