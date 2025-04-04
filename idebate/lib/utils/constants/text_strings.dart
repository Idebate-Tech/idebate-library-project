import 'dart:ui' as ui;

class TTexts {
  static String languageCode = ui.window.locale.languageCode;

  // English texts
  static const Map<String, String> enTexts = {

    // -- Onboarding Texts
    'onBoardingTitle1':"Here We Go!",
    'onBoardingTitle2':"Skill Up!",
    'onBoardingTitle3':"Take a break",
    'onBoardingSubTitle1':"Welcome to the iDebate Library App!",
    'onBoardingSubTitle2':"learn something new and moved ahead!",
    'onBoardingSubTitle3':"Relax with a passionate story!",

    'submit':"Submit",
    'appName':"Idebate",
    'tContinue':"Continue",
    'Skip':"Skip",
    'done':"Done",
    'borrow':"Borrow",
    'return': "Return",
    'scanCode':"Scan ISBN code",
    'homeAppbarTitle':"Welcome!",
    'homeAppbarSubTitle':"Your Next read awaits!",
    'returnAppbarTitle':"Thank you!",
    'returnAppbarSubTitle':"We hope you enjoyed your read!",
    'accountCreated':'Account created successfully !🥳',
    'accountCreatedSub': 'Your account has been created successfully! Lets login!',
    'spreadsheetId':'1OawtYBvbfIcNu45kU21nk-rE_Z5nLWCzf53DVQKpyJ0',

    //--- Authentication Form Text
    'firstName':"First Name",
    'lastName':"Last Name",
    'email':"E-mail",
    'password':"Password",
    'newPassword':"New Password",
    'ID':"Natinal ID",
    'phoneNo':"Phone Number",
    'rememberMe':"Remember Me",
    'forgetPassword':"Forgot Password?",
    'signIn':"Sign In",
    'createAccount':"Create Account",
    'orSignInWith':"or sign in with",
    'orSignUpWith':"or Sign Up with",
    'iAgreeTo':"I agree to",
    'privacyPolicy':"Privacy Policy",
    'termsOfUse':"Term of use",
    'verificationCode':"verification Code",
    'resendEmail':"Resend Email",
    'resendEmailIn':"Resend email in",
    'and':"and",
    'or' : "Or",
    'bookName':"Book Name",
    'ISBN':"ISBN Code",
    'returnDate':"Return Date",
    'pickDate':"designated return Date",
    'complete':"Complete! 🥳",
    'completeMessage':"Enjoy your read!",
    'bookNotFound':"Book not found 😔",
    'bookNotFoundMessage':"We couldn't find the book you are looking for.",
    'close':"Close",
    'Filled':"Filed! 📁",
    'FilledMessage1':"Thank you for returning ",
    'FilledMessage2': "We hope you enjoyed it! Please add it to the return box to complete the process 🙂",
    'profile': "Profile",


    //--- Authentication headings Text
    'loginTitle': 'Thinking and Speaking a better world',
    'loginSubTitle': "Login",
    'signupTitle':"let's create your account",
    'forgetPasswordTitle':"Forgot password",
    'forgetPasswordSubtitle':"Don't worry sometimes people can forget too, enter your National ID for verification and reset your password.",
    'changeYourPasswordTitle':"Reset Password",
    'changeYourPasswordSubtitle':"Your Account security is our priority! We've sent you a secure link to safely change your password and keep your Account protected",
    'confirmEmail':"Verify your Email address!",
    'confirmEmailSubtitle': "Congratulations! Your Account awaits: Verify your Email to start.",
    'emailNotReceivedMessage': "Didn't get the email check your junk/spam or resend it.",
    'yourAccountCreatedTitle':"Your account successfully created!",
    'yourAccountCreatedSubtitle': "Welcome to the Idebate Library app! Your next read awaits.",

    'wrongCredentials':'Wrong credentials 😱',
    'wrongCredentialsSub':"The email or password you provided was not correct.",
    'googleSheetNotUpdated':'Not updated 😓',
    'googleSheetNotUpdatedSub':'Failed to update Google Sheet row',
    'idNoMatch':"No matching ID 😦",
    'idNoMatchSub': "No matching row found for natId: ",
    'loadLibraryError':'Error 😬',
    'loadLibraryErrorSub': 'An error occurred while loading the library',
    'notOnline': 'Could not reach the server 😒',
    'notOnlineSub': 'Please ensure you connection is sturdy and try again',
    'ruleOfOne':'Rule of one 🥱',
    'ruleOfOneSub':"Sorry, you can only borrow one book at a time!",
    'libraryUpdate':'Library updated 🙂',
    'libraryUpdateSub':"Your library is currently up to date.",
    'validationIssue':'Validation issues 😶',
    'validationIssueSub':'Please Verify that all the fields are properly validated',
    'passwordResetSuccess':'Password Reset successfully!',
    'passwordResetSuccessSub' : 'Your password has been updated successfully. Please proceed to Login',
    'wrongId':'Wrong ID 🧐',
    'wrongIdSub':'The ID you supplied does not correspond to the one provided on account creation. Verify and try again',
    'recoverAccount' : "An account with the same ID has been found",
    'recoverAccountSub': "Would you like to recover your account ?",
    'recover': "recover"
  };

