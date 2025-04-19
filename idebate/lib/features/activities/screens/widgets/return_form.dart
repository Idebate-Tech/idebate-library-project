import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
// import 'package:realm/realm.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../models/hive_cache_model_file.dart';
// import '../../models/realm_local_storage.dart';


// var config = Configuration.local([Book.schema, Profile.schema]);
// var realm = Realm(config);
// RealmResults<Book> book = realm.all<Book>();

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

String title = "Tittle";
String subject = "Subject";
String isbn = "ISBN";




class ReturnForm extends StatefulWidget {
  const ReturnForm({super.key,});

  _ReturnFormState createState() => _ReturnFormState();
}

class _ReturnFormState extends State<ReturnForm>
{
  @override
  Widget build(BuildContext context) {
    if(books.isNotEmpty)
      {
        title = books.first.title;
        subject = books.first.subject;
        isbn = books.first.isbn;
      }
    String date = DateFormat('dd-MM-yyyy').format(DateTime.now());
    return Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
          child: Column(
            children: [
              /// BookName
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(TTexts.bookName, style: Theme.of(context).textTheme.bodySmall),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: title ?? '',
                        prefixIcon: const Icon(Iconsax.book)),
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),


              /// Subject
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Subject', style: Theme.of(context).textTheme.bodySmall),
                  TextFormField(
                    expands: false,
                    decoration: InputDecoration(
                      hintText: subject ?? '',
                        prefixIcon: const Icon(Iconsax.book)),
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(TTexts.ISBN, style: Theme.of(context).textTheme.bodySmall),
                        TextFormField(
                          expands: false,
                          decoration: InputDecoration(
                            hintText: isbn ?? '',
                              prefixIcon: const Icon(Iconsax.code)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: TSizes.spaceBtwInputFields),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(TTexts.returnDate, style: Theme.of(context).textTheme.bodySmall),
                        TextFormField(
                          expands: false,
                          readOnly: true,
                          decoration: InputDecoration(
                              hintText: date,
                              prefixIcon: IconButton(onPressed: () {}, icon: const Icon(Iconsax.calendar))),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
    );
  }
}