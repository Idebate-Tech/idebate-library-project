import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:email_otp/email_otp.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
// import 'package:idebate/features/activities/screens/borrow.dart';
import 'package:idebate/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/validators/validation.dart';
import '../../../features/activities/controllers/gsheet_controller.dart';
import '../../../features/authentication/controllers/signup/signup_controller.dart';



final _formKey = GlobalKey<FormState>();
class OtpScreen extends StatefulWidget {
  final String fName;
  final String lName;
  final String email;
  final String natId;
  final String phoneNumber;
  final String password;
  const OtpScreen({super.key, required this.fName,required this.lName,required this.email,required this.natId,required this.phoneNumber,required this.password});

  @override
  OtpScreenState createState() => OtpScreenState();
}

class OtpScreenState extends State<OtpScreen>
{
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    var otpController = controller.otp;
    String otp = "";
    return Scaffold(
      appBar: AppBar(),
      body:  Padding(padding: const  EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Headings
            Text("Is this really you 🤔?", style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text("We've sent you a One Time Password to this E-mail ${widget.email}. Verify your email and enter the 6 digit otp in the field provided", style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: TSizes.spaceBtwSections * 2),

            Form(
              key: _formKey,
              child: Column(
                /// otp
                children: [
                  TextFormField(
                    controller: otpController,
                    validator: (value) => TValidator.validateOtp(value),
                    onChanged: (val){
                      otp = val;
                    },
                    expands: false,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText:"OTP", prefixIcon: const Icon(Iconsax.card)),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  /// verify Button
                  SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () async {
                    if (EmailOTP.verifyOTP(otp: otp)) {
                          addNewuser(widget.fName, widget.lName, widget.email, widget.natId, widget.phoneNumber, widget.password, context);
                    } else {
                      ScaffoldMessenger.of(Get.context!).showSnackBar(
                          const SnackBar(content: Text("OTP is invalid")));
                    }
                  }, child:Text("verify"))),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  Text("Didn't receive an otp? Don't worry! click button below to resend the otp. ", style: Theme.of(context).textTheme.labelMedium,textAlign: TextAlign.left,),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  /// verify Button
                  SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () async {
                    if (await EmailOTP.sendOTP(email: widget.email)) {
                      ScaffoldMessenger.of(Get.context!).showSnackBar(
                          const SnackBar(content: Text("OTP has been re-sent")));
                    } else {
                      ScaffoldMessenger.of(Get.context!).showSnackBar(
                          const SnackBar(content: Text("OTP failed re-sent")));
                    }
                  }, child:Text("resend")))
                ],
              ),
            ),

            const SizedBox(height: TSizes.spaceBtwItems),

          ],
        ),
      ),
    );
  }

  void main() {
    EmailOTP.config(
      appName: 'MyApp',
      otpType: OTPType.numeric,
      expiry: 3000,
      appEmail: 'me@rohitchouhan.com',
      emailTheme: EmailTheme.v5,
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
}