  // French texts
  static const Map<String, String> frTexts = {

    // -- Onboarding Texts
    'onBoardingTitle1':"Here We Go!",
    'onBoardingTitle2':"Skill Up!",
    'onBoardingTitle3':"Take a break",
    'onBoardingSubTitle1':"Welcome to the iDebate Library App!",
    'onBoardingSubTitle2':"learn something new and moved ahead!",
    'onBoardingSubTitle3':"Relax with a passionate story!",
    'spreadsheetId':'1OawtYBvbfIcNu45kU21nk-rE_Z5nLWCzf53DVQKpyJ0',

    'submit':"Submit",
    'appName':"Idebate",
    'tContinue':"Continue",
    'Skip':"Skip",
    'done':"Done",
    'borrow':"Borrow",
    'return': "Return",
    'scanCode':"Scan ISBN code",
    'complete':"Complete! 🥳",
    'completeMessage':"Enjoy your read!",
    'bookNotFound':"Book not found 😔",
    'bookNotFoundMessage':"We couldn't find the book you are looking for.",
    'close':"Close",
    'Filled':"Filed! 📁",
    'FilledMessage1':"Thank you for returning ",
    'FilledMessage2': "We hope you enjoyed it! Please add it to the return box to complete the process 🙂",
    'profile': "Profile",
    'accountCreated':'Account created successfully !🥳',
    'accountCreatedSub': 'Your account has been created successfully! Lets login!',


    //--- Authentication Form Text
    'firstName':"First Name",
    'lastName':"Last Name",
    'email':"E-mail",
    'password':"Password",
    'newPassword':"New Password",
    'ID':"National ID",
    'phoneNo':"Phone Number",
    'rememberMe':"Remember Me",
    'forgetPassword':"Forgot Password?",
    'signIn':"Sign In",
    'createAccount':"Create Account",
    'orSignInWith':"or sign in with",
    'orSignUpWith':"or Sign Up with",
    'iAgreeTo':"I agree to",
    'privacyPolicy':"Privacy Policy",
    'termsOfUse':"Term of use",
    'verificationCode':"verification Code",
    'resendEmail':"Resend Email",
    'resendEmailIn':"Resend email in",
    'and':"and",
    'or' : "Or",
    'bookName':"Book Name",
    'ISBN':"ISBN Code",
    'returnDate':"Return Date",
    'pickDate':"designated return Date",
    'homeAppbarTitle':"Welcome!",
    'homeAppbarSubTitle':"Your Next read awaits!",
    'returnAppbarTitle':"Thank you!",
    'returnAppbarSubTitle':"We hope you enjoyed your read!",

    //--- Authentication headings Text
    'loginTitle': 'Thinking and Speaking a better world',
    'loginSubTitle': "Login",
    'signupTitle':"let's create your account",
    'forgetPasswordTitle':"Forgot password",
    'forgetPasswordSubtitle':"Don't worry sometimes people can forget too, enter your National ID for verification and reset your password",
    'changeYourPasswordTitle':"Reset Password",
    'changeYourPasswordSubtitle':"Your Account security is our priority! We've sent you a secure link to safely change your password and keep your Account protected",
    'confirmEmail':"Verify your Email address!",
    'confirmEmailSubtitle': "Congratulations! Your Account awaits: Verify your Email to start.",
    'emailNotReceivedMessage': "Didn't get the email check your junk/spam or resend it.",
    'yourAccountCreatedTitle':"Your account successfully created!",
    'yourAccountCreatedSubtitle': "Welcome to the Idebate Library app! Your next read awaits.",
    'wrongCredentials':'Wrong credentials 😱',
    'wrongCredentialsSub':"The email or password you provided was not correct.",
    'googleSheetNotUpdated':'Not updated 😓',
    'googleSheetNotUpdatedSub':'Failed to update Google Sheet row',
    'idNoMatch':"No matching ID 😦",
    'idNoMatchSub': "No matching row found for natId: ",
    'loadLibraryError':'Error 😬',
    'loadLibraryErrorSub': 'An error occurred while loading the library',
    'notOnline': 'Could not reach the server 😒',
    'notOnlineSub': 'Please ensure you connection is sturdy and try again',
    'ruleOfOne':'Rule of one 🥱',
    'ruleOfOneSub':"Sorry, you can only borrow one book at a time!",
    'libraryUpdate':'Library updated 🙂',
    'libraryUpdateSub':"Your library is currently up to date.",
    'validationIssue':'Validation issues 😶',
    'validationIssueSub':'Please Verify that all the fields are properly validated',
    'passwordResetSuccess':'Password Reset successfully!',
    'passwordResetSuccessSub' : 'Your password has been updated successfully. Please proceed to Login',
    'wrongId':'Wrong ID 🧐',
    'wrongIdSub':'The ID you supplied does not correspond to the one provided on account creation. Verify and try again',
    'recoverAccount' : "An account with the same ID has been found",
    'recoverAccountSub': "Would you like to recover your account ?",
    'recover': "recover"
  };

