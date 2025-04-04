import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:idebate/features/activities/controllers/gsheet_controller.dart';
import 'package:idebate/utils/constants/sizes.dart';
import 'package:realm/realm.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/validators/validation.dart';
import '../../../activities/models/realm_local_storage.dart';
import '../../controllers/signup/signup_controller.dart';
import '../../encryption/encryption.dart';

var config = Configuration.local([Profile.schema]);
var realm = Realm(config);
final person = realm.all<Profile>();

final _formKey = GlobalKey<FormState>();
class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    var nationalIdController = TextEditingController();
    var passwordController = TextEditingController();
    String userNatId = "",userPassword = "";
    return Scaffold(
      appBar: AppBar(),
      body:  Padding(padding: const  EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Headings
            Text(TTexts.forgetPasswordTitle, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(TTexts.forgetPasswordSubtitle, style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: TSizes.spaceBtwSections * 2),

            Form(
              key: _formKey,
              child: Column(
                /// ID
                children: [
                  TextFormField(
                    controller: nationalIdController,
                    validator: (value) => TValidator.validateNationalId(value),
                    onChanged: (val){
                      userNatId = val;
                    },
                    expands: false,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: TTexts.ID, prefixIcon: const Icon(Iconsax.card)),
                  ),

                  const SizedBox(height: TSizes.spaceBtwItems),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  Text("Enter your new password below", style: Theme.of(context).textTheme.labelMedium,textAlign: TextAlign.left),

                  const SizedBox(height: TSizes.spaceBtwItems),
                  /// Password
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
                ],
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwItems),

            /// Submit Button
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () {_encryptString(userNatId,userPassword,context);}, child:Text(TTexts.submit)))
          ],
        ),
      ),
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

  AwesomeDialog wrongIdScreen(BuildContext context) {
    return AwesomeDialog(
      context: context,
      width: 500,
      headerAnimationLoop: false,
      dialogType: DialogType.noHeader,
      title: TTexts.wrongId,
      desc: TTexts.wrongIdSub,
      btnOkColor: Colors.redAccent,
      btnOkText: TTexts.close,
      btnOkOnPress: () => {},
    );
  }

  Future<void> _encryptString(String natId, String password, BuildContext context) async
  {

    if(natId != person.first.nationalId)
      {
        wrongIdScreen(context).show();
      }
    else
      {
        if (!_formKey.currentState!.validate()) {
          validationIssuesScreen(context).show();
          return;
        }
        try {
          // Native call to encrypt the password
          String encrypted= encryption(password,natId);
          /// update new password
          updatePassword(encrypted, natId, context);
        } on PlatformException catch (e) {
          throw Exception('Problem with encryption $e');
        }
      }
  }
}
