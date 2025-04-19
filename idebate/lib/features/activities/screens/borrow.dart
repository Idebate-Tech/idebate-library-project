import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:idebate/common/styles/spacing_styles.dart';
// import 'package:idebate/features/activities/models/realm_local_storage.dart';
import 'package:idebate/features/activities/screens/widgets/activities_appbar.dart';
import 'package:idebate/features/activities/screens/widgets/borrow_form.dart';
import 'package:idebate/utils/constants/text_strings.dart';
import 'package:intl/intl.dart';
// import 'package:realm/realm.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../common/widgets/custom_shapes/containers/header_text_container.dart';
import '../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../models/hive_cache_model_file.dart';

// var config = Configuration.local([Profile.schema, Book.schema]);
// var realm = Realm(config);
//  RealmResults<Profile> person = realm.all<Profile>();
//  RealmResults<Book> book = realm.all<Book>();
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

class BorrowScreen extends StatefulWidget {
  const BorrowScreen({super.key});
  @override
  _BorrowScreenState createState() => _BorrowScreenState();
}

class _BorrowScreenState extends State<BorrowScreen>
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
                    HeaderText(title: TTexts.homeAppbarTitle, subTitle: TTexts.homeAppbarSubTitle)

                  ],
                ),
              ),

              Padding(
                padding: TSpacingStyle.paddingWithAppBarHeight,
                child: Column(
                  children: [
                    ///   Borrow Form
                     BorrowForm(scannedCode:isbn, title: bookTitle, subject: bookSubject),

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




