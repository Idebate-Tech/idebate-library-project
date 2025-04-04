import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:idebate/common/styles/spacing_styles.dart';
import 'package:idebate/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:idebate/features/activities/screens/widgets/activities_appbar.dart';
import 'package:idebate/features/activities/screens/widgets/library_menu.dart';
import 'package:idebate/utils/helpers/helper_functions.dart';
import 'package:realm/realm.dart';

import '../../../common/widgets/custom_shapes/containers/header_text_container.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../controllers/gsheet_controller.dart';
import '../models/realm_local_storage.dart';

var config = Configuration.local([Profile.schema, Library.schema]);
var realm = Realm(config);
RealmResults<Profile> person = realm.all<Profile>();
RealmResults<Library> books = realm.all<Library>();

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  String _searchSubject = 'All';

  Iterable<Library> get _filteredData {
    if (_searchSubject != "All") {
      return books
          .where((data) =>
          data.subject.toLowerCase().contains(_searchSubject.toLowerCase()))
          .toList();
    }
    return books;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: Column(
        children: [
          /// --- Header Section ---
          TPrimaryHeaderContainer(
            child: Column(
              children: [
                /// App Bar (logo)
                const TActivitiesAppBar(),
                const SizedBox(height: TSizes.spaceBtwSections / 2),

                /// Header Text
                HeaderText(
                  title: "Hi ${person.first.lastName}!",
                  subTitle: "Let's find you a good book to read.",
                ),
              ],
            ),
          ),

          const SizedBox(height: TSizes.spaceBtwItems / 2),

          /// Dropdown Menu
          Padding(
            padding: TSpacingStyle.paddingWithAppBarHeight,
            child: DropdownButtonFormField<String>(
              hint: const Text("Subjects"),
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.archive_book),
              ),
              value: _searchSubject,
              items: [
                'All',
                'Children and Primary',
                'English Language Skills',
                'Fiction (Adult)',
                'Higher Education',
                'Leisure Reading',
                'Medicine and Health Care',
                'Professional (Business and Finance)',
                'Reference',
                'Secondary',
                'Teacher Training',
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _searchSubject = newValue!;
                });
              },
            ),
          ),

          /// Subject Heading
          const SizedBox(height: TSizes.spaceBtwItems / 5),
          Padding(
            padding: TSpacingStyle.paddingWithAppBarHeight / 6,
            child: TLibraryMenu(title: "Subject", value: _searchSubject, onPressed: () {}),
          ),
          const SizedBox(height: TSizes.spaceBtwItems / 8),
          const Divider(),
          const SizedBox(height: TSizes.spaceBtwItems / 8),

          /// Data Table Section
          Expanded(
            child: Padding(
              padding: TSpacingStyle.paddingWithAppBarHeight / 2,
              child: SingleChildScrollView(
                child: SizedBox(
                  width: THelperFunctions.screenWidth() * 0.9,
                  child: DataTable(
                    headingRowColor: WidgetStateColor.resolveWith(
                          (states) => TColors.primary,
                    ),
                    columns: [
                      DataColumn(
                        label: Text(
                          "Title",
                          style: ThemeData.dark().textTheme.headlineSmall,
                        ),
                      ),
                    ],
                    rows: _filteredData.map((data) {
                      return DataRow(
                          // onLongPress: () {
                          //   bookDetailsPop(context, data).show();
                          // } ,
                          cells: <DataCell>[
                        DataCell(Padding(
                          padding: TSpacingStyle.paddingWithAppBarHeight / 8,
                          child: TextButton(onPressed: () => bookLookUpByISBN(data.isbn,context), child: Text(data.title, style: TextStyle(color: dark? TColors.black : TColors.white,fontSize: 15,fontWeight: FontWeight.w200))),
                          // TextButton(onPressed: () => Get.to(() => const ForgetPassword()), child: Text(TTexts.forgetPassword, style: const TextStyle(color: TColors.primary))),
                          // child: Text(data.title),
                        )),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}