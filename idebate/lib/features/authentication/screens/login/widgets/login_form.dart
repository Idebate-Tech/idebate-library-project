import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:iconsax/iconsax.dart';
import 'package:idebate/utils/validators/validation.dart';
// import 'package:realm/realm.dart';
import '../../../../../common/widgets/login_signup/form_divider.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../activities/controllers/gsheet_controller.dart';
// import '../../../../activities/models/realm_local_storage.dart';
import '../../../../activities/models/hive_cache_model_file.dart';
import '../../../controllers/signup/signup_controller.dart';
import '../../../encryption/encryption.dart';
import '../../password_configuration/forget_password.dart';
import '../../signup/signup.dart';

// var config = Configuration.local([Profile.schema, Checker.schema]);
// var realm = Realm(config);
// final person = realm.all<Profile>();
// final checker = realm.all<Checker>();

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

final _formKey = GlobalKey<FormState>();

class TLoginForm extends StatefulWidget {
  const TLoginForm({super.key,});

  @override
  TLoginFormState createState() => TLoginFormState();
}

class TLoginFormState extends State<TLoginForm>
{
  // bool _isChecked = false;

  // void _updateCheckerTable(bool isChecked) {
  //   if (isChecked) {
  //     // Clear the Checker table if it's not empty
  //     if (checker.isNotEmpty) {
  //       realm.write(() {
  //         realm.deleteAll<Checker>();
  //       });
  //     }
  //
  //     // Add "checked" to the Checker table
  //     realm.write(() {
  //       realm.add(Checker('checked'));
  //     });
  //   }
  //   // Do nothing when unchecked
  // }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    String? userEmail, userPassword;
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                validator: (value) => TValidator.validateEmail(value),
                onChanged: (val) {
                  userEmail = val;
                },
                decoration:  InputDecoration(prefixIcon: const Icon(Iconsax.direct_right), labelText: TTexts.email),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),
              Obx(
                    () => TextFormField(
                  controller: passwordController,
                  validator: (value) => TValidator.validatePassword(value),
                  onChanged: (val){
                    userPassword = val;
                  },
                  obscureText: controller.hidePassword.value,
                  expands: false,
                  decoration: InputDecoration(
                      labelText: TTexts.password,
                      prefixIcon: const Icon(Iconsax.password_check),
                      suffixIcon: IconButton(onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                          icon: Icon(controller.hidePassword.value ? Iconsax.eye : Iconsax.eye_slash))
                  ),
                ),
              ),

              const SizedBox(height: TSizes.spaceBtwInputFields),

               /// Remember Me & Forget Password
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // /// Remember Me
                    // Row(
                    //   children: [
                    //     SizedBox(
                    //       width: 24,
                    //       height: 24,
                    //       child: Checkbox(
                    //         value: _isChecked,
                    //         onChanged: (bool? value) {
                    //           setState(() {
                    //             _isChecked = value!;
                    //             // _updateCheckerTable(_isChecked);
                    //           });
                    //         },
                    //       ),
                    //     ),
                    //     Text(TTexts.rememberMe),
                    //   ],
                    // ),
                    /// Forget Password
                    TextButton(onPressed: () => Get.to(() => const ForgetPassword()), child: Text(TTexts.forgetPassword, style: const TextStyle(color: TColors.primary))),
                  ]
              ),

              const SizedBox(height: TSizes.spaceBtwSections),

              /// sign In Button
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () async {_encryptString(userEmail, userPassword, context);}, child: Text(TTexts.signIn))),
              const SizedBox(height: TSizes.spaceBtwSections),

              const SizedBox(height: TSizes.spaceBtwItems/ 2),
              TFormDivider(dividerText: "don't have an account?"),

              const SizedBox(height: TSizes.spaceBtwSections),
               /// Update Library
              SizedBox(width: double.infinity, child: OutlinedButton(onPressed: () {Get.offAll(const SignupScreen());}, child: const Text("create account"))),
              const SizedBox(height: TSizes.spaceBtwSections),
            ],
          ),
        )
    );
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

  Future<void> _encryptString(String? email, String? password, BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      // Show validation dialog if form validation fails
      validationIssuesScreen(context).show();
      return;
    }

    try {
      String encrypted= encryption(password!,TTexts.encryptKey);
      /// login
      login(email!, encrypted,password,context);
    } on PlatformException catch (e) {
      throw Exception('Problem with encryption $e');
    }
  }
}