import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
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
import '../../../authentication/controllers/signup/signup_controller.dart';
import '../../controllers/gsheet_controller.dart';
import '../../models/hive_cache_model_file.dart';
// import '../../models/realm_local_storage.dart';

final _formKey = GlobalKey<FormState>();

// var config = Configuration.local([Profile.schema, Book.schema]);
// var realm = Realm(config);
// RealmResults<Profile> person = realm.all<Profile>();
// RealmResults<Book> book = realm.all<Book>();
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

class BorrowForm extends StatefulWidget {
  const BorrowForm({super.key, this.scannedCode, this.title, this.subject,});

  _BorrowFormState createState() => _BorrowFormState();
  final String? scannedCode;
  final String? title;
  final String? subject;
}

class _BorrowFormState extends State<BorrowForm>
{
  String isbn = "";
  String bookTitle = "";
  String bookSubject = "";
  String returnDate = "";
  @override
  Widget build(BuildContext context) {
    String date = DateFormat('dd-MM-yyyy').format(DateTime.now());
    final controller = Get.put(SignupController());
    var datePickerController = TextEditingController();
    return Form(
      key: _formKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(TTexts.firstName, style: Theme.of(context).textTheme.bodySmall),
                      TextFormField(
                        expands: false,
                        readOnly: true,
                        decoration:  InputDecoration(
                            hintText: person.first.firstName,
                            prefixIcon: const Icon(Iconsax.user)),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: TSizes.spaceBtwInputFields),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(TTexts.lastName, style: Theme.of(context).textTheme.bodySmall),
                      TextFormField(
                        expands: false,
                        readOnly: true,
                        decoration: InputDecoration(
                            hintText: person.first.lastName,
                            prefixIcon: const Icon(Iconsax.user)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields/2),

            /// ID
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(TTexts.ID, style: Theme.of(context).textTheme.bodySmall),
                TextFormField(
                  expands: false,
                  readOnly: true,
                  decoration:  const InputDecoration(
                      hintText: "****************",
                      prefixIcon: Icon(Iconsax.card)),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields/2),

            /// bookName
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(TTexts.bookName, style: Theme.of(context).textTheme.bodySmall),
                TextFormField(
                  expands: false,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: bookTitle ?? '',
                      prefixIcon: const Icon(Iconsax.book)),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields/2),
            /// Subject
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Subject', style: Theme.of(context).textTheme.bodySmall),
                TextFormField(
                  expands: false,
                  readOnly: true,
                  decoration:  InputDecoration(
                    hintText: bookSubject ?? '',
                      prefixIcon: const Icon(Iconsax.book)),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields/2),

            /// ISBN and return Date
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(TTexts.ISBN, style: Theme.of(context).textTheme.bodySmall),
                      TextFormField(
                        expands: false,
                        readOnly: true,
                        decoration: InputDecoration(
                            hintText: isbn ?? TTexts.ISBN,
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
                      Text(TTexts.pickDate, style: Theme.of(context).textTheme.bodySmall),
                      TextFormField(
                        controller: datePickerController,
                        expands: false,
                        readOnly: true,
                        validator: (value) => TValidator.validateEmptyText("Date",returnDate),
                        decoration: InputDecoration(
                            hintText: returnDate ?? "",
                            prefixIcon: IconButton(onPressed: () async {
                              DateTime? pickDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2024),
                                  lastDate: DateTime(2100));
                              // if(pickDate != null)
                              //   {
                                  setState(()
                                  {
                                    returnDate = DateFormat('dd-MM-yyyy').format(pickDate!);
                                  });
                                // }
                            }, icon: const Icon(Iconsax.calendar))),
                      ),
                    ],
                  ),
                ),
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
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {submitBook(isbn, bookSubject, bookTitle, fullName, email, id, phoneNumber, date, context,returnDate);},
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

    final book = await findBookByISBN(barcodeScanRes, context);
    var split = book?.split('+');
    setState(() => isbn = barcodeScanRes);
    setState(() => bookTitle = split![0]);
    setState(() => bookSubject = split![1]);
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

  Future<void> submitBook(String isbn, String bookSubject, String bookTitle, String fullName, String email, String id, String phoneNumber, String date, BuildContext context, String returnDate) async
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
        addBorrowedRow(isbn, bookSubject, bookTitle, fullName, email, id, phoneNumber, date, context,returnDate);
      }
    }

    catch (e)
    {
      notOnlineMessage(context).show();
    }
  }

}