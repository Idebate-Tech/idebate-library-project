import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:idebate/features/authentication/screens/login/login.dart';
import 'package:idebate/features/authentication/screens/onboarding/onboarding.dart';
import 'package:idebate/navigation_menu.dart';
import 'package:idebate/utils/theme/theme.dart';
// import 'package:realm/realm.dart';
// import 'features/activities/models/realm_local_storage.dart';
import 'main.dart';


// var config = Configuration.local([Profile.schema,Checker.schema]);
// var realm = Realm(config);
// RealmResults<Profile> person = realm.all<Profile>();
// RealmResults<Checker> checker = realm.all<Checker>();


class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  void initState()
  {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      home: redirect(),
    );
  }
}


Widget redirect(){
// if( person.isNotEmpty)
// {
//   if(checker.isEmpty)
//     {
//       return const LoginScreen();
//     }
//   return const NavigationMenu();
// }
//
// return const OnboardingScreen();

  return const LoginScreen();
}