  static String _getText(String key) {
    if (languageCode == 'fr') {
      return frTexts[key] ?? 'Text not found';
    }
    return enTexts[key] ?? 'Text not found';
  }

  static String get passwordResetSuccess => _getText('passwordResetSuccess');
  static String get passwordResetSuccessSub => _getText('passwordResetSuccessSub');
  static String get onBoardingTitle1 => _getText('onBoardingTitle1');
  static String get onBoardingTitle2 => _getText('onBoardingTitle2');
  static String get onBoardingTitle3 => _getText('onBoardingTitle3');
  static String get onBoardingSubTitle1 => _getText('onBoardingSubTitle1');
  static String get onBoardingSubTitle2 => _getText('onBoardingSubTitle2');
  static String get onBoardingSubTitle3 => _getText('onBoardingSubTitle3');
  static String get accountCreated => _getText('accountCreated');
  static String get accountCreatedSub => _getText('accountCreatedSub');
  static String get spreadsheetId => _getText('spreadsheetId');
  static String get googleSheetNotUpdated => _getText('googleSheetNotUpdated');
  static String get googleSheetNotUpdatedSub => _getText('googleSheetNotUpdatedSub');
  static String get idNoMatch => _getText('idNoMatch');
  static String get idNoMatchSub => _getText('idNoMatchSub');
  static String get loadLibraryError => _getText('loadLibraryError');
  static String get loadLibraryErrorSub => _getText('loadLibraryErrorSub');
  static String get notOnline => _getText('notOnline');
  static String get notOnlineSub => _getText('notOnlineSub');
  static String get ruleOfOne => _getText('ruleOfOne');
  static String get ruleOfOneSub => _getText('ruleOfOneSub');
  static String get libraryUpdate => _getText('libraryUpdate');
  static String get libraryUpdateSub => _getText('libraryUpdateSub');
  static String get validationIssue => _getText('validationIssue');
  static String get validationIssueSub => _getText('validationIssueSub');
  static String get wrongId => _getText('wrongId');
  static String get wrongIdSub => _getText('wrongIdSub');


