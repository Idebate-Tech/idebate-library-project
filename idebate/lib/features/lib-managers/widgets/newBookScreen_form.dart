import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:idebate/features/authentication/controllers/signup/signup_controller.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
// import 'package:realm/realm.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../common/widgets/login_signup/form_divider.dart';
import '../../../../utils/validators/validation.dart';
import '../../../common/styles/spacing_styles.dart';
import '../../activities/controllers/gsheet_controller.dart';
import '../../activities/models/hive_cache_model_file.dart';
// import '../../activities/models/realm_local_storage.dart';

final _formKey = GlobalKey<FormState>();
final booksBox = Hive.box<Book>('booksBox');
final userBox = Hive.box<User>('userBox');
final borrowedBox = Hive.box<Borrowed>('borrowedBox');
final pendingReturnBox = Hive.box<PendingReturn>('pendingReturnBox');

final person = userBox.values;
// final books = borrowedBox.values;

// final String fullName = '${person.first.firstName} ${person.first.lastName}';
// final String email = person.first.email ;
// final String phoneNumber = person.first.phoneNumber;
// final String id = person.first.id;

class NewBookScreenForm extends StatefulWidget {
  const NewBookScreenForm({super.key, this.scannedCode, this.title, this.subject,});

  _NewBookScreenFormState createState() => _NewBookScreenFormState();
  final String? scannedCode;
  final String? title;
  final String? subject;
}

class _NewBookScreenFormState extends State<NewBookScreenForm>
{
  String isbn = "ISBN";
  String bookTitle = "";
  String bookSubject = "Children and Primary";
  String bookPublisher = "";
  String bookPublished = "";
  String bookQty = "";
  @override
  Widget build(BuildContext context) {
    String date = DateFormat('dd-MM-yyyy').format(DateTime.now());
    final controller = Get.put(SignupController());
    var datePickerController = TextEditingController();
    return Form(
        key: _formKey,
        child: Column(
          children: [
            /// Subject
             DropdownButtonFormField<String>(
                hint: const Text("Subjects"),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.archive_book),
                ),
                value: bookSubject,
                items: [
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
                    bookSubject = newValue!;
                  });
                },
              ),
            const SizedBox(height: TSizes.spaceBtwInputFields/2),

            /// ISBN
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("ISBN", style: Theme.of(context).textTheme.bodySmall),
                TextFormField(
                  expands: false,
                  readOnly: true,
                  // validator: (value) => TValidator.validateIsbn(value),
                  decoration: InputDecoration(
                      hintText: isbn ?? "Isbn",
                      prefixIcon: const Icon(Iconsax.book)),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields/2),
            /// Title
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Book name", style: Theme.of(context).textTheme.bodySmall),
                TextFormField(
                  controller: TextEditingController(),
                  validator: (value) => TValidator.validateBookTitle(value),
                  expands: false,
                  onChanged: (val)
                  {
                    bookTitle = val;
                  },
                  decoration:  InputDecoration(
                      prefixIcon: const Icon(Iconsax.book)),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields/2),

            /// Publisher
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Publisher", style: Theme.of(context).textTheme.bodySmall),
                TextFormField(
                  controller: TextEditingController(),
                  validator: (value) => TValidator.validateBookPublisher(value),
                  expands: false,
                  onChanged: (val)
                  {
                    bookPublisher = val;
                  },
                  decoration:  InputDecoration(

                      prefixIcon: const Icon(Iconsax.book)),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields/2),
            /// Published and return Total Qty
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Publishing year", style: Theme.of(context).textTheme.bodySmall),
                      TextFormField(
                        controller: TextEditingController(),
                        validator: (value) => TValidator.validateBookPublished(value),
                        expands: false,
                        onChanged: (val)
                        {
                          bookPublished = val;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
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
                      Text("Total Qty", style: Theme.of(context).textTheme.bodySmall),
                      TextFormField(
                        controller: TextEditingController(),
                        validator: (value) => TValidator.validateBookQty(value),
                        expands: false,
                        onChanged: (val)
                        {
                          bookQty = val;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Iconsax.code)),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSections),


            ///   Divider
            TFormDivider(dividerText: TTexts.scanCode),
            const SizedBox(height: TSizes.spaceBtwSections),

            ///   Scan Button
            SizedBox(width: double.infinity, child: OutlinedButton(onPressed: () {scanBarcode(context);}, child: Text(TTexts.scanCode))),
            const  SizedBox(height: TSizes.spaceBtwSections),

            ///   Submit button
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {submitBook(bookSubject,isbn, bookTitle, bookPublisher, bookPublished, bookQty);},
                child: Text(TTexts.submit))),
            const SizedBox(height: TSizes.spaceBtwSections),
          ],
        )
    );
  }

  AwesomeDialog popUpBookNotFoundScreen(BuildContext context) {
    return AwesomeDialog(
      context: context,
      width: 500,
      headerAnimationLoop: false,
      dialogType: DialogType.noHeader,
      title: TTexts.bookNotFound,
      desc: TTexts.bookNotFoundMessage,
      btnOkColor: Colors.redAccent,
      btnOkText: TTexts.close,
      btnOkOnPress: () => {},
    );
  }

  AwesomeDialog notOnlineMessage(BuildContext context) {
    return AwesomeDialog(
      context: context,
      width: 500,
      headerAnimationLoop: false,
      dialogType: DialogType.noHeader,
      title: TTexts.notOnline,
      desc: TTexts.notOnlineSub,
      btnOkColor: Colors.redAccent,
      btnOkText: TTexts.close,
      btnOkOnPress: () => {},
    );
  }

  /// scan barcode
  Future<void> scanBarcode(BuildContext context) async
  {
    String? res;
    String barcodeScanRes = '';
    try{
      res = await SimpleBarcodeScanner.scanBarcode(
        context,
        barcodeAppBar: const BarcodeAppBar(
          appBarTitle: 'Test',
          centerTitle: false,
          enableBackButton: true,
          backButtonIcon: Icon(Icons.arrow_back_ios),
        ),
        isShowFlashIcon: true,
        delayMillis: 5,
        cameraFace: CameraFace.back,
        scanFormat: ScanFormat.ONLY_BARCODE,
      );
      setState(() {
        barcodeScanRes = res as String;
      });
    } on PlatformException
    {
      barcodeScanRes = 'failed';
    }
    setState(() => isbn = barcodeScanRes);
  }


  AwesomeDialog validationIssuesScreen(BuildContext context) {
    return AwesomeDialog(
      context: context,
      width: 500,
      headerAnimationLoop: false,
      dialogType: DialogType.noHeader,
      title: TTexts.validationIssue,
      desc: TTexts.validationIssueSub,
      btnOkColor: Colors.redAccent,
      btnOkText: TTexts.close,
      btnOkOnPress: () => {},
    );
  }

  Future<void> submitBook(String bookSubject,String isbn, String bookTitle,String  bookPublisher, String bookPublished,String  bookQty) async
  {
    if (!_formKey.currentState!.validate()) {
      // Show validation dialog if form validation fails
      validationIssuesScreen(context).show();
      return;
    }

    try{
      if(bookTitle == "" )
      {
        popUpBookNotFoundScreen(context).show();
      }
      else
      {
        addNewBook(bookSubject,isbn,bookTitle, bookPublisher, bookPublished, bookQty);
      }
    }

    catch (e)
    {
      notOnlineMessage(context).show();
    }
  }

}