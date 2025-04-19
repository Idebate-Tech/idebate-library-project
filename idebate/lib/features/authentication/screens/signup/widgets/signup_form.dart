import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:idebate/features/activities/controllers/gsheet_controller.dart';
import 'package:idebate/features/authentication/controllers/signup/signup_controller.dart';
import 'package:idebate/features/authentication/encryption/encryption.dart';
import 'package:idebate/utils/validators/validation.dart';
// import '../../../../../common/widgets/otp_screen/otp_screen.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';



final _formKey = GlobalKey<FormState>();
EmailOTP myAuth = EmailOTP();
class TSignupForm extends StatelessWidget {
  const TSignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final dark = THelperFunctions.isDarkMode(context);

    final controller = Get.put(SignupController());
    var firstNameController = TextEditingController();
    var lastNameController = TextEditingController();
    var nationalIdController = TextEditingController();
    var emailController = TextEditingController();
    var phoneNumberController = TextEditingController();
    var passwordController = TextEditingController();
    String? userNatId, userEmail, userPhoneNumber, userPassword, userFirstname, userLastName;
    return Form(
        key: _formKey,
        child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: firstNameController,
                validator: (value) => TValidator.validateEmptyText("First Name", value),
                expands: false,
                onChanged: (val){
                  userFirstname = val;
                },
                decoration: InputDecoration(
                    labelText: TTexts.firstName,
                    prefixIcon: const Icon(Iconsax.user)),
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwInputFields),
            Expanded(
              child: TextFormField(
                controller: lastNameController,
                validator: (value) => TValidator.validateEmptyText("Last Name", value),
                expands: false,
                onChanged: (val){
                  userLastName = val;
                },
                decoration: InputDecoration(
                    labelText: TTexts.lastName,
                    prefixIcon: const Icon(Iconsax.user)),
              ),
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// ID
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
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// Email
        TextFormField(
          controller: emailController,
          validator: (value) => TValidator.validateEmail(value),
          onChanged: (val){
            userEmail = val;
          },
          expands: false,
          decoration: InputDecoration(
              labelText: TTexts.email, prefixIcon: const Icon(Iconsax.direct)),
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

        /// Phone Number
        TextFormField(
          controller: phoneNumberController,
          validator: (value) => TValidator.validatePhoneNumber(value),
          onChanged: (val){
            userPhoneNumber = val;
          },
          keyboardType: TextInputType.number,
          expands: false,
          decoration: InputDecoration(
              labelText: TTexts.phoneNo, prefixIcon: const Icon(Iconsax.call)),
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),

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
        const SizedBox(height: TSizes.spaceBtwInputFields),

        // /// Terms&Condition Checkbox
        // const TTermsAndConditionCheckbox(),
        // const SizedBox(height: TSizes.spaceBtwSections),

        /// Sign Up Button
        SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () async {
                    _encryptString(userFirstname, userLastName, userEmail, userNatId,userPhoneNumber, userPassword,Get.context!);
                },
                child: Text(TTexts.createAccount)))
      ],
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



  Future<void> _encryptString(String? fName, String? lName, String? email, String? natId, String? phoneNumber, String? password, BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      // Show validation dialog if form validation fails
      validationIssuesScreen(context).show();
      return;
    }

    try {
      // Native call to encrypt the password
     String encrypted= encryption(password!,TTexts.encryptKey);
     addNewuser(fName!,lName!,email!,natId!,phoneNumber!,encrypted, context);
    } on PlatformException catch (e) {
      throw Exception('Problem with encryption $e');
  }

}
}