  static String get submit => _getText('submit');
  static String get appName => _getText('appName');
  static String get tContinue => _getText('tContinue');
  static String get skip => _getText("Skip");
  static String get done => _getText("done");
  static String get borrow => _getText("borrow");
  static String get bringBack => _getText("return");
  static String get homeAppbarTitle => _getText("homeAppbarTitle");
  static String get homeAppbarSubTitle => _getText("homeAppbarSubTitle");
  static String get returnAppbarTitle => _getText("returnAppbarTitle");
  static String get returnAppbarSubTitle => _getText("returnAppbarSubTitle");
  static String get recoverAccount => _getText("recoverAccount");
  static String get recoverAccountSub => _getText("recoverAccountSub");
  static String get recover => _getText("recover");

  static String get complete => _getText('complete');
  static String get completeMessage => _getText('completeMessage');
  static String get bookNotFound => _getText('bookNotFound');
  static String get bookNotFoundMessage => _getText('bookNotFoundMessage');
  static String get close => _getText('close');
  static String get Filled => _getText('Filled');
  static String get FilledMessage1 => _getText('FilledMessage1');
  static String get FilledMessage2 => _getText('FilledMessage2');

  static String get loginTitle => _getText('loginTitle');
  static String get loginSubTitle => _getText('loginSubTitle');
  static String get signupTitle => _getText('signupTitle');
  static String get forgetPasswordTitle => _getText('forgetPasswordTitle');
  static String get forgetPasswordSubtitle => _getText('forgetPasswordSubtitle');
  static String get changeYourPasswordTitle => _getText('changeYourPasswordTitle');
  static String get changeYourPasswordSubTitle => _getText('changeYourPasswordSubtitle');
  static String get confirmEmail => _getText('confirmEmail');
  static String get confirmEmailSubtitle => _getText('confirmEmailSubtitle');
  static String get emailNotReceivedMessage => _getText('emailNotReceivedMessage');
  static String get yourAccountCreatedTitle => _getText('yourAccountCreatedTitle');
  static String get yourAccountCreatedSubtitle => _getText('yourAccountCreatedSubtitle');

  static String get firstName => _getText('firstName');
  static String get lastName => _getText('lastName');
  static String get email => _getText('email');
  static String get password => _getText('password');
  static String get newPassword => _getText('newPassword');
  static String get ID => _getText('ID');
  static String get phoneNo => _getText('phoneNo');
  static String get rememberMe => _getText('rememberMe');
  static String get forgetPassword => _getText('changeYourPasswordTitle');
  static String get signIn => _getText('signIn');
  static String get createAccount => _getText('createAccount');
  static String get orSignInWith => _getText('orSignInWith');
  static String get orSignUpWith => _getText('orSignUpWith');
  static String get iAgreeTo => _getText('iAgreeTo');
  static String get privacyPolicy => _getText('privacyPolicy');
  static String get termsOfUse => _getText('termsOfUse');
  static String get verificationCode => _getText('verificationCode');
  static String get resendEmail => _getText('resendEmail');
  static String get resendEmailIn => _getText('resendEmailIn');

  static String get and => _getText('and');
  static String get or => _getText('or');
  static String get scanCode => _getText('scanCode');
  static String get wrongCredentials => _getText('wrongCredentials');
  static String get wrongCredentialsSub => _getText('wrongCredentialsSub');

  static String get bookName => _getText('bookName');
  static String get ISBN => _getText('ISBN');
  static String get returnDate => _getText('returnDate');
  static String get pickDate => _getText('pickDate');
  static String get profile => _getText('profile');
}
