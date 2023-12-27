import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../newFeature/CurvedBottomNavBar.dart';
import '../../Login/login_screen.dart';
import '../../System/system_screen.dart';
import '../../Welcome/welcome_screen.dart';

class Auth extends StatelessWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context,snapshot){
          if (snapshot.hasData) {
            return CurvedNavPage();
          }  else{
            return WelcomeScreen();

          }
        }),
      )
    );
  }
}
