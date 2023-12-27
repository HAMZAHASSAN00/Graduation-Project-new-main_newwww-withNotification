
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/Signup/signup_screen.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/firebase_options.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'Screens/Signup/components/choose_tank_photo/sliderTank/screensSlider/TankSlideShow.dart';
import 'Screens/Signup/components/choose_tank_photo/sliderTank/screensSlider/OtherTankSize.dart';
import 'Screens/Signup/firebase/auth.dart';
import 'Screens/System/system_screen.dart';
import 'controller/dependency_injection.dart';
import 'network/local/cache_helper.dart';
import 'newFeature/CurvedBottomNavBar.dart';
import 'newFeature/Google_Bottom_Bar.dart';
import 'newFeature/Simple_Onboarding_Page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'newFeature/aboutUs.dart';
import 'newFeature/howTheSystemWork.dart';
import 'newFeature/notification.dart';
import 'newFeature/profileUI/ProfileScreen.dart';
import 'newFeature/setting/resetPassword/reser_password.dart';
import 'newFeature/setting/setting.dart';
import 'newFeature/theme.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  await CacheHelper.init();

  //OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

  OneSignal.initialize("9825dcdb-7434-420a-894a-1801f017386c");
  // OneSignal.Notifications.requestPermission(true);
  // print('form main : ${OneSignal.User.pushSubscription.id}');
  // OneSignal.Notifications.addClickListener(
  //   (event) {
  //   print("all events: $event");
  //   print("body is: ${event.notification.body}");
  // });
    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      CacheHelper.saveNotification(
        key: 'notification_${DateTime.now().millisecondsSinceEpoch}',
        notificationMessage: '${event.notification.body}',
      );
      print("body is indedededed main: ${event.notification.body}");
    });

  final fcmToken = await FirebaseMessaging.instance.getToken();
  print(fcmToken);
// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission


  DependencyInjection.init();
   runApp(ProviderScope(child: MyApp()));

}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final _themeNotifier = ref.watch(themeNotifierProvider);
    print(OneSignal.User.pushSubscription.id);
    return GetMaterialApp(
        themeMode: _themeNotifier.themeMode,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Auth',
        theme: ThemeData(
            primaryColor: kPrimaryColor,
            scaffoldBackgroundColor: Colors.white,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: kPrimaryColor,
                shape: const StadiumBorder(),
                maximumSize: const Size(double.infinity, 56),
                minimumSize: const Size(double.infinity, 56),
              ),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              filled: true,
              fillColor: kPrimaryLightColor,
              iconColor: kPrimaryColor,
              prefixIconColor: kPrimaryColor,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: defaultPadding, vertical: defaultPadding),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide.none,
              ),
            )),
        //home: const Auth(),
        routes: {
          '/':(context) => const Auth(),
          'welcomeScreen':(context) => const WelcomeScreen(),
          'loginScreen':(context) => const LoginScreen(),
          'signupScreen':(context) => const SignUpScreen(),
          'system':(context) => const SystemScreen(),
          'Onboarding':(context) => const OnboardingPage1(),
          'GoogleBottomBar':(context) => const GoogleBottomBar(),
          'ThemePage':(context) => const ThemePage(),
          'ProfileScreen':(context) => ProfileScreen(),
          'AboutUsPage':(context) => AboutUsPage(),
          'HowItWorksPage':(context) => HowItWorksPage(),
          'NotificationPage':(context) => NotificationPage(notifications: ['note 1'],),
          'CurvedNavPage':(context) => CurvedNavPage(),
          'SettingsPage':(context) => SettingsPage(),
          'PasswordResetPage':(context) => PasswordResetPage(),
          'TankSlideShow':(context)=>const TankSlideShow(),
          'OtherTankSize':(context)=>OtherTankSize(),



        }
    );
  }
}
